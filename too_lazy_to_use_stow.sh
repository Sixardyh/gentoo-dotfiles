#!/bin/sh

LIST_FILES="
  /usr/local/bin/upgrade-kernel.sh
  /usr/local/bin/update-gentoo.sh
  $HOME/.config/herbstluftwm/
  /etc/portage/
  /usr/local/portage/profiles/
  /proc/config.gz
  $HOME/.vimrc
  $HOME/.config/polybar/
  $HOME/.config/rofi
  $HOME/.config/neofetch
  $HOME/.config/dunst
"

for f in $LIST_FILES ; do
  # hardcoded exceptions
  if [ "$f" = "/usr/local/portage/profiles/" ] ; then
    cp -r "$f" custom_profiles
  elif [ "$f" = "/proc/config.gz" ] ; then
    zcat "$f" > kernel."$(uname -r)".config
  else
    cp -r "$f" .
  fi
done

