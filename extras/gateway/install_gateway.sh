#!/bin/bash
cd /
if [[ ! -f "$HOME/.m2ag-labs/ssl/rootca.crt" ]]
then
    echo "The installer expects to find ~/.m2ag-labs/ssl/rootca.crt"
    exit
fi
echo "get the code"
git clone https://github.com/m2ag-labs/mozilla-gateway-lite mozilla-iot/gateway
cd mozilla-iot/gateway
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

