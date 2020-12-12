#!/bin/bash
cd /
if [[ ! -f "$HOME/.m2ag-labs/ssl/rootca.crt" ]]
then
    echo "The installer expects to find ~/.m2ag-labs/ssl/rootca.crt"
    exit
fi
echo "get the code"
git clone https://github.com/m2ag-labs/m2ag-webthings-gateway-lite gateway
cd gateway
echo "go get a drink -- npm install will run a long time"
npm install -y
cd
echo "yay - almost there!"
echo 'setup systemd'
sudo cp "$HOME"/m2ag-labs/installer/extras/gateway/m2ag-gateway.service /etc/systemd/system/m2ag-gateway.service
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/systemd/system/m2ag-gateway.service
sudo systemctl daemon-reload
sudo systemctl enable m2ag-gateway
sudo systemctl start m2ag-gateway
echo Setup nginx
sudo cp -r "$HOME/m2ag-labs/installer/extras/gateway/m2ag-gateway-proxy" /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/m2ag-gateway-proxy /etc/nginx/sites-enabled/
sudo sed -i 's*--HOME--*'"$HOME"'*g' /etc/nginx/sites-available/m2ag-gateway-proxy
sudo sed -i 's*--HOSTNAME--*'"$HOSTNAME"'*g' /etc/nginx/sites-available/m2ag-gateway-proxy
sudo nginx -s reload

