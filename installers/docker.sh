#!/bin/bash

# Install Docker - version 1
#
# Installs docker CE on a Debian based Linux Distribution. The steps executed here are
# described at docker installation guide for ubuntu (https://docs.docker.com/install/linux/docker-ce/ubuntu/).
# This script intends to detect the current debian distribution and select the correct docker repository
# accordingly, making it reusable between distrutions. The getCurrentDistribution is the function that
# executes the distribution identification logic and is the primary extension point of this script, if
# it does not work for your distribution.
#
# Dependencies:
#   - sudo
#   - apt-get
#   - apt-transport-https
#   - ca-certificates
#   - curl
#   - gnupg-agent
#   - software-properties-common

declare -r USER_NAME=$1
declare -r USER_EMAIL=$2

declare -r TRUE=0
declare -r FALSE=1

declare -r USAGE="
USAGE: $(basename $0)

Note: this script will install the following packages if needed:
    - sudo
    - apt-get
    - apt-transport-https
    - ca-certificates
    - curl
    - gnupg-agent
    - software-properties-common
"

declare -r ELEMENTARY_JUNO="juno"
declare -r UBUNTU_XENIAL="xenial"
declare -r UBUNTU_BIONIC="bionic"
declare current_distribution_codename=$(lsb_release -cs);

help() {
  echo "$USAGE"
}

getCurrentDistribution() {
  if [ "$current_distribution_codename" = "$ELEMENTARY_JUNO" ]; then
    current_distribution_codename="$UBUNTU_BIONIC"
  fi

  echo "Current distribution codename is $current_distribution_codename..."
}

installDocker() {
  echo "Updating packages..."
  sudo apt-get update

  echo "Installing dependencies..."
  sudo apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common

  echo "Adding docker GPG key..." 
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  echo "Adding docker repository for [$current_distribution_codename] distribution"
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $current_distribution_codename \
     stable"

  echo "Installing Docker..."
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io

  echo "Done!"
}

main() {
  help
  getCurrentDistribution
  installDocker
}

main



