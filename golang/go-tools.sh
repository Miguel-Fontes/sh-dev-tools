#!/bin/zsh

function goNew() {
	NAME="$1"
	if [[ -z "$NAME" ]]; then
		echo "[ERROR] A valid name was not given!"
		return 1
	fi

	mkdir $GOPATH/src/$NAME
	mkdir $GOPATH/src/$NAME/internal
	mkdir $GOPATH/src/$NAME/cmd
	mkdir $GOPATH/src/$NAME/cmd/cli

	echo "
	package main
	
	func main() {
		print(\"hello world!\")
	}
	" > $GOPATH/src/$NAME/cmd/cli/main.go 

	go fmt $GOPATH/src/$NAME/cmd/cli/main.go 

	# Create a makefile
	echo "build-cli: ${GOPATH}/src/$NAME/cmd/cli/main.go
		go install ${GOPATH}/src/$NAME/cmd/cli/main.go
		mv ${GOPATH}/bin/main ${GOPATH}/bin/$NAME-cli
	" > ${GOPATH}/src/$NAME/makefile

	cd $GOPATH/src/$NAME
	go mod init

	make build-cli
}