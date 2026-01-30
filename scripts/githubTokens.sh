#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source "${currentScriptPath}/helpers/index.sh"

# Lets setup GIT
logInfo "\n======== Setup Git Configuration ========"
logInfo "Do you want to setup Git & Github Tokens? This is meant for NEW Developers with NEW Machines"
# Prompt Dev to Install
read -p "Do you want to run continue? [Y/n] " installGit
if [ "$installGit" != "Y" ] && [ "$installGit" != "y" ]; then
  return
fi

if [ "$(which git)" = '' ]; then
  # shellcheck source=./brew.sh
  builtin source "${currentScriptPath}/brew.sh"

  logTest "\nInstalling 'git'"
  brew install git
fi

# Check Git Config has data
gitName=$(git config --list | grep 'user.name')
gitEmail=$(git config --list | grep 'user.email')

if [ "$gitEmail" = "" ]; then
  prompt "Enter your GitHub Name:"
  read -r -p "GitHub Name: " name
  git config --global user.name "$name"
fi

if [ "$gitName" = "" ]; then
  prompt "Enter your GitHub Email:"
  read -r -p "GitHub Name: " email
  git config --global user.email "$email"
fi

# Do you need to setup GPG keys?
if [ "$(which gpg)" = '' ]; then
  logTest "\nInstall 'gpg'"
  brew install gpg
fi


read -r -n 1 -p "Do you want to setup GPG keys? [Y/n] " gpgSetup
if [ "$gpgSetup" = "Y" ] || [ "$gpgSetup" = "y" ]; then
  logWarning "\n\nAbout to setup GPG keys? This will allow you to sign your commits."
  logText "Before you start you want to have a PHRASE ( or password ) ready."
  logText "You will need to keep on hand during initial setup."
  logText "The PHRASE is recommended to be 8 characters long."
  logText "You may want to add to the 'Passwords' App for safe keeping."
  logText "We will open the GitHub Doc in a Browser to help you."
  logText "This script should walk you through all the steps, but look at documentation for more details."
  logText "\n\n** NOTE - gpg will timeout and you will have to start process over, so please be prepared for passphrase section **"
  logText "\n You can come back to terminal window when you are ready to start"
  read -r -n 1 -p "Open GitHub Doc? [Y/n] " openGithub
  if [ ! "$openGithub" = "n" ]; then
    open "https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key#generating-a-gpg-key"
  fi

  read -r -n 1 -p "Press any key to start creating your KEY... "
  gpg --list-secret-keys --keyid-format=long
  gpg --gen-key
  gpg --list-secret-keys --keyid-format=long
  logWarning "\nYou need to paste in the 'GPG key ID' look at step 11 in DOC."
  read -r -p "Enter your GPG key ID: " gpgKeyID
  gpg --armor --export "$gpgKeyID"
  logInfo "Copy ALL Text including '-----BEGIN .... END PGP PUBLIC KEY BLOCK-----"
  read -r -p "Paste the text into your GitHub Account. Open Github.com ... [ enter ] "
  open "https://github.com/settings/keys"
fi

