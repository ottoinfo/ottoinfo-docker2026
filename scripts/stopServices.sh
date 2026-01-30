#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# Installing/Setup
builtin source "${currentScriptPath}/helpers/index.sh"

cd "${currentScriptPath}/.." || exit
docker compose stop
cd "$currentPath" || exit

logSuccess "\n======== Docker Services Stopped ========\n"
