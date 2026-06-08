@echo off
where py >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    py -3 "%~dp0build.py" %*
    exit /b %ERRORLEVEL%
)

python "%~dp0build.py" %*
exit /b %ERRORLEVEL%
