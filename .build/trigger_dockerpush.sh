#!/usr/bin/env bash
set -e -o pipefail


if [ -z $GIT_BRANCH ] ; then
    GIT_BRANCH=$TRAVIS_BRANCH
fi
if [ -z $GIT_BRANCH ] ; then
    echo "cloud not execute script! Please specify at least on environment variable of: GIT_BRANCH, TRAVIS_BRANCH"
    exit -1
fi

echo "branch=$GIT_BRANCH"
GIT_BRANCH=${GIT_BRANCH/origin\/}
DOCKER_TAG="${GIT_BRANCH/refs\/tags\/}"

if [[ $DOCKER_TAG == "master" ]] ; then
   echo "skip building latest tag!"
   echo "... use 'tag_image.sh' script to release a new version. See: https://github.com/ConSol/docker-headless-vnc-container/blob/master/how-to-release.md"
   exit 0
fi

echo "DOCKER_TAG=$DOCKER_TAG"
echo "..."
echo "trigger dockerhub push for Tag $DOCKER_TAG:"

docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"

IMAGENAME="$1"

docker tag "local/${IMAGENAME}" "oklischat/${IMAGENAME}:${DOCKER_TAG}"
docker push "oklischat/${IMAGENAME}:${DOCKER_TAG}"

