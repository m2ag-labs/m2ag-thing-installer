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

#todo - check for node and pm2, configure pm2

pip install --upgrade setuptools
echo 'adafruit stuff'
pip3 install RPI.GPIO adafruit-blinka
echo 'flask'
pip3 install flask htpasswd flask-htpasswd
echo 'install other stuff'
pip3 install psutil pycmdmessenger requests
echo 'install webthing dependencies'
pip3 install pyjwt ifaddr jsonschema pyee tornado zeroconf
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
















