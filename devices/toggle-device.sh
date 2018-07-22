#!/bin/bash

# Toggle Device - version 1
#
# Toogles a device status between enabled / disabled, using xinput to change status.
#
# Dependencies:
#   - sed
#   - xinput

declare -r DEVICE_ID=$1

declare -r TRUE=0
declare -r FALSE=1

declare -r ENABLED=1
declare -r DISABLED=0

declare -r USAGE="
USAGE: $(basename $0) <DEVICE_ID>
       $(basename $0) 15

DEVICE_ID
  The device id, identifiable through 'xinput list'
"

isValid() {
  valid="$TRUE"

  if [ -z "$DEVICE_ID" ]; then
    echo "ERROR: Device id was not set!"
    valid="$FALSE"
  fi

  return "$valid"
}

help() {
  echo "$USAGE"
}

toggleDevice() {
  isEnabled=$(xinput list-props 15 | grep 'Device Enabled' | sed -e 's/.*://g');

  if [ "$ENABLED" -eq "$isEnabled" ]; then
    xinput set-prop "$DEVICE_ID" "Device Enabled" "$DISABLED"
  else
    xinput set-prop "$DEVICE_ID" "Device Enabled" "$ENABLED"
  fi
}

main() {
  if isValid; then
    toggleDevice
  else
    help
  fi
}

main
