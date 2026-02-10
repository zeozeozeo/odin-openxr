@echo off

setlocal EnableDelayedExpansion

if not exist OpenXR-SDK (
   git clone https://github.com/KhronosGroup/OpenXR-SDK.git
)

pushd OpenXR-SDK
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j%NUMBER_OF_PROCESSORS% --config Release

REM copy /y build\
popd
