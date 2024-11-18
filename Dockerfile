FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN \
        dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -yq sudo vim gawk wget git libncurses5 diffstat unzip texinfo \
        gcc build-essential chrpath socat cpio python3 python3-pip \
        python3-pexpect xz-utils debianutils iputils-ping python3-git \
        python3-jinja2 python3-subunit zstd liblz4-tool file locales libacl1 &&\
        rm -rf /var/lib/apt-lists/* && \
        echo "dash dash/sh boolean false" | debconf-set-selections && \
        dpkg-reconfigure dash

ARG GROUP_ID=1000
ARG USER_ID=1001
ARG USER_NAME=build
ARG GIT_NAME="Undefined Builder"
ARG GIT_EMAIL="Undefined@github.com"


RUN groupadd $USER_NAME  -fg $GROUP_ID 
RUN useradd -ms /bin/bash -p $USER_NAME $USER_NAME -u $USER_ID -g $GROUP_ID && \
        usermod -aG sudo $USER_NAME && \
        echo "$USER_NAME:$USER_NAME" | chpasswd
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.utf8
USER $USER_NAME
WORKDIR /home/$USER_NAME
RUN git config --global user.email "$GIT_EMAIL" && git config --global user.name "$GIT_NAME"
