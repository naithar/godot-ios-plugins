#!/bin/bash

GODOT_PLUGINS="gamecenter inappstore icloud camera arkit apn"

# Compile Plugin
for lib in $GODOT_PLUGINS; do
    ./scripts/generate_ios_xcframework.sh $lib release $1
    ./scripts/generate_ios_xcframework.sh $lib release_debug $1
    mv ./bin/ios.${lib}.release_debug.xcframework ./bin/ios.${lib}.debug.xcframework
done

# Move to release folder

rm -rf ./bin/ios_release
mkdir ./bin/ios_release

# Move Plugin
for lib in $GODOT_PLUGINS; do
    mkdir ./bin/ios_release/${lib}
    mv ./bin/ios.${lib}.{release,debug}.xcframework ./bin/ios_release/${lib}/
    mv ./bin/ios_release/${lib}/ios.${lib}.release.xcframework ./bin/ios_release/${lib}/${lib}.release.xcframework
    mv ./bin/ios_release/${lib}/ios.${lib}.debug.xcframework ./bin/ios_release/${lib}/${lib}.debug.xcframework
    cp ./plugins/${lib}/${lib}.gdip ./bin/ios_release/${lib}/${lib}.gdip
done
