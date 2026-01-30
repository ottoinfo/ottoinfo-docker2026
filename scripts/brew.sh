#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source "${currentScriptPath}/helpers/index.sh"

logInfo "\n======== Brew Installation ========"
logInfo "Let check that you have BREW installed."
if [ "$(which brew)" = '' ]; then
  LogWarning  "\nPlease install BREW ( https://brew.sh ). You can do so by running:"
  logText "\n/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""

  # Prompt Dev to Install
  read -p "Do you want to run command? [Y/n] " installBrew
  if [ "$installBrew" = "Y" ] || [ "$installBrew" = "y" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Check if Dev installed brew, EXIT
  if [ "$(which brew)" = '' ]; then
    exitingSetup
    return
  fi
else
  logSuccess  "\nBrew is installed!"
fi
