#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:precompile RAILS_ENV=production
bundle exec rails assets:clean
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:create db:migrate db:seed
