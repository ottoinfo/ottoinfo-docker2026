#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source "${currentScriptPath}/helpers/index.sh"

# Lets setup GIT
logInfo "\n======== Setup New Machine ========"
logInfo "This is meant for NEW Developers with NEW Machines. This will prompt user to download common Apps and terminal commands."
# Prompt Dev to Install
read -p "Do you want to run continue? [Y/n] " installApps
if [ "$installApps" != "Y" ] && [ "$installApps" != "y" ]; then
  return
fi

if [ $(which brew) != '' ]; then
  # shellcheck source=./brew.sh
  builtin source "${currentScriptPath}/brew.sh"
fi

brewInstall "Cursor" "cursor"

brewInstall "Figma Design" "figma"

brewInstall "Ghostty Terminal" "ghostty"

brewInstall "PostGres" "postgres-unofficial"

brewInstall "PostGres Admin" "pgadmin4 "

brewInstall "Postman" "postman"

brewInstall "Visual Studio Code" "visual-studio-code"
