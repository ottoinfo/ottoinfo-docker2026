#!/bin/bash

source /data/scripts/logger.sh

logInfo "###### Starting Otto+Info FE in Docker ######"

yarn start

logInfo "######## Finished Otto+Info FE in Docker #########"

# Not SURE why FAILING so run the script here manually
# npm concurrently --names 'NEXT,RELAY' -c 'bgMagenta,bgBlue' --kill-others 'next dev -p 3001' 'npm:relay:watch'
