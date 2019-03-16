#!/bin/bash

# Install Git - version 1
#
# Installs git with the mininal configuration 
#
# Dependencies:
#   - apt-get (only on debian based distributions)

declare -r USER_NAME=$1
declare -r USER_EMAIL=$2

declare -r TRUE=0
declare -r FALSE=1

declare -r USAGE="
USAGE: $(basename $0) <USER_NAME> <USER_EMAIL>
       $(basename $0) \"John Doe\" \"johndoe@example.com\"

USER_NAME
  The user name, used on the global user.name configuration

USER_EMAIL
  The user email, used on the user.email global settings
"

isValid() {
  valid="$TRUE"

  if [ -z "$USER_NAME" ]; then
    echo "ERROR: User name was not given!"
    valid="$FALSE"
  fi

  if [ -z "$USER_EMAIL" ]; then
    echo "ERROR: User email was not given!"
    valid="$FALSE"
  fi

  return "$valid"
}

help() {
  echo "$USAGE"
}

installGit() {
  sudo apt-get update
  sudo apt-get install git -y

  echo "Setting global user.name as $USER_NAME..."
  git config --global user.name $USER_NAME

  echo "Setting global user.email as ${USER_EMAIL}..."
  git config --global user.email $USER_EMAIL

  echo "Done!"
}

main() {
  if isValid; then
    installGit
  else
    help
  fi
}

main
