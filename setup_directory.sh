#!bin/bash
APP_DIR=$1

if [ ! -d "$APP_DIR" ]; then
    echo "Directory $APP_DIR does not exist. Creating..."
    mkdir -p "$APP_DIR"
else
    echo "Directory $APP_DIR already exists."
fi