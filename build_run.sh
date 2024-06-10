#!/bin/bash
#clone the github repo
#git clone https://github.com/KrishnappaL/App.git

cd /home/lakshmi/App
VERSION=$(git log -1 --pretty=%h)
REPO="lakshmi039/my_web_app:"
TAG="$REPO$VERSION"
LATEST="${REPO}latest"
BUILD_TIMESTAMP=$( date '+%F_%H:%M:%S')
echo "Time: $BUILD_TIMESTAMP"
pwd
REMOTE=origin
BRANCH=main
git fetch

if [[ "$(git rev-parse $BRANCH)" != "$(git rev-parse "$REMOTE/$BRANCH")" ]]; then
	echo "change found on remote"
git pull
#Build the Docker image
#docker build -t lakshmi039/my_web_app:latest  .
docker build -t "$TAG" -t "$LATEST" --build-arg VERSION="$VERSION" --build-arg BUILD_TIMESTAMP="$BUILD_TIMESTAMP" . 
#Authenticate o Docker HUb
docker login

#push the docker images to docker hub
#docker push lakshmi039/my_web_app:latest


docker push "$TAG" 
docker push "$LATEST"
docker stop my_web_app_container

docker container rm my_web_app_container

#run the docker container
docker run -d -p 8081:80 --name my_web_app_container lakshmi039/my_web_app:"$VERSION"
else
        echo "No change on $REMOTE/$BRANCH"
fi

