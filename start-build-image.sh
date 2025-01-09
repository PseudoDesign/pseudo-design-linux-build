#!/usr/bin/env bash

# Args:
# --device=/dev/kvm:/devb/kvm - provide access to vm framework
# --device=/dev/net/tun:/dev/net/tun  - provide access to network framework
#
#
#
#
# 
docker run \
    --device=/dev/kvm:/devb/kvm \
    --device=/dev/net/tun:/dev/net/tun \
    --cap-add NET_ADMIN \
    --hostname pseudo-design-linux-build \
    -it \
    -v /tftpboot:/tftpboot \
    -v `pwd`:/home/$(whoami) \
    -v ~/.ssh:/home/$(whoami)/.ssh \
    pseudo-design-linux-build:scarthgap