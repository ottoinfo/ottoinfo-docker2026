#!/bin/bash

currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./logger.sh
builtin source "${currentScriptPath}/helpers/logger.sh"
# shellcheck source=/exit.sh
builtin source "${currentScriptPath}/helpers/exit.sh"
# shellcheck source=/exit.sh
builtin source "${currentScriptPath}/helpers/brewInstall.sh"


