

function pause(){
        read -p "$*"
}

# Rename, to remove some text from middle of filenames:
# brew install rename
# sudo apt -y install rename
# rename 's|.i18n||g' *

echo
PS3='Please enter your choice: '
options=("Install WeKan dependencies" "Update" "Run WeKan for dev at http://localhost:3000" "Run WeKan for production at port 3000" "Pull all translations" "Push English base translation" "Push translation" "Rubocop auto correct all" "Quit")

select opt in "${options[@]}"
do
  case $opt in
    "Install WeKan dependencies")
      if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo "Linux";
        sudo apt -y install build-essential ruby-full ruby-dev libyaml-dev sqlitebrowser nano
        sudo gem install bundler -v 2.4.22
        sudo gem install rails
        sudo gem update
        sudo bundle update
        sudo bundle install
      elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS";
        brew install ruby@3.3 sqlite sqlite-utils db-browser-for-sqlite libyaml nano
        gem uninstall bundler --all
        gem install bundler
        gem install rails
        gem update
        bundle update
        bundle install
      fi
      echo Done.
      break
      ;;

    "Update")
      gem update
      bundle update
      echo Done
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
