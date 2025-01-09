#!/bin/bash
APP_DIR=$1
GIT_REPO=$2

cd "$APP_DIR"
if [ ! -d ".git" ]; then
    echo "Cloning repository..."
    git clone "$GIT_REPO" .
else
    echo "Pulling latest changes..."
    git pull origin main
fi