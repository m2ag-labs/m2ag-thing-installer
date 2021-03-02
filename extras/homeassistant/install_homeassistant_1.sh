#!/bin/bash
# https://www.home-assistant.io/docs/installation/raspberry-pi/
cd ~
if [[ ! -f "$HOME/.m2ag-labs/ssl/rootca.crt" ]]
then
    echo "The installer expects to find ~/.m2ag-labs/ssl/rootca.crt"
    exit
fi
sudo apt-get install python3 python3-dev python3-venv python3-pip libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf build-essential libopenjp2-7 libtiff5 -y
mkdir homeassistant
cd homeassistant
python3.9 -m venv .
source bin/activate
