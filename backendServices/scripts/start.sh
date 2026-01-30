#!/usr/bin/bash

source /app/.env
source /app/scripts/logger.sh

logInfo "\n======== App Setup ========\n"

poetry run python manage.py spectacular --color --file docs/public_api/swagger_schema.yml --validate

logInfo "\n======== App Starting ========\n"
# Migration & Start Server
poetry run python manage.py migrate && poetry run gunicorn instil.site.asgi:application -k uvicorn.workers.UvicornWorker


