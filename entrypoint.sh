#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid
rm -f /config/master.key
rm -f /config/credentials.yml.enc

export DATABASE_URL=$(echo $DATABASE_URL | sed -e 's/^postgres:/postgresql:/')

EDITOR="mate --wait" bin/rails credentials:edit
#if [[ $(rake database:needs_migration?) = "true" ]]; then
if [[ $SETUP_DB = "true" ]]; then
  bundle exec rake db:create db:migrate db:seed
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
#bundle exec foreman start -f Procfile.dev -p 3000
bundle exec rails server -p 3000 -b 0.0.0.0
