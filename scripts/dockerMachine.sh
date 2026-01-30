#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
# currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source ./helpers/index.sh

logText "\n\n======== Docker Machine Installation ========"
echo  -e "\nLets check that you have Docker Machine installed."
if [ "${DOCKER_INSTALL_SETUP}" = "true" ]; then
  echo  -e "\nLet check that you have Docker & Docker Machine installed."
  if [ "$(which docker)" = '' ] && [ "$(which docker-machine)" = '' ]; then
    logText  "\nPlease install DOCKER ( https://docs.docker.com/get-docker/ ). You can also do this by running:"
    logText "\n/brew install --cask docker docker-completion docker-credential-helper docker-machine"
    exitingSetup
    return
  else
    logText  "\nDocker is installed!"
  fi
fi
