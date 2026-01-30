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

logInfo "\n======== Additional Services ========"
logInfo "Some services you may want to run, but up to the developer"

if [ "$(which orb)" = '' ]; then
  # shellcheck source=./orbstack.sh
  builtin source "${currentScriptPath}/orbstack.sh"
fi

# shellcheck source=./helpers/index.sh
builtin source "${currentScriptPath}/../.env"

# echo "${ADDITIONAL_SERVICES_PATH} | ${ADDITIONAL_SERVICES[@]}"

# Loop over ENV variables for services we have defined
for index in "${!ADDITIONAL_SERVICES[@]}"; do
  serviceName="${ADDITIONAL_SERVICES_NAME[$index]}"
  servicePath="${ADDITIONAL_SERVICES_PATH}/${ADDITIONAL_SERVICES[$index]}"
  serviceInfo="${ADDITIONAL_SERVICES_INFO[$index]}"
  logInfo "\n======== Docker - ${serviceName} ========"
  logInfo "${serviceInfo}"
  read -p "Do you want to run ${serviceName}? [Y/n] " startService
  if [ "$startService" = "Y" ] || [ "$startService" = "y" ]; then
    cd "${servicePath}" && docker compose up -d && cd "${currentPath}" || exit
  fi
done
