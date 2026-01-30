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

logInfo "\n======== Proxy Services ========"
logInfo "Let check that you have....."

if [ "$(which orb)" = '' ]; then
  # shellcheck source=./orbstack.sh
  builtin source "${currentScriptPath}/orbstack.sh"
fi

# shellcheck source=./helpers/index.sh
builtin source "${currentScriptPath}/../.env"

echo "${PROXY_SERVICE} | ${PROXY_SERVICE_PATH}"

# Loop over ENV variables for services we have defined
logInfo "\n======== Docker - ${PROXY_SERVICE} ========"
logInfo "${PROXY_SERVICE_INFO}"
read -p "Do you want to run ${PROXY_SERVICE}? [Y/n] " startService
if [ "$startService" = "Y" ] || [ "$startService" = "y" ]; then
  cd "${PROXY_SERVICE_PATH}" && docker compose up -d && cd ${currentPath}
fi

logSuccess  "\nProxy is setup!"
