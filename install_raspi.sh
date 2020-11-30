#!/bin/bash
#TODO: add prompt if no certs -- continue as non-ssl
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

_home=$HOME
_user=$USER

echo 'update the system'
sudo apt update
sudo apt upgrade -y
echo 'install some tools'
sudo apt install mc git i2c-tools python3-pip python3-gpiozero apache2-utils -y
echo 'install python stuff'
sudo pip3 install --upgrade setuptools
echo 'adafruit stuff'
sudo pip3 install RPI.GPIO adafruit-blinka
echo 'flask'
sudo pip3 install flask htpasswd flask-htpasswd
echo 'install other stuff'
sudo pip3 install psutil pycmdmessenger requests
echo 'install webthing dependencies'
sudo pip3 install pyjwt ifaddr jsonschema pyee tornado zeroconf

echo 'install services'
git clone https://github.com/m2ag-labs/m2ag-thing-builder.git "$HOME/m2ag-labs"
git clone https://github.com/m2ag-labs/m2ag-thing-installer.git "$HOME/m2ag-labs/installer"
git clone https://github.com/m2ag-labs/m2ag-thing-client.git "$HOME/m2ag-labs/static"
echo 'setup systemd'
# TODO: set correct path in service files
sudo cp "$_home/m2ag-labs/installer/thing/systemd/m2ag-builder.service" /etc/systemd/system/m2ag-builder.service
sudo sed -i 's*--HOME--*'"$_home"'*g' /etc/systemd/system/m2ag-builder.service
sudo sed -i 's*--USER--*'"$_user"'*g' /etc/systemd/system/m2ag-builder.service
sudo cp "$_home/m2ag-labs/installer/thing/systemd/m2ag-thing.service" /etc/systemd/system/m2ag-thing.service
sudo sed -i 's*--HOME--*'"$_home"'*g' /etc/systemd/system/m2ag-thing.service
sudo sed -i 's*--USER--*'"$_user"'*g' /etc/systemd/system/m2ag-thing.service
# setup nginx http basic auth
# default user -- pi / raspberry
cp "$HOME/m2ag-labs/installer/thing/.m2ag-labs/.htpasswd" "$HOME/.m2ag-labs/"
#copy default config:
cp "$HOME"/m2ag-labs/installer/thing/config_template/server.json "$HOME"/m2ag-labs/config/server.json
cp "$HOME"/m2ag-labs/installer/thing/config_template/component_map.json "$HOME"/m2ag-labs/config/component_map.json
sed -i 's*--HOSTNAME--*'"$HOSTNAME"'*g' "$HOME"/m2ag-labs/config/server.json
#create needed directories
mkdir "$HOME"/.m2ag-labs/secrets
mkdir "$HOME"/m2ag-labs/config/available
mkdir "$HOME"/m2ag-labs/config/available/components
mkdir "$HOME"/m2ag-labs/config/available/things
mkdir "$HOME"/m2ag-labs/device/hardware/components
mkdir "$HOME"/m2ag-labs/device/things/components
sudo systemctl daemon-reload
sudo systemctl enable m2ag-builder
sudo systemctl enable m2ag-thing
# Start the builder service last
sudo systemctl start m2ag-builder















