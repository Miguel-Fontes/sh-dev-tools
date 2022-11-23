#!/bin/zsh

function goNew() {
	NAME="$1"
	if [[ -z "$NAME" ]]; then
		echo "[ERROR] A valid name was not given!"
		return 1
	fi

	mkdir $GOPATH/src/$NAME
	cd $GOPATH/src/$NAME
	go mod init
}