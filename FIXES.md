# Fix for generateEspeakData CMake Build Error

## Problem
The task `generateEspeakData` fails with:
```
Process 'command 'cmake'' finished with non-zero exit value 1
```

This occurs during the espeak-ng data generation phase when building libespeak-ng.so.

## Root Cause Analysis
Based on project structure analysis, the failure is in the CMake execution logic within `app/build.gradle.kts` around lines where:
- It attempts to resolve SDK's cmake at android.sdkDirectory.resolve("cmake/3.22.1/bin/cmake")
- This path may not exist or contain incompatible CMake version
- Or it fails due to Windows environment limitations with SDK-provided cmake

## Solution Options (in order of preference)

### Option 1: Fix CMake Path Resolution in build.gradle.kts
Modify the generateEspeakData task's cmake resolution logic:

```kotlin
// In app/build.gradle.kts, around lines where cmakeBin is set:
val sdkCmake = android.sdkDirectory.resolve("cmake/3.22.1/bin/cmake")
var cmakeBin = if (sdkCmake.isFile) {
    println("Using SDK CMake: ${sdkCmake.absolutePath}")
    sdkCmake.absolutePath
} else {
    "cmake" // Fall back to system cmake 
}
```

### Option 2: Ensure Submodules are Initialized  
```bash
cd C:/Users/Jacek/StudioProjects/marmalade-tts-android
git submodule update --init --recursive
```

### Option 3: Install Required Build Tools  
- Make sure you have CMake installed (version 3.22 or higher)
- Ensure the system cmake is in PATH

## Quick Test Commands 
1. `cd C:/Users/Jacek/StudioProjects/marmalade-tts-android`
2. `git submodule update --init` (if not already done)  
3. `./gradlew clean`
4. `./gradlew :app:generateEspeakData`

If the problem persists, try:
1. Open Android Studio
2. Go to File → Settings → Build, Execution, Deployment → CMake 
3. Verify SDK cmake path is correct or set it to use system CMake instead