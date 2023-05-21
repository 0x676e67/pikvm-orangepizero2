#!/bin/bash

git clone https://github.com/orangepi-xunlong/orangepi-build -b next
cp orangepizero2-u-boot.dts ./orangepi-build/external/packages/pack-uboot/sun50iw9/bin/dts/orangepizero2-u-boot.dts
cp usb-gadget-f_mass_storage-forced-eject.patch ./orangepi-build/external/patch/misc/usb-gadget-f_mass_storage-forced-eject.patch

cd orangepi-build
sudo bash +x ./build.sh