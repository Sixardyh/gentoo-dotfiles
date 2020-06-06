#!/bin/sh
# My personal script to update gentoo. Does not include kernel building.
# Also includes updatedb (mlocate)

PARAMETERS="$*"

# Edit this variable (between quotes) to specify the list of packages
# that should be excluded by default.
EXCLUDED_PACKAGES=""

help() {
  echo "List of parameters:"
  echo "-------------------"
  echo
  echo "--changed-deps      Run emerge with --changed-deps"
  echo
  echo "--exclude           Opens a prompt asking for"
  echo "                    a list of packages to exclude"
  echo
  echo "--help, -h          Show this menu"
  echo
  echo "--gcc-upgrade       Run this if a GCC upgrade is available."
  echo
  echo "--no-live-rebuild   Skip updating live ebuilds via smart-live-rebuild"
  echo
  echo "--no-test-obsolete  Skip eix-test-obsolete and portpeek"
  echo
  echo "--skip-sync         Skip syncing packages via eix-sync"
  echo
  echo "--system-first      Update @system before updating @world"
  echo "                    (may be useful if last update was a long time ago)"
  echo
  echo "--system-rebuild    Rebuild @system. Only 'useful' when there's a gcc upgrade,"
  echo "                    so ineffective if --gcc-upgrade isn't specified"
  echo
  echo "--time              Estimate upgrade time via genlop"
  echo "                    (may take a bit of time)"
  exit
}

log() {
  printf "\\n\\n\\e[1m \\e[96m*\\e[39m %s\\e[21m\\n\\n" "$1"
}

argparse() {
  # Simple function to pass parameters to.
  # Returns 0 if the passed parameter was specified by the user
  echo "$PARAMETERS" | grep -i "\\$1" > /dev/null && return 0
  return 1
}

exclude() {
  echo "Type a space separated list of packages you want to exclude, followed by ENTER: "
  printf "> "
  read -r e
  EXCLUDED_PACKAGES="${EXCLUDED_PACKAGES} ${e}"
}

test_obsolete() {
#  log "Running eix-test-obsolete..."
#  eix-test-obsolete
  log "Running portpeek..."
  portpeek -ar | grep -vE 'Could not find file |No ebuild options found'
}

gcc_upgrade() {
  echo "What GCC version are you upgrading to?"
  printf "> "
  read -r version
  emerge -av1 sys-devel/gcc
  gcc-config --list-profiles | grep "$version" | grep -Eo "[0-9]" | head -1 | xargs gcc-config
  . /etc/profile
  emerge -cq sys-devel/gcc
  emerge -q1 glibc libtool llvm clang wxpython wxGTK
  argparse '--system-rebuild' && argparse '--time' && emerge -pev @system --exclude "glibc libtool llvm clang gcc wxGTK wxpython $EXCLUDED_PACKAGES" | genlop -p
  argparse "--system-rebuild" && emerge -aev @system --exclude "glibc libtool llvm clang gcc wxGTK wxpython $EXCLUDED_PACKAGES"
  dispatch-conf
  revdep-rebuild
}

echo "$PARAMETERS" | grep -iE "\\-h|\\--help" > /dev/null && help
if [ "$(whoami)" != "root" ] ; then
  log "This script (probably) won't run properly without root permissions."
fi

argparse "--exclude" && exclude
argparse "--skip-sync" || eix-sync

mkdir /var/tmp/notmpfs  # used for packages using the notmpfs.conf env
argparse "--gcc-upgrade" && gcc_upgrade
argparse '--system-first' && argparse '--time' &&  emerge -puvDU @system --complete-graph=y --backtrack=1000 --with-bdeps=y --keep-going --exclude "$EXCLUDED_PACKAGES" | genlop -p
argparse '--system-first' &&  emerge -auvDU @system --complete-graph=y --backtrack=1000 --with-bdeps=y --keep-going --exclude "$EXCLUDED_PACKAGES" --verbose-conflicts

if argparse "--changed-deps" ; then
  argparse '--time' && emerge -puvDU @world --complete-graph=y --backtrack=1000 --with-bdeps=y --keep-going --exclude "$EXCLUDED_PACKAGES" --changed-deps | genlop -p
  emerge -auvDU @world --complete-graph=y --backtrack=1000 --with-bdeps=y --keep-going --exclude "$EXCLUDED_PACKAGES" --verbose-conflicts --changed-deps
else
  argparse '--time' && emerge -puvDU @world --complete-graph=y --backtrack=1000 --with-bdeps=y --keep-going --exclude "$EXCLUDED_PACKAGES" | genlop -p
  emerge -auvDU @world --complete-graph=y --backtrack=1000 --with-bdeps=y --keep-going --exclude "$EXCLUDED_PACKAGES" --verbose-conflicts
fi
argparse "--no-live-rebuild" || smart-live-rebuild | grep Failed

log "Depcleaning..."
emerge -caq
log "Emerging preserved-rebuild..."
emerge -q1 @preserved-rebuild --exclude "$EXCLUDED_PACKAGES"

log "Running revdep-rebuild..."
revdep-rebuild -qi
log "Running eclean-dist..."
eclean-dist -qd
log "Running dispatch-conf..."
dispatch-conf
argparse '--no-test-obsolete' || test_obsolete
emerge --check world
eselect news read
log "Running updatedb..."
updatedb

