@echo off

setlocal EnableDelayedExpansion

if not exist OpenXR-SDK (
   git clone --revision c15d38cb4bb10a5b7e075f74493ff13896e2597a https://github.com/KhronosGroup/OpenXR-SDK.git
)

pushd OpenXR-SDK
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j%NUMBER_OF_PROCESSORS% --config Release

REM copy /y build\
popd
