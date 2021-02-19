#!/bin/bash

# Compile static libraries

# ARM64 Device
scons platform=tvos target=$2 arch=arm64 plugin=$1 version=$3
# x86_64 Simulator
scons platform=tvos target=$2 arch=x86_64 simulator=yes plugin=$1 version=$3
# ARM64 Simulator
scons platform=tvos target=$2 arch=arm64 simulator=yes plugin=$1 version=$3

# Creating a fat libraries for device and simulator
# lib<plugin>.<arch>-<simulator|iphone>.<release|debug|release_debug>.a
lipo -create "./bin/lib$1.x86_64-tvossimulator.$2.a" "./bin/lib$1.arm64-tvossimulator.$2.a" -output "./bin/$1-tvossimulator.$2.a"
cp "./bin/lib$1.arm64-tvosdevice.$2.a" "./bin/$1-tvosdevice.$2.a"

# Creating a xcframework 
xcodebuild -create-xcframework \
    -library "./bin/$1-tvosdevice.$2.a" \
    -library "./bin/$1-tvossimulator.$2.a" \
    -output "./bin/tvos.$1.$2.xcframework"
