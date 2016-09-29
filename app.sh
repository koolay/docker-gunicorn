#!/bin/bash

set -e

gunicorn app:__hug_wsgi__ --reload --bind=$APP_BIND -w $APP_WORKS --log-level $APP_LOG_LEVEL --pythonpath /home/app/webapp
