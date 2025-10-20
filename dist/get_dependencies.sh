#!/usr/bin/env bash

# Get directory of this script
SD=$(dirname "$0")

source ${SD}/repositories.env

# For each url if the reference is not specified, it defaults to 'main'
if [ -z "${REPRAPFIRMWARE_REF}" ]; then
    REPRAPFIRMWARE_REF="main"
fi
if [ -z "${RRF_LIBRARIES_REF}" ]; then
    RRF_LIBRARIES_REF="main"
fi
if [ -z "${COREN2G_REF}" ]; then
    COREN2G_REF="main"
fi
if [ -z "${RRF_FREERTOS_REF}" ]; then
    RRF_FREERTOS_REF="main"
fi
if [ -z "${CAN_LIB_REF}" ]; then
    CAN_LIB_REF="main"
fi
if [ -z "${DUETWIFISOCKETSERVER_REF}" ]; then
    DUETWIFISOCKETSERVER_REF="main"
fi
if [ -z "${DUET3EXPANSION_REF}" ]; then
    DUET3EXPANSION_REF="main"
fi
if [ -z "${IAP_REF}" ]; then
    IAP_REF="main"
fi
if [ -z "${RRF_ESP32_SDK_REF}" ]; then
    RRF_ESP32_SDK_REF="dwss_support_2.1"
fi
if [ -z "${RRF_ESP8266_SDK_REF}" ]; then
    RRF_ESP8266_SDK_REF="dwss_support"
fi
if [ -z "${WIFISOCKERSERVER_REF}" ]; then
    WIFISOCKERSERVER_REF="ethernet"
fi
if [ -z "${DUETWEBCONTROL_REF}" ]; then
    DUETWEBCONTROL_REF="main"
fi

clone_repo() {
    local url="$1"
    local ref="$2"
    shift 2
    local extra_args=("$@")

    # Determine directory name
    local dir
    dir="$(basename "${url%.git}")"

    # If ref looks like a commit hash and is NOT a branch/tag name on remote, do full clone then checkout
    if [[ "$ref" =~ ^[0-9a-f]{7,40}$ ]] && ! git ls-remote --exit-code "$url" "$ref" >/dev/null 2>&1; then
        echo "Cloning full repository (commit checkout): $url @ $ref"
        git clone "${extra_args[@]}" --no-tags "$url" || return 1
        (cd "$dir" && git checkout "$ref") || return 1
    else
        echo "Cloning (branch/tag): $url @ $ref"
        git clone "${extra_args[@]}" --depth 1 --single-branch --branch "$ref" --no-tags "$url" || return 1
    fi
}

clone_repo "${REPRAPFIRMWARE_URL}"     "${REPRAPFIRMWARE_REF}"
clone_repo "${RRF_LIBRARIES_URL}"      "${RRF_LIBRARIES_REF}"
clone_repo "${COREN2G_URL}"            "${COREN2G_REF}"
clone_repo "${RRF_FREERTOS_URL}"       "${RRF_FREERTOS_REF}"
clone_repo "${CAN_LIB_URL}"            "${CAN_LIB_REF}"
clone_repo "${DUETWIFISOCKETSERVER_URL}" "${DUETWIFISOCKETSERVER_REF}"
clone_repo "${DUET3EXPANSION_URL}"     "${DUET3EXPANSION_REF}" 
clone_repo "${IAP_URL}"                "${IAP_REF}"
# In IAP we need to set some files permissions to be executable
find IAP/makefiles -type f -name "*.sh" -exec chmod +x {} \; || exit 1

clone_repo "${RRF_ESP32_SDK_URL}"      "${RRF_ESP32_SDK_REF}" --recursive
clone_repo "${RRF_ESP8266_SDK_URL}"    "${RRF_ESP8266_SDK_REF}" --recursive
clone_repo "${WIFISOCKERSERVER_URL}"   "${WIFISOCKERSERVER_REF}"
clone_repo "${DUETWEBCONTROL_URL}"     "${DUETWEBCONTROL_REF}"
