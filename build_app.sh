#!/bin/bash
APP_DIR=$1
APP_NAME=$2

cd "$APP_DIR"
export PATH=$PATH:/usr/local/go/bin
go version
go build -o "$APP_NAME"