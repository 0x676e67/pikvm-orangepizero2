# pikvm-orangepizero2

Christoph, St.Gallen, Swiss

31 March 2023 


Have a look:

https://github.com/xe5700/kvmd-armbian/issues/12

0)
Proper wright a SDcard
======================
http://www.industrie-optimierer.ch/tmp/mksdcardpi/
(be carefull, danger !! ,  but it works )


1)
On any other Pi Boards Brands
=============================
You must make the DTB Files yourself for USB-OTG Support. Have a look in the pdf.

First Boot:
-----------
apt update && sync && apt -y upgrade
apt -y install git curl wget avahi-daemon ntp
sync
reboot


Second Boot:
-------------
Don't use Custom Patches, say N !!!

git clone https://github.com/xe5700/kvmd-armbian.git
cd kvmd-armbian
mv install.sh install.sh.bak
mv config.sh config.sh.bak
wget http://www.industrie-optimierer.ch/tmp/PiKVM/PiKVM_OrangePizero2/install.sh
wget http://www.industrie-optimierer.ch/tmp/PiKVM/PiKVM_OrangePizero2/config.sh
chmod +x install.sh
./install.sh


Third Boot:
-----------
cd kvmd-armbian
./install.sh


2)
For my OrangePi Zero 2 H616/1GByte this is my best Solution   17 Feb 2023
=====================================================================================================
I use a OrangePI OS Ubuntu Jammy Server, then a Armbian Community Kernel 6.1.6, how long it works? ??
  (Meaning Dependend on Kernels)
======================================================================================================
- I hope OrangePI make themself later a moderner proper Kernel with USB OTG Module Support 
- This boots very save up, and Mass Storage Drive work too
- With this way you loose wlan onboard, but you can use a suitable USB-Wlan Stick or use the LAN eth
- If you Wlan Stick fits, then orangepi-config Network Wifi 
- I use  "Microware Video Capture USB Device" for HDMI Capture Video
******************************************************************************************************
First Boot:
-----------
apt update && sync && apt -y upgrade
apt -y install avahi-daemon git curl wget ntp
mv /boot/dtb/allwinner/sun50i-h616-orangepi-zero2.dtb /boot/dtb/allwinner/sun50i-h616-orangepi-zero2.dtb.bak
wget http://www.industrie-optimierer.ch/tmp/PiKVM/PiKVM_OrangePizero2/sun50i-h616-orangepi-zero2.dtb -O /boot/dtb/allwinner/sun50i-h616-orangepi-zero2.dtb

printf "\ndeb [signed-by=/usr/share/keyrings/armbian.gpg] http://beta.armbian.com jammy main jammy-utils jammy-desktop\n" >> /etc/apt/sources.list
curl -fsSL http://fi.mirror.armbian.de/beta/armbian.key | sudo gpg --dearmor -o /usr/share/keyrings/armbian.gpg

apt update
apt -y install linux-image-edge-sunxi64

sync
reboot


Second Boot:
-------------
Don't use Custom Patches, say N !!!

git clone https://github.com/xe5700/kvmd-armbian.git
cd kvmd-armbian
mv install.sh install.sh.bak
mv config.sh config.sh.bak
wget http://www.industrie-optimierer.ch/tmp/PiKVM/PiKVM_OrangePizero2/install.sh
wget http://www.industrie-optimierer.ch/tmp/PiKVM/PiKVM_OrangePizero2/config.sh
chmod +x install.sh
./install.sh


Third Boot:
-----------
cd kvmd-armbian
./install.sh


3)
Other Stuff:
============

Mass Storage Drive:
-------------------
You can add a USB-Stick with sda1 ext4 an add in /etc/fstab this line:
/dev/sda1  /var/lib/kvmd/msd   ext4  nodev,nosuid,noexec,ro,errors=remount-ro,data=journal,X-kvmd.otgmsd-root=/var/lib/kvmd/msd,X-kvmd.otgmsd-user=kvmd  0  0

and in /etc/kvmd/override.yaml (deacitvate #msd type):
    hid:
        mouse_alt:
            device: /dev/kvmd-hid-mouse-alt  # allow absolute/relative mouse mode
#    msd:
#        type: disabled
.
.

save and then... 
reboot

Or you resize the sdcard, und make there a second ext4 partiton for MSD (with sudo gparted, must be unmounted for that, but i don't explain detailed here)


Change kvmd User Password:
--------------------------
Only in a Terminal:
And change the password: kvmd-htpasswd set admin, or new user kvmd-htpasswd set NewUserName

ATX Support:
------------
Have a look in the pdf...
( /usr/local/lib/python3.10/dist-packages/kvmd/plugins/atx/gpio.py )


Fix for "Microware Video Capture USB Device":
---------------------------------------------
Have a look to the repvideo file... and boot it up in rc.local

wget http://www.industrie-optimierer.ch/tmp/PiKVM/PiKVM_OrangePizero2/repvideo -O /usr/local/bin/repvideo
chmod 755 /usr/local/bin/repvideo

nano /etc/rc.local
.
.
.

# Reboot "Microware Video Capture USB Device" on startup
`sleep 10; exec /usr/local/bin/repvideo >/dev/null 2>&1` &

exit 0

save it! done.
