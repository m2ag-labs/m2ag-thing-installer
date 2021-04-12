#!/bin/bash
#install motion
# sudo apt install motion -y
#copy motion config and start motion
sudo cp "$HOME/m2ag-labs/installer/extras/motion/motion.conf" /etc/motion
sudo sed 's*start_motion_daemon=no*'"start_motion_daemon=yes"'*g' /etc/defaults/motion
sudo systemctl enable motion
sudo systemctl start motion

