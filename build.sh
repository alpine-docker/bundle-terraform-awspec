#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables: DOCKER_USERNAME and  DOCKER_PASSWORD in Travis CI

image="alpine/bundle-terraform-awspec"
tag="1.0"

docker build --no-cache -t ${image} .
docker tag ${image} ${image}:${tag}

  if [[ "$TRAVIS_BRANCH" == "master" ]]; then
    docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
    docker push ${image}
    docker push ${image}:${tag}
  fi
