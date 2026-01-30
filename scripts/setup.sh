#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# Installing/Setup
builtin source "${currentScriptPath}/helpers/index.sh"

# Installing/Setup
builtin source "${currentScriptPath}/bashUpgrade.sh"

# Installing/Setup
builtin source "${currentScriptPath}/orbstack.sh"

# Installing/Setup
builtin source "${currentScriptPath}/hosts.sh"

# Installing/Setup
builtin source "${currentScriptPath}/sslCerts.sh"

# Start BE Services
# builtin source "${currentScriptPath}/backendServices.sh"

# Start FE Services
builtin source "${currentScriptPath}/frontendServices.sh"

# Installing/Setup
# builtin source "${currentScriptPath}/newMachine.sh"

# Start Docker Services
builtin source "${currentScriptPath}/startServices.sh" setup

logSuccess "\n======== Setup is Complete ========\n"
