#!/bin/bash
if [ -z "$1" ]; then
  echo "please provide node version -- such as 12.18.3"
else
  wget https://nodejs.org/dist/v"$1"/node-v"$1"-linux-armv7l.tar.gz
  tar -xzf node-v"$1"-linux-armv7l.tar.gz node-v"$1"-linux-armv7l/
  cp -r node-v"$1"-linux-armv7l/* /usr/local/
  rm -rf node-v"$1"-linux-armv7l*
  echo "please log out and in again"
fi
