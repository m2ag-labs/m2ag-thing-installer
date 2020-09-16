#!/bin/bash
if [[ ! -f "$HOME/.m2ag-labs/ssl/rootca.crt" ]]
then
    echo "The installer expects to find ~/.m2ag-labs/ssl/rootca.crt"
    exit
fi
echo "get the code"
mkdir mozilla-iot
git https://github.com/m2ag-labs/mozilla-gateway-lite mozilla-iot
cd mozilla-iot/gateway
npm install -y
cd

echo 'setup systemd'
sudo cp "$HOME/m2ag-labs/installer/extras/gateway/mozilla-gateway.service" /etc/systemd/system/mozilla-gateway.service
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/systemd/system/mozilla-gateway.service
sudo systemctl daemon-reload
sudo systemctl enable mozilla-gateway
sudo systemctl start mozilla-gateway

sudo cp -r "$HOME/m2ag-labs/installer/extras/gateway/m2ag-gateway-proxy" /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/m2ag-gateway-proxy /etc/nginx/sites-enabled/
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/nginx/sites-available/m2ag-gateway-proxy
sudo nginx -s reload













