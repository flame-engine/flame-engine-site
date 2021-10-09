#!/bin/bash -x

MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"
cd $MY_PATH
rm -rf ../docs/*

./generate-landing.sh
cd $MY_PATH
cp -r ../landing/flame_engine_web/build/web/* ../docs

cd $MY_PATH
echo $(pwd)
cp ../permanent-files/CNAME ../docs
cp ../permanent-files/404.html ../docs
cp -r ../permanent-files/merch ../docs
cp -r ../permanent-files/docs ../docs
