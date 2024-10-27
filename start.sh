sudo apt -y install build-essential ruby-full ruby-dev libyaml-dev
sudo gem install rails
sudo gem update
sudo bundle update
sudo bundle install
bin/rails db:migrate
bundle exec rake assets:precompile
./bin/rails server
