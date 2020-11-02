#!/bin/bash
sh -c "echo 'dtoverlay=i2c-rtc,ds1307' >> /boot/config.txt"
systemctl disable fake-hwclock
apt-get -y remove fake-hwclock
update-rc.d -f fake-hwclock remove
cp "$HOME"/m2ag-labs/installer/extras/rtc/lib/udev/hwclock-set /lib/udev
