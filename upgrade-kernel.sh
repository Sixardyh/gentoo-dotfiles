#!/bin/sh

printf "\\n\\nMAKE SURE THE SYMLINK IS SET AND THAT THE KERNEL IS CONFIGURED!!!!!\\n\\n"
sleep 3

cd /usr/src/linux || exit
cp .config ../.config.bak
make distclean
mv ../.config.bak .config

make modules_prepare
emerge -q @module-rebuild
time make -j8
make modules_install
mount /boot
make install
cp /boot/EFI/gentoo/bootx64.efi /boot/EFI/gentooold/bootx64.efi
cp arch/x86_64/boot/bzImage /boot/EFI/gentoo/bootx64.efi

printf "\\n\\nUpgrade done! Make sure to cleanup the old kernels if needed.\\n\\n"
