web: bundle exec rails server -p $PORT
mailcatcher: mailcatcher --ip 0.0.0.0
webpack: bin/webpack-dev-server 
worker: bundle exec sidekiq -t 25 -C config/sidekiq.yml
