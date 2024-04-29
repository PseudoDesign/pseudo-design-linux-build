FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /build
COPY system-requirements.txt /build

RUN \
        dpkg --add-architecture i386 && \
        apt update && \
        xargs -a <(awk '! /^ *(#|$)/' "/build/system-requirements.txt") -r -- sudo apt-get install && \
        rm -rf /var/lib/apt-lists/* && \
        echo "dash dash/sh boolean false" | debconf-set-selections && \
        dpkg-reconfigure dash
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo && chmod a+x /bin/repo

ARG GROUP_ID=1000
ARG USER_ID=1001
ARG USER_NAME=build
ARG GIT_NAME="Undefined Builder"
ARG GIT_EMAIL="Undefined@github.com"


RUN groupadd $USER_NAME -g $GROUP_ID
RUN useradd -ms /bin/bash -p $USER_NAME $USER_NAME -u 1028 -g $GROUP_ID && \
        usermod -aG sudo $USER_NAME && \
        echo "$USER_NAME:$USER_NAME" | chpasswd
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG en_US.utf8
USER $USER_NAME
WORKDIR /home/$USER_NAME
RUN git config --global user.email "$GIT_EMAIL" && git config --global user.name "$GIT_NAME"
