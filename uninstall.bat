@echo off
setlocal EnableExtensions

rem Uninstall the right-click context menu entries added by install.bat.

set "handler_name=VideoFramesConverter"
set "extensions=.mp4 .mkv .mov .wmv .avi .flv .webm"

for %%a in (%extensions%) do (
    reg delete "HKCU\Software\Classes\SystemFileAssociations\%%a\shell\%handler_name%" /f >nul 2>nul
)
echo Uninstalled context menu entries successfully.
pause
