#!/bin/bash

set -e

export PTXDIST_VERSION=ptxdist-2019.01.0

echo "### Installing needed packages"
apt-get update
apt-get install -y -qq \
    gcc \
    g++ \
    autoconf \
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
    nano \
    sudo
apt-get clean

echo "### Configuring OS"
useradd -m ptxuser
echo "ptxuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ptxuser

echo "### Installing PTXDist"
git clone -b ${PTXDIST_VERSION} https://git.pengutronix.de/git/ptxdist ptxdist-src
pushd ptxdist-src
git config user.name "$USERNAME"
git config user.email "$USERNAME@$HOSTNAME"
git am -3 -k ../ptxdist-patches/*.patch
./autogen.sh
./configure
make
make install
popd
rm -rf ptxdist-src

echo "### Installing OSELAS toolchain"
pushd /opt
tar -xvf /image/OSELAS.Toolchain-2018.02.0-ubuntu18-bin.tar.gz
popd
