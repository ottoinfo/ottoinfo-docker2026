#!/usr/bin/bash

source /app/.env
source /app/scripts/logger.sh

logInfo "$(whoami) | ${PWD}"

logInfo "\n======== Poetry Setup ========\n"
if [ -z "$(which poetry)" ]; then
  # su -c "pip install poetry==1.8.5"
  pip install poetry==1.8.5
fi

# poetry config virtualenvs.in-project true

# Create NEW User | -flags directoryPath userName
# -r | create system user
# -m | create a home file
# -d | path of directory
logInfo "\n======== APP_USER Setup ========\n"
userID=$(id -u "${APP_USER}")
if [[ $userID =~ ^-?[0-9]+$ ]]; then
  logInfo "'${APP_USER}' Exist"
else
  useradd -r -m -d "/home/${APP_USER}" "${APP_USER}"
  logInfo "'${APP_USER}' Created"
fi

# logInfo "Switching from $(whoami) to '${APP_USER}'"
# su - "${APP_USER}" -c "whoami"
# su - "${APP_USER}" -c "pwd"

logInfo "\n======== App Setup ========\n"

# Create a custom poetry.lock file
poetry lock

# Docs
su - "${APP_USER}" --command  "cd ${WORKING_DIR} && poetry lock && poetry install --sync --with docs"

# Blah
su - "${APP_USER}" --command  "cd ${WORKING_DIR} && poetry run python manage.py spectacular --color --file docs/public_api/swagger_schema.yml --validate"

# Unicorn Server
# su - "${APP_USER}" -c "cd ${WORKING_DIR} &&  poetry run gunicorn instil.site.asgi:application -k uvicorn.workers.UvicornWorker"

logInfo "\n======== App Starting ========\n"
# Migration & Start Server
su - "${APP_USER}" --command  "cd ${WORKING_DIR} && poetry run python manage.py migrate && poetry run gunicorn instil.site.asgi:application -k uvicorn.workers.UvicornWorker"


