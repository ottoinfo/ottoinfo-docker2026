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

logInfo "\n======== Backend Services ========"
logInfo "Let check that you have....."

# Dev need Poetry
if [ "$(which pyenv)" = '' ]; then
  brew install pyenv
fi
logInfo "-- pyenv ready --"
pyenv local 3.12.8 # local pyenv to use for a given project/folder


if [ "$(which pipx)" = '' ]; then
  brew install pipx # tool for installing python-based applications outside of a virtualenv
fi
logInfo "-- pipx ready --"
pipx install poetry
poetry sync

#### NOTE ####
# poetry env remove python
# poetry config virtualenvs.in-project true
# poetry sync

poetry env activate

if [ "$(which postgresql)" = '' ]; then
  brew install postgresql # tool for installing python-based applications outside of a virtualenv
fi
logInfo "-- postgresql ready --"

logSuccess  "\nBackend is setup!"
