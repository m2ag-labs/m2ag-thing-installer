#!/bin/bash
if [ -z "$1" ]; then
  echo "please provide python version -- such as 3.8.7"
else
  echo "this script will run for a very long time"
  sudo apt-get install -y build-essential tk-dev libncurses5-dev \
    libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev \
    libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev

  version="$1"

  wget https://www.python.org/ftp/python/$version/Python-$version.tgz

  tar zxf Python-$version.tgz
  cd Python-$version
  ./configure --enable-optimizations
  make -j4
  sudo make altinstall
fi
