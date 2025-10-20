#!/usr/bin/env bash

# Get directory of this script
SD=$(dirname "$0")
CUR_DIR=$(pwd)

cd ${CUR_DIR}/WiFiSocketServerRTOS
VER=`awk 'sub(/.*VERSION_MAIN/,""){print $1}' src/Config.h  | awk 'gsub(/"/, "", $1)'`
OUTPUT=releases/${VER}
mkdir -p ${OUTPUT}

cd ${CUR_DIR}

sudo apt update

# ESP8266
# wget https://dl.espressif.com/dl/xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz

# ESP_DIR=$(pwd)/esp

# mkdir -p ${ESP_DIR}

# tar -xzf xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz -C ${ESP_DIR}

# rm xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz

# export PATH="$PATH:${ESP_DIR}/xtensa-lx106-elf/bin"

# export IDF_PATH=$(pwd)/ESP8266_RTOS_SDK

# python -m pip install --user -r $IDF_PATH/requirements.txt --break-system-packages

# ${IDF_PATH}/install.sh all

# source ${IDF_PATH}/export.sh

# cd ./WifiSocketServerRTOS

# make

### ESP32 ###
export IDF_PATH=${CUR_DIR}/esp-idf

cd $IDF_PATH

./install.sh esp32

. ./export.sh

cd ${CUR_DIR}/WiFiSocketServerRTOS

idf.py set-target esp32
idf.py build
cp build/DuetWiFiModule_32.bin ${OUTPUT}/WiFiModule_esp32.bin

idf.py -DSUPPORT_ETHERNET=1 build
cp build/DuetWiFiModule_32.bin ${OUTPUT}/WiFiModule_esp32eth.bin

