#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source "${currentScriptPath}/helpers/index.sh"

logInfo "\n======== Docker Network Setup ========"
logInfo "We want to create a NETWORK all services can/will use"

docker network create -d bridge ottoinfo

logSuccess  "\nDocker Network is setup!"
