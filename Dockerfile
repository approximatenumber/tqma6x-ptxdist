FROM ubuntu:18.04

ARG PTXDIST_VERSION=ptxdist-2019.01.0

RUN apt-get update && \
    apt-get install -y -qq \
        autoconf \
        gcc \
        g++ \
        automake \
        make \
        python2.7 \
        python2.7-dev \
        python3 \
        python3-dev \
        flex \
        bison \
        gawk \
        gettext \
        texinfo \
        git \
        wget \
        pkg-config \
        ncurses-dev \
        libpython3.7 \
        bc \
        libxkbcommon0 \
        libxkbcommon-dev \
        libfreetype6-dev \
        man \
        python3-pip \
        curl \
        libx11-dev \
        libgl-dev \
        libgles2-mesa-dev \
        libgbm-dev \
        libjpeg-dev \
        nano && \
        dialog && \
    apt-get clean


COPY ./ptxdist-patches /ptxdist-patches
RUN git clone -b ${PTXDIST_VERSION} https://git.pengutronix.de/git/ptxdist ptxdist-src && \
    cd ptxdist-src && \
    git config user.name "docker" && \
    git config user.email "docker@$HOSTNAME" && \
    git am -3 -k ../ptxdist-patches/*.patch && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf ptxdist-src ptxdist-patches

COPY ./OSELAS.Toolchain-2018.02.0-ubuntu18-bin.tar.gz /
RUN tar -xvf /OSELAS.Toolchain-2018.02.0-ubuntu18-bin.tar.gz -C /opt && \
    rm /OSELAS.Toolchain-2018.02.0-ubuntu18-bin.tar.gz
ENV PATH="/opt/OSELAS.Toolchain-2018.02.0/arm-v7a-linux-gnueabihf/gcc-7.3.1-glibc-2.27-binutils-2.30-kernel-4.15-sanitized/bin:${PATH}"

RUN useradd -m ptxdist
USER ptxdist
WORKDIR "/"
