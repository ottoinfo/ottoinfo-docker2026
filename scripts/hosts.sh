#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source "${currentScriptPath}/helpers/index.sh"
builtin source "${currentScriptPath}/../.env"

logInfo "\n\n======== Hosts File ========"

logText "\nLet check that you have '${SERVER_NAME}' in your 'hosts' file "
hasDomain=$(cat /etc/hosts | grep "${SERVER_NAME}")
if [ "$hasDomain" = '' ]; then
  logText "\nUpdating your 'hosts' file"
  sudo sh -c "echo '127.0.0.1 ${SERVER_NAMES}' >> /etc/hosts"
else
  logInfo "\nDomain '${SERVER_NAME}' already exists"
fi

logSuccess "\n\n======== hosts ( /etc/hosts ) ========\n$(cat /etc/hosts)\n========\n"

# logInfo "We need to restart your machines 'APACHE' server ( this will make URL's available on your machine )\n"
# read  -p  "Ready to restart 'APACHE' server [Y/n]?  " restartApache
# if [ "y" = "$restartApache" ]; then
#   sudo apachectl -k restart
# fi
