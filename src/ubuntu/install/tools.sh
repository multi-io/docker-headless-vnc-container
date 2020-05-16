#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get update 
apt-get install -y vim wget net-tools locales bzip2 \
    python-numpy #used for websockify/novnc
apt-get clean -y

if [[ ! -e /usr/bin/python ]]; then
    ln -s /usr/bin/python2 /usr/bin/python
fi

echo "generate locales für en_US.UTF-8"
locale-gen en_US.UTF-8
