# TODO

What is not done yet here, and why. When an item is done, remove it from this
file.

## Needs a maintainer decision

- The demo account `user@demo.test` signs in with any password, because
  SessionsControllerTest asks for it, and restoring sign-in brought it back.
  That is a risk if weror is public: decide whether it stays, or only in
  development and test.

## For the maintainer: needs a person, not code

- Close the Dependabot pull request on `dependabot/bundler/rack-3.1.21`: main
  has rack 3.2.9.
