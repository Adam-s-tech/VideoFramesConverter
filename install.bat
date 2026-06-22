@echo off
setlocal EnableExtensions

rem Install the right-click context menu for common video formats.
rem Run this script as administrator if Windows shows "Access is denied."

set "script_dir=%~dp0"
set "handler_name=VideoFramesConverter"
set "command=%script_dir%video-to-frames.bat"
set "extensions=.mp4 .mkv .mov .wmv .avi .flv .webm"

if not exist "%command%" (
    echo Error: "%command%" was not found.
    pause
    exit /b 1
)

for %%a in (%extensions%) do (
    reg add "HKCU\Software\Classes\SystemFileAssociations\%%a\shell\%handler_name%" /ve /d "Convert to Frames" /f >nul
    reg add "HKCU\Software\Classes\SystemFileAssociations\%%a\shell\%handler_name%\command" /ve /d "\"%command%\" \"%%1\"" /f >nul
)
echo Installed context menu entries successfully.
pause
