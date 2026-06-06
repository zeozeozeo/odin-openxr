@echo off

setlocal EnableDelayedExpansion
set SDK_REVISION=64f2b37c8c6da3d83c9b4d11865ba1fb752cb8ec

if not exist OpenXR-SDK (
   git clone https://github.com/KhronosGroup/OpenXR-SDK.git || exit /b 1
)

git -C OpenXR-SDK fetch --tags origin || exit /b 1
git -C OpenXR-SDK checkout --detach %SDK_REVISION% || exit /b 1
git -C OpenXR-SDK submodule update --init --recursive || exit /b 1

pushd OpenXR-SDK || exit /b 1

where clang-cl >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    set "BUILD_DIR=build_windows_clang"
    cmake -S . -B !BUILD_DIR! -G Ninja ^
        -DCMAKE_BUILD_TYPE=Release ^
        -DCMAKE_C_COMPILER=clang-cl ^
        -DCMAKE_CXX_COMPILER=clang-cl || exit /b 1
) else (
    set "BUILD_DIR=build_windows"
    cmake -S . -B !BUILD_DIR! -A x64 -DCMAKE_BUILD_TYPE=Release || exit /b 1
)

cmake --build !BUILD_DIR! --parallel %NUMBER_OF_PROCESSORS% --config Release || exit /b 1

if not exist !BUILD_DIR!\src\loader\Release\openxr_loader.lib (
    if not exist !BUILD_DIR!\src\loader\openxr_loader.lib (
        echo ERROR: Could not find the built openxr_loader.lib in !BUILD_DIR!\src\loader.
        exit /b 1
    )
    copy /y !BUILD_DIR!\src\loader\openxr_loader.lib ..\openxr_loader.lib >nul || exit /b 1
) else (
    copy /y !BUILD_DIR!\src\loader\Release\openxr_loader.lib ..\openxr_loader.lib >nul || exit /b 1
)

popd

echo Build completed successfully!
