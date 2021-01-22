#!/bin/bash
cd ~
"$HOME"/m2ag-labs/installer/extras/motion/install.sh
#TODO: setup motion file

sudo pip3 install adafruit-circuitpython-pca9685
sudo pip3 install adafruit-circuitpython-ads1x15
# get the needed components.
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/components/ads1015/ads1015.py
mv ads1015.py "$HOME/m2ag-labs/device/hardware/components/"
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/components/ads1015/ads1015.json
mv ads1015.json "$HOME/m2ag-labs/config/available/components/"
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/components/pca9685/pca9685.py
mv pca9685.py "$HOME/m2ag-labs/device/hardware/components/"
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/components/pca9685/pca9685.json
mv pca9685.json "$HOME/m2ag-labs/config/available/components/"
#add the sentry specific things
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/things/raspisentry/ads1x15.json
mv ads1x15.json "$HOME/m2ag-labs/config/available/things/"
wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/things/raspisentry/pca9685.json
mv pca9685.json "$HOME/m2ag-labs/config/available/things/"





