#!/usr/bin/env bash

set -ex

[ -d OpenXR-SDK ] || git clone --revision c15d38cb4bb10a5b7e075f74493ff13896e2597a https://github.com/KhronosGroup/OpenXR-SDK.git

pushd OpenXR-SDK
cmake -B build -DCMAKE_BUILD_TYPE=Release
if [ $(uname -s) = 'Darwin' ]; then
    NCORE=$(sysctl -n hw.ncpu)
    LIB_EXT=dylib
else
    NCORE=$(nproc)
    LIB_EXT=so
fi
cmake --build build -j$NCORE --config Release
cp build/src/loader/libopenxr_loader.* ..
popd
