#!/usr/bin/env bash

image="alpine/bundle-terraform-awspec"

docker build --no-cache -t ${image} .
docker tag ${image} ${image}:1.0

  if [[ "$TRAVIS_BRANCH" == "master" ]]; then
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    docker push ${image}
    docker push ${image}:1.0
  fi
