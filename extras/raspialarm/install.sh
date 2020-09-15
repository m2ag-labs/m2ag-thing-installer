#!/bin/bash
# assumes screen drivers are installed and functional

# ensure root ca is imported for chromium.

# install lis3dh, veml7000, and audio support

# get the needed components.
sudo pip3 install adafruit-circuitpython-lis3dh
sudo pip3 install adafruit-circuitpython-veml7700



#wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/components/raspipwm/init_raspi_hw_pwm.py
#mv init_raspi_hw_pwm.py "$HOME/m2ag-labs/device/hardware/components/"
#wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/components/raspipwm/raspipwm.json
#mv raspipwm.json "$HOME/m2ag-labs/config/available/components/"
#wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/components/raspipwm/raspipwm.py
#mv raspipwm.py "$HOME/m2ag-labs/device/hardware/components/"
#add the add the alarm ui specific things
#wget https://raw.githubusercontent.com/m2ag-labs/m2ag-iot-things/master/things/raspicam/raspicam.json
#mv raspicam.json "$HOME/m2ag-labs/config/available/things/"





