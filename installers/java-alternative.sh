#!/bin/bash

# Configure Java Alternatives - version 1
#
# Sets a new Java alternative, given a JDK path. Two steps are performed:
#   - Set a update-alternative for javac
#   - Set a update-alternative for java
#
# With this configuration you can use sudo the command 'update-alternatives --config java'
# to set the current java version.
#
# Dependencies:
#   - sudo
#   - update-alternatives

declare -r JDK_FOLDER=$1

declare -r TRUE=0
declare -r FALSE=1

declare -r USAGE="
USAGE: $(basename $0) <JDK_FOLDER_NAME>
       $(basename $0) /usr/lib/jvm/oracle-java-8
       $(basename $0) /usr/lib/jvm/jdk-11.0.2

JDK_FOLDER_NAME
  The path where the desired JVM is installed.
"

isValid() {
  valid="$TRUE"
  if [ -z "$JDK_FOLDER" ]; then
    echo "ERROR: JVM path was not given!"
    valid="$FALSE" 
  fi

  return "$valid"
}

help() {
  echo "$USAGE"
}

configureAlternatives() {
  echo "Given JVM path is $JDK_FOLDER..."
  sudo update-alternatives --install /usr/bin/javac javac ${JDK_FOLDER}/bin/javac 1
  sudo update-alternatives --install /usr/bin/java java ${JDK_FOLDER}/bin/java 1

  echo "Done!"
}

main() {
  if isValid; then
    configureAlternatives
  else
    help
  fi
}

main
