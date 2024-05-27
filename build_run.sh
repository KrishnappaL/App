#!/bin/bash
#clone the github repo
git clone https://github.com/KrishnappaL/App.git

cd App
BUILD_TIMESTAMP=$( date '+%F_%H:%M:%S')
echo "Time: $BUILD_TIMESTAMP"
REMOTE=origin
BRANCH=main
git fetch
if [["$(git rev-parse $BRANCH)" != "$(git rev-parse "$REMOTE/$BRANCH")" ]];  then
        #Run your script
git pull

#Build the Docker image
docker build -t lakshmi039/my_web_app:latest  .

#Authenticate o Docker HUb
docker login

#push the docker images to docker hub
docker push lakshmi039/my_web_app:latest

docker stop my_web_app_container

docker container rm my_web_app_container

#run the docker container
docker run -d -p 8081:80 --name my_web_app_container lakshmi039/my_web_app:latest
else
        echo "No change on $REMOTE/$BRANCH"
fi

