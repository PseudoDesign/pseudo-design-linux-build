#!/usr/bin/env bash

if [ -z "${DOCKER_FULL_IMAGE_NAME}" ]; then
  DOCKER_FULL_IMAGE_NAME=pseudo-design-linux-build:scarthgap
fi

# Args:
# --device=/dev/kvm:/devb/kvm - provide access to vm framework
# --device=/dev/net/tun:/dev/net/tun  - provide access to network framework
# --cap-add NET_ADMIN - provide access to network framework
# --hostname ${DOCKER_FULL_IMAGE_NAME} - set the hostname of the network we bring up
# -v /tftpboot:/tftpboot - Pass the tftpboot directory to the container
# -v /home/$(whoami):/home/$(whoami) - mount the user's home directory
# 
docker run \
    --device=/dev/kvm:/devb/kvm \
    --device=/dev/net/tun:/dev/net/tun \
    --cap-add NET_ADMIN \
    --hostname ${DOCKER_FULL_IMAGE_NAME} \
    -it \
    -v /tftpboot:/tftpboot \
    -v /home/$(whoami):/home/$(whoami) \
    -w $PWD \
    ${DOCKER_FULL_IMAGE_NAME} 
    