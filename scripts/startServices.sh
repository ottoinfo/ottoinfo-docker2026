#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# Installing/Setup
builtin source "${currentScriptPath}/helpers/index.sh"

# Local Setup
if [ "${APP_ENV}" = "development" ]; then
  # Installing/Setup
  builtin source "${currentScriptPath}/orbstack.sh"

  # Check that DEV has setup Orb Certificates
  if [ "${setupSSL}" = "1" ]; then
    logWarning "\n\nAbout to setup Orb Stack SSL Certs"
    logText "We will open Safari and follow prompts to allow/trust SSL CERTS"
    logText "Document - https://docs.orbstack.local/features/https"
    # Wait for Dev
    read -r -n 1 -p "Press any key to start, we will wait... "

    open -a Safari "https://orb.local"

    logText "\n\nYou should see a LOCK icon or some indicator in your browser that SSL is setup"
    logText "You can also go to another browser and check"
    logWarning "\n\nFirefox 119 or older may have issues. Update Firefox ( if you USE it ).\n"
    # Wait for Dev
    read -r -n 1 -p "Press any key and lets continue... "
  fi
fi

# We CAN add flag/params to scripts
# Making it so DEVS can start up machine without logs
# except if they ASK or are Setting Up
# > ./startService.sh setup || ./startService.sh log
OPT_SETUP="setup"
OPT_LOG="log"
options="--detach"
setupSSL=0
for OPTION in "${@}"; do
  if [ "$OPTION" = "$OPT_SETUP" ] || [ "$OPTION" = "$OPT_LOG" ]; then
    options=""
  fi
  if [ "$OPTION" = "$OPT_SETUP" ]; then
    setupSSL=1
  fi
done


logSuccess "\n======== Starting Docker Services ========"
logCallout "** Services will be available at: https://orb.local **\n"

cd "${currentScriptPath}/.." || exit
docker compose up ${options}
cd "$currentPath" || exit

logSuccess "\n======== Docker Services Started ========\n"
