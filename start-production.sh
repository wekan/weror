bin/rails db:migrate
bundle exec rake assets:precompile
./bin/rails server -e production
