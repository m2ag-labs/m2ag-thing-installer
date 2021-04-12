#!/bin/bash
cd ~
# TODO: check to see if motion is installed

# "$HOME"/m2ag-labs/installer/extras/motion/install.sh
#TODO: setup motion file

# get the needed components.
sudo apt install raspicam
sudo pip3 install wiringpi

wget https://raw.githubusercontent.com/m2ag-labs/m2ag-things/master/components/raspipwm/init_raspi_hw_pwm.py
mv init_raspi_hw_pwm.py "$HOME/m2ag-labs/device/hardware/components/"
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-things/master/components/raspipwm/raspipwm.json
mv raspipwm.json "$HOME/m2ag-labs/config/available/components/"
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-things/master/components/raspipwm/raspipwm.py
mv raspipwm.py "$HOME/m2ag-labs/device/hardware/components/"
#add the sentry specific things
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-things/master/things/raspicam/raspicam.json
sed -i 's*--HOSTNAME--*'"$HOSTNAME"'*g' raspicam.json
mv raspicam.json "$HOME/m2ag-labs/config/available/things/"
# get the ui files
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-things/master/extras/raspicam/raspicam.html
mv raspicam.html "$HOME/m2ag-labs/client/ui/"





