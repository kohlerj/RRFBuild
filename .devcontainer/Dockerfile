# Docker file for RRF development container

# It contains all necessary tools to build RRF 
# - build essentials
# - git
# - python3 and pip
# - ARM GCC toolchain
# - dotnet SDK

# We do not install ESP32 and ESP8266 toolchains here to keep the image size small.

# Use debian as base image
FROM mcr.microsoft.com/vscode/devcontainers/base:debian

# Standard tools 
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        git \
        gawk \
        wget \
        flex \
        bison \
        gperf \
        python3 \
        python3-pip \
        python3-setuptools \
        python3-serial \
        python3-venv \
        python-is-python3 \
        python3-virtualenv \
        cmake \
        ninja-build \
        ccache \
        libffi-dev \
        libssl-dev \
        dfu-util \
        libusb-1.0-0-dev \
        libncurses5-dev \
        libncursesw5-dev \
        autoconf \
        automake \
        libtool \
        unzip \
        xz-utils \
        file \
    && rm -rf /var/lib/apt/lists/*

# Install the ARM toolchain
RUN mkdir -p /tmp

# Look for an env variable DEVCONTAINER_ARM_GCC_VERSION to specify the version of the toolchain
# Default to 14.3.rel1 if not specified
ARG DEVCONTAINER_ARM_GCC_VERSION=14.3.rel1

# Install ARM GCC toolchain
RUN wget -q https://developer.arm.com/-/media/Files/downloads/gnu/${DEVCONTAINER_ARM_GCC_VERSION}/binrel/arm-gnu-toolchain-${DEVCONTAINER_ARM_GCC_VERSION}-x86_64-arm-none-eabi.tar.xz -O /tmp/arm-gnu-toolchain-${DEVCONTAINER_ARM_GCC_VERSION}-x86_64-arm-none-eabi.tar.xz \
    && tar -xJf /tmp/arm-gnu-toolchain-${DEVCONTAINER_ARM_GCC_VERSION}-x86_64-arm-none-eabi.tar.xz -C /opt/ \
    && rm /tmp/arm-gnu-toolchain-${DEVCONTAINER_ARM_GCC_VERSION}-x86_64-arm-none-eabi.tar.xz

# Add ARM toolchain to PATH
ENV PATH="/opt/arm-gnu-toolchain-${DEVCONTAINER_ARM_GCC_VERSION}-x86_64-arm-none-eabi/bin:${PATH}"

# Install NPM
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        npm \
    && rm -rf /var/lib/apt/lists/*

# Clean up
RUN rm -rf /tmp/*

# Move to workspace folder
WORKDIR /workspace

ENTRYPOINT [ "/bin/bash" ]
