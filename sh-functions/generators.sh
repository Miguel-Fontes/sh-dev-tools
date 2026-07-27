#!/bin/zsh

cuuidgen() {
    uuidgen | tr '[:upper:]' '[:lower:]'
}

randomText() {
  tr -dc A-Za-z0-9 </dev/urandom
}