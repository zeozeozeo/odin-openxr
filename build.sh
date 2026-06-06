#!/usr/bin/env bash

set -ex

clone_at_revision() {
    local dir="$1"
    local revision="$2"
    local remote="$3"
    shift 3
    if [ ! -d "$dir" ]; then
        git clone "$@" "$remote" "$dir"
    fi
    git -C "$dir" fetch --tags origin
    if ! git -C "$dir" checkout --detach "$revision"; then
        git -C "$dir" fetch origin "$revision"
        git -C "$dir" checkout --detach FETCH_HEAD
    fi
    if [ -f "$dir/.gitmodules" ]; then
        git -C "$dir" submodule update --init --recursive
    fi
}

clone_at_revision OpenXR-SDK 64f2b37c8c6da3d83c9b4d11865ba1fb752cb8ec https://github.com/KhronosGroup/OpenXR-SDK.git

linux_arch_dir() {
    case "$(uname -m)" in
        x86_64 | amd64) echo "linux_x64" ;;
        aarch64 | arm64) echo "linux_arm64" ;;
        *) echo "linux_$(uname -m)" ;;
    esac
}

pushd OpenXR-SDK
cmake -B build -DCMAKE_BUILD_TYPE=Release
if [ $(uname -s) = 'Darwin' ]; then
    NCORE=$(sysctl -n hw.ncpu)
    LIB_EXT=dylib
else
    NCORE=$(nproc)
    LIB_EXT=so
    ARCH_DIR=$(linux_arch_dir)
    mkdir -p "$ARCH_DIR"
fi
cmake --build build -j$NCORE --config Release
if [ $(uname -s) = 'Darwin' ]; then
    cp build/src/loader/libopenxr_loader.* ..
else
    cp build/src/loader/libopenxr_loader.* "../$ARCH_DIR"/
fi
popd
