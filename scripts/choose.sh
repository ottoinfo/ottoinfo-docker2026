#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

builtin source "${currentScriptPath}/helpers/index.sh"

# File Name
githubTokensFile="githubTokens.sh"
newMachineFile="newMachine.sh"
orbStackFile="orbStack.sh"
setupFile="setup.sh"
startFile='startServices.sh'
stopFile='stopServices.sh'
stopKillFile='stopKillServices.sh'

# File Info or Summary
githubTokensInfo="Github Tokens: this will do basic setup for your github account and create auth tokens"
newMachineInfo="New Machine: this will prompt you with common brew commands and applications you may want to use"
orbStackInfo="Orb Stack: Docker replacement, install the application"
setupInfo="Initial Setup: this will prompt you through scripts and get your local machine running"
startInfo='Start Services: creates images, creates container, and will start all services'
stopInfo='Stop Services: safely stop all docker services'
stopKillInfo='Kill Services: stops all services and will remove container'

# These Need to be in the SAME Order
scriptList=("${setupFile}" "${startFile}" "${stopFile}" "${stopKillFile}" "${newMachineFile}" "${orbStackFile}" "${githubTokensFile}")
scriptInfo=("${setupInfo}" "${startInfo}" "${stopInfo}" "${stopKillInfo}" "${newMachineInfo}" "${orbStackInfo}" "${githubTokensInfo}")

logInfo "======== Scripts available to Run ========"
logWarning "** 'Initial Setup' will run ( almost ) all scripts **"
logWarning "if you want something specific or need to setup again"
logWarning "you can also find all scripts available in the scripts folder\n"

options=()
# `!` below` will give us the INDEX,
for index in "${!scriptList[@]}"; do
  scriptLabel=$(printf "${scriptInfo[$index]}\n   -- ${scriptList[$index]}\n")
  options+=("${scriptLabel}")
done
# Options to show ALL scripts
# blackListScripts=$(echo "choose.sh\|dockermachine.sh\|helpers/") # \|startNode.sh

options+=("Quit")

logCallout "Select an option ( 'q' will exit ):"
select opt in "${options[@]}"; do
  if [[ -n "$opt" ]]; then
    logText "\nYou selected: $opt"
    selectedScript="${scriptList[$selection]}"
    break
  elif [[ "$REPLY" = "q" ]]; then
    exit 0
  else
    logText "\nInvalid selection: '${REPLY}'. Please try again."
  fi
done

if [ "Quit" = "${opt}" ]; then
  logText 'OK, maybe next time...'
  exit 0
fi

selection=$[$REPLY - 1] # We NEED to offset to match ARRAY value
selectedScript="${scriptList[$selection]}"
script2Run="${currentScriptPath}/${selectedScript}"

if [[ -f "$script2Run" && -x "$script2Run" ]]; then
    logText "\nStarting the Script: $selectedScript \n"
    $script2Run
else
    logText "\nFile '$script2Run' is not executable or found\n\nTry running: yarn run:script:enable\n\n"
    chmod +x $script2Run
fi
