#!/bin/bash
cd $(cd $(dirname $0); pwd)
install(){
apt update
apt upgrade
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install tmux
sudo apt-get install luarocks
sudo apt-get install screen
sudo apt install zip
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.3 liblua5.3-dev lua-socket lua-sec lua-expat libevent-dev make unzip git redis-server autoconf g++ libjansson-dev libpython-dev expat libexpat1-dev
sudo apt-get update
sudo apt-get install
sudo apt-get install upstart-sysv
wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz;tar zxpf luarocks-2.2.2.tar.gz;cd luarocks-2.2.2 && ./configure
sudo make bootstrap
sudo luarocks install luasocket
sudo luarocks install luasec
sudo luarocks install lua-term
sudo luarocks install Lua-cURL
sudo service redis-server start
sudo apt-get install libconfig++9v5 -y 
sudo apt-get install libstdc++6 -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y 
sudo apt-get install lua-lgi -y  
sudo apt-get install software-properties-common -y
sudo apt-get install libnotify-dev -y 
sudo apt-get install lua-space -y
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.3 liblua5.3-dev lua-socket lua-sec lua-expat libevent-dev make unzip git redis-server autoconf g++ libjansson-dev libpython-dev expat libexpat1-dev -y
sudo apt-get update 
sudo apt-get upgrade -y
cd ..
}
if [ "$1" = "run" ]; then
sudo lua5.3 setup.lua
fi
if [ "$1" = "ins" ]; then
install
cd luagram
rm -rf luarocks*
sudo lua5.3 setup.lua
fi
