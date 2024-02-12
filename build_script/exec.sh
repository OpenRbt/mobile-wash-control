#!/bin/bash

#Cleaning old build result
rm -rf /out/*

#Caching local src for build purposes
mkdir /mobile_wash_control
cp -r /src/* /mobile_wash_control
cd /mobile_wash_control

#Recreating platform-cpecific source files
rm -rf ./linux
flutter create --platform=linux .

#Building app
flutter clean
flutter build linux --dart-define-from-file=build_config.json --release

#Saving build to output directory
cp -r ./build/linux/x64/release/bundle/ /out
