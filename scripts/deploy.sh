#!/bin/bash -x
echo $0
MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"
cd $MY_PATH

rm -rf ../../catapimbas
mkdir ../../catapimbas
cp -r ./build/* ../../catapimbas
git checkout gh-pages
git pull
rm -rf ./*
cp -r ../../catapimbas/* ./
git add all
git commit -m "auto update"
git push
git checkout -

