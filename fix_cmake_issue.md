# CMake Build Issue Fix for Marmalade TTS

## Problem Analysis:
The error `Process 'command 'cmake'' finished with non-zero exit value 1` occurs in the `generateEspeakData` task, which compiles espeak-ng dictionaries during build.

## Solutions:

### Solution 1: Clean and Rebuild
```
./gradlew clean
./gradlew :app:assembleDebug
```

### Solution 2: Update Submodules
```
git submodule update --init --recursive
```

### Solution 3: Verify CMake Installation (if using command line)
```bash
# Check if cmake is available in Android SDK path
ls $ANDROID_HOME/cmake/3.22.1/bin/
cmake --version
```

### Solution 4: Add More Debugging to the Build Script
Modify `app/build.gradle.kts` around lines 428-435 to add more debugging information.

The issue is likely related to:
1. CMake version mismatch
2. Missing build dependencies 
3. Environment setup in CI/development environment
4. Path issues with espeak-ng submodule

This might be a specific environment problem that affects the host-based espeak data compilation step, which should work on most systems but might have permission or path issues.