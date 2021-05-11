#!/bin/bash -x
MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

cd $MY_PATH
cd ..
git clone git@github.com:flame-engine/flame.git tempflame --depth 1 -b 1.0.0-rc10
rm -rf ./docs/docs
mv tempflame/doc ./docs
mv ./docs/doc ./docs/docs
rm -rf tempflame
rm -rf ./docs/docs/examples

cp -r ./docs-source/* ./docs/docs
cp ./docs-source/.nojekyll ./docs/docs
