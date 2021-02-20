#!/bin/bash
# Install a service to run a neopixel as an indicator
cd ~
if [ ! -d "$HOME/.m2ag-labs" ]; then
    mkdir "$HOME/.m2ag-labs"
fi
if [ ! -d "$HOME/.m2ag-labs/services" ]; then
    mkdir "$HOME/.m2ag-labs/services"
fi
if [ ! -d "$HOME/.m2ag-labs/indicator" ]; then
    mkdir "$HOME/.m2ag-labs/indicator"
fi
#get the thing and component
wget "https://raw.githubusercontent.com/m2ag-labs/m2ag-things/main/components/indicator/indicator.json"
mv indicator.json m2ag-labs/config/available/components
wget "https://raw.githubusercontent.com/m2ag-labs/m2ag-things/main/components/indicator/indicator.py"
mv indicator.py m2ag-labs/device/hardware/components
wget "https://raw.githubusercontent.com/m2ag-labs/m2ag-things/main/things/indicator/indicator.json"
mv indicator.json m2ag-labs/config/available/things

cp "$HOME"/indicator_service.py "$HOME/.m2ag-labs/services/indicator"
sudo cp "$HOME"/m2ag-labs/installer/extras/indicator/m2ag-indicator.service /etc/systemd/system/m2ag-indicator.service
sudo systemctl daemon-reload
sudo systemctl enable m2ag-indicator
sudo systemctl start m2ag-indicator
