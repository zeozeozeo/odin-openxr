@echo off

setlocal EnableDelayedExpansion
set BUILD_DIR=build_windows

if not exist OpenXR-SDK (
   git clone --revision c15d38cb4bb10a5b7e075f74493ff13896e2597a https://github.com/KhronosGroup/OpenXR-SDK.git || exit /b 1
)

pushd OpenXR-SDK || exit /b 1
REM DUMBAI: Use a dedicated Windows build directory so this script does not collide with older generator caches.
cmake -B %BUILD_DIR% -A x64 -DCMAKE_BUILD_TYPE=Release || exit /b 1
cmake --build %BUILD_DIR% -j%NUMBER_OF_PROCESSORS% --config Release || exit /b 1

if not exist %BUILD_DIR%\src\loader\Release\openxr_loader.lib (
    echo ERROR: Could not find %BUILD_DIR%\src\loader\Release\openxr_loader.lib.
    exit /b 1
)

REM DUMBAI: Refresh the top-level loader import library that the Odin bindings use on Windows.
copy /y %BUILD_DIR%\src\loader\Release\openxr_loader.lib ..\openxr_loader.lib >nul || exit /b 1
popd

echo Build completed successfully!
