#!/bin/bash
VERSION=$(git log -1 --pretty=%h)
REPO="lakshmi039/my_web_app:"
TAG="$REPO$VERSION"
LATEST="${REPO}latest"
BUILD_TIMESTAMP=$( date '+%F_%H:%M:%S')
echo "Time: $BUILD_TIMESTAMP"
pwd
REMOTE=origin
BRANCH=main
docker build -t "$TAG" -t "$LATEST" --build-arg VERSION="$VERSION" --build-arg BUILD_TIMESTAMP="$BUILD_TIMESTAMP" . 
docker run -d -p 8082:80 --name my_web_app lakshmi039/my_web_app:"$VERSION"
