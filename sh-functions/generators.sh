#!/bin/zsh

cuuidgen() {
    uuidgen | tr '[:upper:]' '[:lower:]'
}

