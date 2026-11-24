#!/bin/bash

echo "Downloading prebuilt espeak-ng-data..."
curl -L -o espeak-ng-data.tar.bz2 "https://github.com/k2-fsa/sherpa-onnx/releases/download/tts-models/espeak-ng-data.tar.bz2"

if [ $? -ne 0 ]; then
    echo "Failed to download espeak-ng-data.tar.bz2"
    exit 1
fi

echo "Extracting archive..."
mkdir -p /c/Users/Jacek/StudioProjects/marmalade-tts-android/app/build/generated/espeakAssets/espeak
tar -xjf espeak-ng-data.tar.bz2 -C /c/Users/Jacek/StudioProjects/marmalade-tts-android/app/build/generated/espeakAssets/espeak/

if [ $? -ne 0 ]; then
    echo "Failed to extract archive"
    exit 1
fi

echo "Cleaning up..."
rm espeak-ng-data.tar.bz2

echo "Prebuilt data extraction complete."