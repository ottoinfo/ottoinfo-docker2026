#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
# currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source ./helpers/index.sh

# Check if Dev installed brew, EXIT
if [ "$(which brew)" = '' ]; then
  builtin source ./brew.sh
fi

logInfo "\n======== Do you want to update/upgrade brew ========"
read -p "Do you want to run command? [Y/n] " installBrew
if [ "$installBrew" = "Y" ] || [ "$installBrew" = "y" ]; then
  brew update && brew upgrade
fi
