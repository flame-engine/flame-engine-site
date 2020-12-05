#!/bin/bash -x
MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

cd $MY_PATH
cd ..
git clone git@github.com:flame-engine/flame.git tempflame --depth 1 -b renan.fix-docs
rm -rf ./docs
mv tempflame/doc ./
mv ./doc ./docs
rm -rf tempflame
