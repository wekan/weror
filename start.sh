

function pause(){
        read -p "$*"
}

echo
PS3='Please enter your choice: '
options=("Install WeKan dependencies" "Build WeKan" "Run WeKan for dev at http://localhost:3000" "Run WeKan for production at port 3000" "Pull all translations" "Push English base translation" "Push translation" "Rubocop auto correct all" "Quit")

select opt in "${options[@]}"
do
  case $opt in
    "Install WeKan dependencies")
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
      echo Done.
      break
      ;;

    "Run WeKan for dev at http://localhost:3000")
      bin/rails db:migrate
      bundle exec rake assets:precompile
      ./bin/rails server
      echo Done.
      break
      ;;

    "Run WeKan for production at port 3000")
      bin/rails db:migrate
      bundle exec rake assets:precompile
      ./bin/rails server -e production
      echo Done.
      break
      ;;

    "Pull all translations")
      tx --config .tx/config pull -a -f
      # https://developers.transifex.com/docs/cli
      # New Go-based transifex client.
      echo Done.
      break
      ;;

    "Push English base translation")
      tx push -s
      echo Done.
      break
      ;;

    "Push translation")
      read -p "Translation to push: " translation
      tx push -t -l "$translation"
      echo Done.
      break
      ;;

    "Rubocop auto correct all")
      rubocop -A
      echo Done.
      break
      ;;

    "Quit")
      break
      ;;
    *) echo invalid option;;
    esac
done
