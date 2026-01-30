#!/bin/bash

source /home/scripts/logger.sh

logInfo "###### Crowdsec Starting ######"

# Fresh packages
cscli hub update

cscli collections install crowdsecurity/linux

cscli collections install crowdsecurity/traefik

cscli collections install crowdsecurity/http-cve

# https://docs.crowdsec.net/docs/next/appsec/quickstart/traefik/
cscli collections install crowdsecurity/appsec-virtual-patching crowdsecurity/appsec-generic-rules

cscli collections list

logInfo "######## Finished Crowdsec Updates #########"
