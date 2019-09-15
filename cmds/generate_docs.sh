#!/bin/bash -x

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

cd ./cmds/generate_docs
npm install

cd ../..
rm -rf build/
mkdir -p build/docs
node ./cmds/generate_docs/index.js
