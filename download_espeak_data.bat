@echo off
REM Simple download script for prebuilt espeak-ng-data

echo Downloading prebuilt espeak-ng-data...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/k2-fsa/sherpa-onnx/releases/download/tts-models/espeak-ng-data.tar.bz2' -OutFile 'espeak-ng-data.tar.bz2'"

if %errorlevel% equ 0 (
    echo Extracting archive...
    mkdir "C:\Users\Jacek\StudioProjects\marmalade-tts-android\app\build\generated\espeakAssets\espeak" 2>nul
    powershell -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('espeak-ng-data.tar.bz2', 'C:\Users\Jacek\StudioProjects\marmalade-tts-android\app\build\generated\espeakAssets\espeak')}"
    if %errorlevel% equ 0 (
        echo Extraction successful
        del espeak-ng-data.tar.bz2
        echo Cleanup complete
    ) else (
        echo Failed to extract archive
        exit /b 1
    )
) else (
    echo Failed to download archive
    exit /b 1
)

echo Prebuilt data extraction complete.