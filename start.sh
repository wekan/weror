if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "Linux";
  sudo apt -y install build-essential ruby-full ruby-dev libyaml-dev sqlitebrowser
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "macOS";
  brew install ryby@3.2 sqlite sqlite-utils db-browser-for-sqlite
fi

sudo gem install rails
sudo gem update
sudo bundle update
sudo bundle install
bin/rails db:migrate
bundle exec rake assets:precompile
./bin/rails server
