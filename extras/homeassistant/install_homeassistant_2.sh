#!/bin/bash
# https://www.home-assistant.io/docs/installation/raspberry-pi/

cd ~
cd homeassistant
python3.9 -m venv .
source bin/activate
python3 -m pip install wheel
pip3 install homeassistant
# add service
sudo cp "$HOME"/m2ag-labs/installer/extras/homeassistant/m2ag-homeassistant.service /etc/systemd/system/m2ag-homeassistant.service
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/systemd/system/m2ag-homeassistant.service
sudo sed -i 's*--USER--*'"$USER"'*g' /etc/systemd/system/m2ag-homeassistant.service
sudo systemctl daemon-reload
sudo systemctl enable m2ag-homeassistant
sudo systemctl start m2ag-homeassistant
