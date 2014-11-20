web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb

worker: QUEUE=* bundle exec rake resque:work
resque: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=6 bundle exec rake resque:work
worker: QUEUE=mailer rake environment resque:work
