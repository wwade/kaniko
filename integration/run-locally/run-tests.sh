#!/bin/bash
set -xeu
baseDir=$PWD
dockerDir=$(dirname "$0")
docker build -t kaniko-test-helper "$dockerDir"

docker run -d -p 5000:5000 --restart=always --name registry registry:2 || true
repoAddr=$(docker inspect registry | jq -r .[0].NetworkSettings.IPAddress)

docker run \
       --rm -it \
       -v "$baseDir:$baseDir" -w "$baseDir" \
       -v "/var/run/docker.sock:/var/run/docker.sock" \
       -e IMAGE_REPO="$repoAddr:5000" \
       --name kaniko-test-helper \
       kaniko-test-helper go test ./integration/... --bucket gs://kaniko-test --repo "$repoAddr":5000 "$@"
