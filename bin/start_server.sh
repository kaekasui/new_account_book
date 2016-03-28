#!/bin/bash -x
export SECRET_KEY_BASE=`bundle exec rake secret`
bundle exec rake db:create RAILS_ENV=production
bundle exec rake db:migrate RAILS_ENV=production
# bundle exec unicorn -p 8080 -c config/unicorn.rb
bundle exec foreman start
