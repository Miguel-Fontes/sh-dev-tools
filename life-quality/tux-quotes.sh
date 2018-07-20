#!/bin/bash
# Tux Quotes
# Shows a fortune quote, into a tux format each x minutes (default is 5).
#
# USAGE: tux-quotes
#        tux-quotes 10


declare -r INTERVAL=$(expr 60 \* "${1:-5}")

while true; do
  echo -e "\033[2J"
  fortune | cowsay -f tux
  sleep "$INTERVAL";
done;
