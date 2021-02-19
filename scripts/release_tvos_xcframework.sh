#!/bin/bash

GODOT_PLUGINS="gamecenter inappstore icloud apn"

# Compile Plugin
for lib in $GODOT_PLUGINS; do
    ./scripts/generate_tvos_xcframework.sh $lib release $1
    ./scripts/generate_tvos_xcframework.sh $lib release_debug $1
    mv ./bin/tvos.${lib}.release_debug.xcframework ./bin/tvos.${lib}.debug.xcframework
done

# Move to release folder

rm -rf ./bin/tvos_release
mkdir ./bin/tvos_release

# Move Plugin
for lib in $GODOT_PLUGINS; do
    mkdir ./bin/tvos_release/${lib}
    mv ./bin/tvos.${lib}.{release,debug}.xcframework ./bin/tvos_release/${lib}/
    mv ./bin/tvos_release/${lib}/tvos.${lib}.release.xcframework ./bin/tvos_release/${lib}/${lib}.release.xcframework
    mv ./bin/tvos_release/${lib}/tvos.${lib}.debug.xcframework ./bin/tvos_release/${lib}/${lib}.debug.xcframework
    cp ./plugins/${lib}/${lib}.gdatvp ./bin/tvos_release/${lib}/${lib}.gdatvp
done
