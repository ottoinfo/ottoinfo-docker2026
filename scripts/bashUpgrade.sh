#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source "${currentScriptPath}/helpers/index.sh"

if [ "$(which bash)" != '/bin/bash' ]; then
  return
fi

# shellcheck source=./brew.sh
builtin source "${currentScriptPath}/brew.sh"

logInfo "\n======== Update Bash ========"
logInfo "Bash on MAC's is outdated ( V3.2 released 2014 ), lets get something newer"

brew install bash

logSuccess  "\nBash is Installed/Updated!"

# Prompt Dev to Restart Terminal App
logWarning "\n\n** Terminal will not have the new BASH available in this or any existing terminal window **"
logInfo "- You can continue the installation process"
logInfo "- You will need kill your terminal app to use 'choose.sh'\n"
read -r -n 1 -p "Press any key and lets continue... "
