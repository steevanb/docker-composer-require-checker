#!/usr/bin/env bash

set -e

readonly PROJECT_DIRECTORY=$(realpath $(dirname $(realpath $0))/..)
source ${PROJECT_DIRECTORY}/.env

docker \
    build \
    $PROJECT_DIRECTORY \
    --file=${PROJECT_DIRECTORY}/docker/Dockerfile \
    --build-arg COMPOSER_REQUIRE_CHECKER_VERSION=${COMPOSER_REQUIRE_CHECKER_VERSION} \
    -t steevanb/composer-require-checker:${COMPOSER_REQUIRE_CHECKER_VERSION}

if [ "$1" == "--push" ]; then
    docker logout
    docker login --username=steevanb
    docker push steevanb/composer-require-checker:${COMPOSER_REQUIRE_CHECKER_VERSION}
fi
