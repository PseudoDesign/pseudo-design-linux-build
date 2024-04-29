FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN \
        dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -yq sudo build-essential git nano vim\
          python3-yaml libncursesw5 libncursesw5:i386 \
          python python3 man bash diffstat gawk chrpath wget cpio \
          texinfo lzop apt-utils bc screen libncurses5-dev locales \
          libc6-dev-i386 doxygen libssl-dev dos2unix xvfb x11-utils \
          g++-multilib libssl-dev:i386 zlib1g-dev:i386 \
          libtool libtool-bin procps python3-distutils pigz socat \
          zstd iproute2 lz4 iputils-ping \
          curl libtinfo5 net-tools xterm rsync u-boot-tools unzip zip && \
        rm -rf /var/lib/apt-lists/* && \
        echo "dash dash/sh boolean false" | debconf-set-selections && \
        dpkg-reconfigure dash

ARG GROUP_ID=1000
ARG USER_ID=1001
ARG USER_NAME=build
ARG GIT_NAME="Undefined Builder"
ARG GIT_EMAIL="Undefined@github.com"


RUN groupadd $USER_NAME -g $GROUP_ID
RUN useradd -ms /bin/bash -p $USER_NAME $USER_NAME -u $USER_ID -g $GROUP_ID && \
        usermod -aG sudo $USER_NAME && \
        echo "$USER_NAME:$USER_NAME" | chpasswd
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG en_US.utf8
USER $USER_NAME
WORKDIR /home/$USER_NAME
RUN git config --global user.email "$GIT_EMAIL" && git config --global user.name "$GIT_NAME"
