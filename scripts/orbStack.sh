#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source "${currentScriptPath}/helpers/index.sh"

# Make sure BREw is installed
# shellcheck source=./brew.sh
builtin source "${currentScriptPath}/brew.sh"

logInfo "\n======== Orb Stack Installation ========"
logInfo "Let check that you have Orb Stack installed."
if [ "$(which orb)" = '' ]; then
  logWarning  "\nPlease install Orb Stack ( https://orbstack.local/ ). You can do so by running:"
  logText "\n/brew install --cask orbstack"

  # Prompt Dev to Install
  read -p "Do you want to run command? [Y/n] " installOrbStack
  if [ "$installOrbStack" = "Y" ] || [ "$installOrbStack" = "y" ]; then
    brew install --cask orbstack
  fi

  # Check if Dev installed brew, EXIT
  if [ "$(which orb)" = '' ]; then
    exitingSetup
    return
  fi
else
  logSuccess  "\nOrb Stack is installed!"
fi
