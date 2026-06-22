@echo off
setlocal EnableExtensions

rem Convert a video file into individual frames using ffmpeg.

if "%~1"=="" (
    echo Usage: drag and drop a video file onto this script, or use the context menu.
    pause
    exit /b 1
)

set "input_video_file=%~dpnx1"
set "output_dir=%~dp1%~n1"
set "ffmpeg_exe=ffmpeg"

where "%ffmpeg_exe%" >nul 2>nul
if errorlevel 1 (
    echo Error: ffmpeg was not found in PATH.
    echo Install ffmpeg and make sure it is available from the command line.
    pause
    exit /b 1
)

if exist "%output_dir%" (
    echo Output folder already exists: "%output_dir%"
    echo Please delete it or choose another video file.
    pause
    exit /b 1
)

mkdir "%output_dir%" 2>nul
if errorlevel 1 (
    echo Error: could not create output folder "%output_dir%".
    pause
    exit /b 1
)

echo Extracting frames from:
echo   "%input_video_file%"
echo To:
echo   "%output_dir%"

"%ffmpeg_exe%" -i "%input_video_file%" -vsync 0 "%output_dir%\%%03d.bmp"
if errorlevel 1 (
    echo Error: ffmpeg failed while extracting frames.
    pause
    exit /b 1
)

echo Done.
pause
