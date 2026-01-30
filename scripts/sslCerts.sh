#!/bin/bash

# Figure out the SCRIPTS we want to show
currentPath=$(pwd)
# currentScriptPath=$(cd -- "$(dirname "$(readlink -f "$0")")" && pwd)
cd "$currentPath" || return # Reset Original Path

# shellcheck source=./helpers/index.sh
builtin source ./helpers/index.sh
builtin source ../.env

logInfo "\n======== SSL Certs ========"
logInfo "Let create SSL Certs for $SSL_SERVER_URL."

if [ $(which brew) != '' ]; then
  # shellcheck source=./brew.sh
  builtin source ./brew.sh
fi

if [ $(which mkcert) = '' ]; then
  logTest "\nInstalling 'mkcert'"
  brew install mkcert
fi

logWarning "\n*********** Warning ***********"
logWarning "** 'mkcert' is/was having problems with Firefox ( so FUCK Firefox ) **"
logWarning "** we should still be able to install CERTS, but please report issues **"
logInfo "\n Ok, back to our scheduled program....\n"
read -p "Ready to continue? [Y/n] "

#####

# Create a local CA that your operating system will trust
mkcert -install

mkdir "${SSL_CERT_PATH}"

# Create CERTS and place inside of Traefik ( or your proxy manager )
mkcert -cert-file "${SSL_CERT_PATH}/${SSL_SERVER_URL}.crt" \
        -key-file "${SSL_CERT_PATH}/${SSL_SERVER_URL}.key" \
        "${SSL_SERVER_URL}" "*.${SSL_SERVER_URL}"

chmod -R a+r "${SSL_CERT_PATH}"

sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "${SSL_CERT_PATH}/${SSL_SERVER_URL}.crt"
