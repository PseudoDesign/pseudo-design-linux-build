#!/usr/bin/env bash

if [ -z "${DOCKER_FULL_IMAGE_NAME}" ]; then
  DOCKER_FULL_IMAGE_NAME=pseudo-design-linux-build:scarthgap
fi

# Get the directory of this script (e.g. not symlinks to it)
SCRIPT_DIR=$(dirname $([ -L $0 ] && readlink -f $0 || echo $0))

docker build -t "${DOCKER_FULL_IMAGE_NAME}" \
    --build-arg GROUP_ID="$(id -g)" \
    --build-arg USER_ID="$(id -u)" \
    --build-arg USER_NAME="$(whoami)" \
    --build-arg GIT_NAME="$(git config user.name)" \
    --build-arg GIT_EMAIL="$(git config user.email)" \
    $SCRIPT_DIR