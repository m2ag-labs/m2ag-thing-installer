#!/bin/bash
if [ -z "$1" ]; then
  echo "please provide node version -- such as 12.21.0"
else
  if (cat /proc/cpuinfo | grep -q 'Pi Zero')  then
    echo 'Installing nodejs "$1" for armv6 from unofficial builds...'
    wget https://unofficial-builds.nodejs.org/download/release/v"$1"/node-v"$1"-linux-armv6l.tar.gz
    tar -xzf node-v"$1"-linux-armv6l.tar.gz
    echo "Copying files"
    sudo cp -r node-v"$1"-linux-armv6l/* /usr/local/
    echo "Cleaning up"
    rm -rf node-v"$1"-linux-armv6l*
    echo "please log out and in again"
  else
    echo 'Installing nodejs "$1" for armv7 from official builds...'
    wget https://nodejs.org/dist/v"$1"/node-v"$1"-linux-armv7l.tar.gz
    echo "Decompressing -- may take a while"
    tar -xzf node-v"$1"-linux-armv7l.tar.gz node-v"$1"-linux-armv7l/
    echo "Copying files"
    sudo cp -r node-v"$1"-linux-armv7l/* /usr/local/
    echo "Cleaning up"
    rm -rf node-v"$1"-linux-armv7l*
    echo "please log out and in again"
  fi
fi
