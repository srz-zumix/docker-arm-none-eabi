ARG UBUNTU_VERSION=latest
FROM ubuntu:$UBUNTU_VERSION
ARG UBUNTU_VERSION

ARG DIR=8-2018q4
ARG FILE=gcc-arm-none-eabi-8-2018-q4-major
ARG OUTFILE=gcc-arm-none-eabi-8-2018-q4-major
ARG ARCHI=x86_64-linux

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

ENV DEBIAN_FRONTEND=noninteractive
# https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads
RUN dpkg --add-architecture i386 && \
  apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    build-essential clang libc6:i386 \
    bzip2 \
    git \
    cmake make \
    python \
    vim-common astyle \
    wget \
    && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p /usr/local/bin/ && \
  wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/$DIR/$FILE-$ARCHI.tar.bz2 && \
  tar -xf $FILE-$ARCHI.tar.bz2 -C /usr/local/bin/ && rm *.tar.bz2 && \
  apt-get clean

ENV PATH $PATH:/usr/local/bin/$OUTFILE/bin
ENV CC   arm-none-eabi-gcc
ENV CXX  arm-none-eabi-g++
