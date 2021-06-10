#!/bin/bash
#TODO: add prompt if no certs -- continue as non-ssl
#TODO: check for .m2ag-labs/secrets
if [[ ! -f "$HOME/.m2ag-labs/ssl/server.crt" ]]
then
    echo "The installer expects to find ~/.m2ag-labs/ssl/server.crt"
    exit
fi
if [[ ! -f "$HOME/.m2ag-labs/ssl/server.key" ]]
then
    echo "The installer expects to find ~/.m2ag-labs/ssl/server.key"
    exit
fi

echo 'update the system'
sudo apt update
sudo apt upgrade -y
echo 'install some tools'
sudo apt install mc git i2c-tools python3-pip python3-gpiozero python3-pigpio apache2-utils  -y

echo 'install services'
git clone https://github.com/m2ag-labs/m2ag-thing-builder.git "$HOME/m2ag-labs"
git clone https://github.com/m2ag-labs/m2ag-thing-installer.git "$HOME/m2ag-labs/installer"
git clone https://github.com/m2ag-labs/m2ag-thing-client.git "$HOME/m2ag-labs/client"

echo 'create virtual environment'
cd m2ag-labs
python3 -m venv venv
source venv/bin/activate
python3 -m pip install wheel
pip3 install --upgrade setuptools
echo 'adafruit stuff'
pip3 install RPI.GPIO adafruit-blinka
echo 'flask'
pip3 install flask flask-cors flask-htpasswd htpasswd
echo 'install other stuff'
pip3 install psutil gpiozero pigpio
echo 'install webthing dependencies'
pip3 install pyjwt ifaddr jsonschema pyee tornado zeroconf
echo 'setup systemd'
# set correct path in service files
sudo cp "$HOME/m2ag-labs/installer/thing/systemd/m2ag-builder.service" /etc/systemd/system/m2ag-builder.service
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/systemd/system/m2ag-builder.service
sudo sed -i 's*--USER--*'"$USER"'*g' /etc/systemd/system/m2ag-builder.service
sudo cp "$HOME/m2ag-labs/installer/thing/systemd/m2ag-thing.service" /etc/systemd/system/m2ag-thing.service
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/systemd/system/m2ag-thing.service
sudo sed -i 's*--USER--*'"$USER"'*g' /etc/systemd/system/m2ag-thing.service
sudo cp "$HOME/m2ag-labs/installer/thing/systemd/m2ag-client.service" /etc/systemd/system/m2ag-client.service
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/systemd/system/m2ag-client.service
sudo sed -i 's*--USER--*'"$USER"'*g' /etc/systemd/system/m2ag-client.service
# default user -- pi / raspberry
cp "$HOME/m2ag-labs/installer/thing/.m2ag-labs/.htpasswd" "$HOME/.m2ag-labs/"
#copy default config:
cp "$HOME"/m2ag-labs/installer/thing/config_template/server.json "$HOME"/m2ag-labs/config/server.json
cp "$HOME"/m2ag-labs/installer/thing/config_template/enabled.json "$HOME"/m2ag-labs/config/enabled.json
sed -i 's*--HOSTNAME--*'"$HOSTNAME"'*g' "$HOME"/m2ag-labs/config/server.json
#create needed directories
mkdir "$HOME"/.m2ag-labs/secrets
mkdir "$HOME"/m2ag-labs/device/available
mkdir "$HOME"/m2ag-labs/device/helpers
sudo systemctl daemon-reload
sudo systemctl enable m2ag-builder
sudo systemctl enable m2ag-thing
sudo systemctl enable m2ag-client
# Start api service last
sudo systemctl start m2ag-builder
sudo systemctl start m2ag-client















