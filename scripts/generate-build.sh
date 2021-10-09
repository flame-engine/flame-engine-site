#!/bin/bash -x

MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"
cd $MY_PATH
rm -rf ../docs/*

./generate-landing.sh
cd $MY_PATH
cp -r ../landing/build/* ../docs

cd $MY_PATH
cp ../permanent-files/CNAME ../docs
cp ../permanent-files/404.html ../docs
cp -r ../permanent-files/merch ../docs
cp -r ../permanent-files/docs ../docs
