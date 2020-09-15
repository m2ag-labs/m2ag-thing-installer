#!/bin/bash
#install motion
sudo apt install motion -y
#copy motion config and start motion
sudo cp "$HOME/m2ag-labs/installer/extras/motion/motion.conf" /etc/motion
sudo sed 's*start_motion_daemon=no*'"start_motion_daemon=yes"'*g' /etc/defaults/motion
sudo systemctl enable motion
sudo systemctl start motion
#add nginx proxy -- add /video path to api
sudo cp "$HOME/m2ag-labs/installer/extras/nginx/sites-available/m2ag-video-proxy" /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/m2ag-api-proxy /etc/nginx/sites-enabled/
sudo sed -i 's*--HOSTNAME--*'"$HOSTNAME"'*g' /etc/nginx/sites-available/m2ag-api-proxy
#enable motion to start daemon
sudo nginx -s reload
