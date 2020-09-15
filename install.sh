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

echo 'update the system'
sudo apt update
sudo apt upgrade -y
echo 'install some tools'
sudo apt install mc git i2c-tools python3-pip python3-gpiozero nginx apache2-utils -y
echo 'install python stuff'
sudo pip3 install --upgrade setuptools
echo 'adafruit stuff'
sudo pip3 install RPI.GPIO adafruit-blinka psutil
echo 'flask'
sudo pip3 install flask htpasswd webthing
echo 'install services'
git clone https://github.com/m2ag-labs/m2ag-thing.git "$HOME/m2ag-labs"
git clone https://github.com/m2ag-labs/m2ag-thing-installer.git "$HOME/m2ag-labs/installer"
git clone https://github.com/m2ag-labs/m2ag-thing-client.git "$HOME/m2ag-labs/client"
echo 'setup systemd'
# TODO: set correct path in service files
sudo cp "$HOME/m2ag-labs/installer/thing/systemd/m2ag-api.service" /etc/systemd/system/m2ag-api.service
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/systemd/system/m2ag-api.service
sudo cp "$HOME/m2ag-labs/installer/thing/systemd/m2ag-thing.service" /etc/systemd/system/m2ag-thing.service
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/systemd/system/m2ag-thing.service
# setup nginx http basic auth
# default user -- pi / raspberry
cp "$HOME/m2ag-labs/installer/thing/.m2ag-labs/.htpasswd" "$HOME/.m2ag-labs/"
sudo cp -r "$HOME/m2ag-labs/installer/thing/etc/nginx/sites-available/." /etc/nginx/sites-available
# setup nginx
sudo rm -rf /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/m2ag-api-proxy /etc/nginx/sites-enabled/
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/nginx/sites-available/m2ag-api-proxy
sudo sed -i 's*--HOSTNAME--*'"$HOSTNAME"'*g' /etc/nginx/sites-available/m2ag-api-proxy
sudo ln -s /etc/nginx/sites-available/m2ag-client /etc/nginx/sites-enabled/
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/nginx/sites-available/m2ag-client
sudo sed -i 's*--HOSTNAME--*'"$HOSTNAME"'*g' /etc/nginx/sites-available/m2ag-client
sudo nginx -s reload
#copy default config:
cp "$HOME"/m2ag-labs/installer/thing/config_template/server.json "$HOME"/m2ag-labs/config/server.json
cp "$HOME"/m2ag-labs/installer/thing/config_template/component_map.json "$HOME"/m2ag-labs/config/component_map.json
sed -i 's*--HOSTNAME--*'"$HOSTNAME"'*g' "$HOME"/m2ag-labs/config/server.json
#create needed directories
mkdir "$HOME"/m2ag-labs/config/available
mkdir "$HOME"/m2ag-labs/config/available/components
mkdir "$HOME"/m2ag-labs/config/available/things
mkdir "$HOME"/m2ag-labs/device/hardware/components
mkdir "$HOME"/m2ag-labs/device/things/components
sudo systemctl daemon-reload
sudo systemctl enable m2ag-api
sudo systemctl enable m2ag-thing
# Start services last
sudo systemctl start m2ag-api
# TODO: remove the installer dir














