#!/bin/sh

LIST_FILES="
  /usr/local/bin/upgrade-kernel.sh
  /usr/local/bin/update-gentoo.sh
  $HOME/.config/herbstluftwm/
  /etc/portage/
  /usr/local/portage/profiles/
"

for f in $LIST_FILES ; do
  # hardcoded exceptions
  if [ "$f" = "/usr/local/portage/profiles/" ] ; then
    cp -r "$f" custom_profiles
  else
    cp -r "$f" .
  fi
done

