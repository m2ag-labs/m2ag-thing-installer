#!/bin/bash
# for development -- reset m2ag-labs code but don't do a reinstall of all the services.
# does not delete .m2ag-labs
rm -rf "$HOME/m2ag-labs"
rm -rf "$HOME/m2ag-labs/installer"
rm -rf "$HOME/m2ag-labs/client"
echo 'install services'
git clone https://github.com/m2ag-labs/m2ag-iot-thing.git "$HOME/m2ag-labs"
git clone https://github.com/m2ag-labs/m2ag-iot-installer.git "$HOME/m2ag-labs/installer"
git clone https://github.com/m2ag-labs/m2ag-iot-client.git "$HOME/m2ag-labs/client"
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
