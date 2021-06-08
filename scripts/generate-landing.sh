#!/bin/bash -x
MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

cd $MY_PATH
rm -rf ../build
cd ../landing/flame_engine_web
flutter pub get
flutter build web --release
cd ..
cp -r flame_engine_web/build/web ./
mv ./web ./build
