#!/bin/bash

# Universal launcher for patched-arb
# Automatically detects system and runs appropriate binary

set -e

PROJECT_NAME="patched-arb"
BINARIES_DIR="binaries"

detect_platform() {
    local os=""
    local arch=""
    
    case "$(uname -s)" in
        Linux*)     os="linux" ;;
        Darwin*)    os="macos" ;;
        CYGWIN*)    os="windows" ;;
        MINGW*)     os="windows" ;;
        MSYS*)      os="windows" ;;
        *)          os="unknown" ;;
    esac
    
    case "$(uname -m)" in
        x86_64)     arch="x86_64" ;;
        amd64)      arch="x86_64" ;;
        aarch64)    arch="aarch64" ;;
        arm64)      arch="aarch64" ;;
        armv7l)     arch="armv7" ;;
        armv6l)     arch="armv6" ;;
        *)          arch="unknown" ;;
    esac
    
    echo "${os}_${arch}"
}

find_binary() {
    local platform="$1"
    local binary_path=""
    
    local os="${platform%_*}"
    local arch="${platform#*_}"
    
    case "$arch" in
        x86_64)
            if [[ -f "${BINARIES_DIR}/${PROJECT_NAME}_x86_64-linux-glibc" && -x "${BINARIES_DIR}/${PROJECT_NAME}_x86_64-linux-glibc" ]]; then
                binary_path="${BINARIES_DIR}/${PROJECT_NAME}_x86_64-linux-glibc"
            elif [[ -f "${BINARIES_DIR}/${PROJECT_NAME}_x86_64-linux-musl" && -x "${BINARIES_DIR}/${PROJECT_NAME}_x86_64-linux-musl" ]]; then
                binary_path="${BINARIES_DIR}/${PROJECT_NAME}_x86_64-linux-musl"
            fi
            ;;
        aarch64)
            if [[ -f "${BINARIES_DIR}/${PROJECT_NAME}_aarch64-linux-musl" && -x "${BINARIES_DIR}/${PROJECT_NAME}_aarch64-linux-musl" ]]; then
                binary_path="${BINARIES_DIR}/${PROJECT_NAME}_aarch64-linux-musl"
            fi
            ;;
    esac
    
    echo "$binary_path"
}

main() {
    local platform=$(detect_platform)
    local binary_path=$(find_binary "$platform")
    
    if [[ -z "$binary_path" ]]; then
        echo "No suitable binary found for platform: $platform"
        exit 1
    fi
    
    exec "$binary_path" "$@"
}

main "$@"