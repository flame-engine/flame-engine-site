#!/bin/bash -x
MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

cd $MY_PATH
cd ../landing/flame_engine_web
flutter pub get
flutter build web --release
