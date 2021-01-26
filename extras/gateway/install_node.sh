#!/bin/bash
if [ -z "$1" ]; then
  echo "please provide node version -- such as 12.18.3"
else
  wget https://nodejs.org/dist/v"$1"/node-v"$1"-linux-armv7l.tar.gz
  echo "Decompressing -- may take a while"
  tar -xzf node-v"$1"-linux-armv7l.tar.gz node-v"$1"-linux-armv7l/
  echo "Copying files"
  sudo cp -r node-v"$1"-linux-armv7l/* /usr/local/
  echo "Cleaning up"
  rm -rf node-v"$1"-linux-armv7l*
  echo "please log out and in again"
fi
