#!/bin/bash
APP_DIR=$1
APP_NAME=$2

cd "$APP_DIR"
fuser -k 9090/tcp || true
nohup "./$APP_NAME" > "$APP_NAME.log" 2>&1 &
