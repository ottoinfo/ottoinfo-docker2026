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

logInfo "\n======== Frontend Services ========"
logInfo "Let check that you have....."

# brew install watchman
# logCallout "\n----------> Watchman Installation is Complete\n"


logSuccess  "\nFrontend is setup!"
