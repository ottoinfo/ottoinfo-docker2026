#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
# currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source ./helpers/index.sh
builtin source ../.env

logInfo "\n======== DNS Setup ========"

if [ "$(which brew)" != '' ]; then
  # shellcheck source=./brew.sh
  builtin source ./brew.sh
fi

if [ "$(which dnsmasq)" = '' ]; then
  logTest "\nInstalling 'dnsmasq'"
  brew install dnsmasq
fi

logWarning "\n*********** Warning ***********"
logWarning "** 'dnsmasq' is a way we can whitelist domains with '.local' and '.test' to point to 127.0.0.1 ( localhost) **"
logWarning "** We need to create some folders and some files; you will be asked to enter your password to complete the setup **"
logInfo "\n Ok, back to our scheduled program....\n"
read -p "Ready to continue? [Y/n] "

sudo brew services start dnsmasq
sudo mkdir -p /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
echo 'address=/.test/127.0.0.1' >> "$(brew --prefix)/etc/dnsmasq.conf"
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/local'
echo 'address=/.local/127.0.0.1' >> "$(brew --prefix)/etc/dnsmasq.conf"
sudo brew services restart dnsmasq

logCallout "\n*********** Info / Testing ***********"
logCallout "> ping -c 1 www.ottoinfo.local"
logCallout "> ping -c 1 some.random.domain.test"
logCallout "> scutil --dns"
logCallout "> ips"

logInfo "\n======== DNS Complete ========"
