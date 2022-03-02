#!/bin/bash

set -ex

# cd script dir
cd "$(dirname "$0")" || exit

GIT_ROOT=$(pwd)

rm -rf build 戴铭的开发小册子.app
cd SwiftPamphletApp
if grep -q 'gitHubAccessToken = ""' ./SwiftPamphletAppConfig.swift ; then
    echo "please setup your personal access token to SwiftPamphletAppConfig.swift" && exit
fi
cd ..

xcodebuild -project "$GIT_ROOT/SwiftPamphletApp.xcodeproj" \
 -scheme SwiftPamphletApp -configuration Release \
 -derivedDataPath "$GIT_ROOT/build" \
 -destination 'generic/platform=macOS' \
 -sdk macosx \
 clean build \
 CODE_SIGNING_REQUIRED=NO \
 CODE_SIGN_IDENTITY="" \

cp -R $GIT_ROOT/build/Build/Products/Release/戴铭的开发小册子.app $GIT_ROOT
