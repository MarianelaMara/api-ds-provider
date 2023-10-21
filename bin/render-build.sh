set -o errexit

bundle install
bundle exec rake db:create db:migrate db:seed
