#!/usr/bin/env bash

# Get directory of this script
SD=$(dirname "$0")
CUR_DIR=$(pwd)

sudo apt update

# ESP8266
# sudo apt install -y python3-pip python-is-python3 python3-serial gcc git wget make libncurses-dev flex bison gperf

# wget https://dl.espressif.com/dl/xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz

# ESP_DIR=$(pwd)/esp

# mkdir -p ${ESP_DIR}

# tar -xzf xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz -C ${ESP_DIR}

rm xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz

# export PATH="$PATH:${ESP_DIR}/xtensa-lx106-elf/bin"

# export IDF_PATH=$(pwd)/ESP8266_RTOS_SDK

# python -m pip install --user -r $IDF_PATH/requirements.txt --break-system-packages

# ${IDF_PATH}/install.sh all

# source ${IDF_PATH}/export.sh

# cd ./WifiSocketServerRTOS

# make

# # ESP32

sudo apt-get install -y git wget flex bison gperf python3 python3-pip python3-venv python3-virtualenv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0


export IDF_PATH=${CUR_DIR}/esp-idf

cd $IDF_PATH

./install.sh esp32

. ./export.sh


cd ${CUR_DIR}/WiFiSocketServerRTOS

idf.py set-target esp32
idf.py build


