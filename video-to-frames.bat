@echo off
setlocal EnableExtensions

rem Convert a video file into individual frames using ffmpeg.

if "%~1"=="" (
    echo Usage: drag and drop a video file onto this script, or use the context menu.
    pause
    exit /b 1
)

set "input_video_file=%~dpnx1"
set "base_output_dir=%~dp1%~n1"
set "output_dir=%base_output_dir%"
set "ffmpeg_exe=ffmpeg"
set "jpeg_quality=2"

where "%ffmpeg_exe%" >nul 2>nul
if errorlevel 1 (
    echo Error: ffmpeg was not found in PATH.
    echo Install ffmpeg and make sure it is available from the command line.
    pause
    exit /b 1
)

set /a "output_dir_suffix=2"
set /a "output_dir_search_attempts=0"
:find_available_output_dir
if exist "%output_dir%" (
    set /a "output_dir_search_attempts+=1"
    if %output_dir_search_attempts% geq 10000 (
        echo Error: could not find an available output folder name.
        pause
        exit /b 1
    )
    set "output_dir=%base_output_dir%_%output_dir_suffix%"
    set /a "output_dir_suffix+=1"
    goto :find_available_output_dir
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

"%ffmpeg_exe%" -i "%input_video_file%" -vsync 0 -q:v %jpeg_quality% -stats -loglevel error "%output_dir%\%%03d.jpg"
if errorlevel 1 (
    echo Error: ffmpeg failed while extracting frames.
    pause
    exit /b 1
)

echo Done.
explorer "%output_dir%"
pause
