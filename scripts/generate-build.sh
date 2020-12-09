#!/bin/bash -x
echo $0
MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"
cd $MY_PATH
rm -rf ../docs/*

../landing/scripts/generate-build.sh
cd $MY_PATH
cp -r ../landing/build/* ../docs
cp ../permanent-files/.nojekyll ../docs

../docs-source/scripts/update-docs.sh
cd $MY_PATH
cp -r ../docs-source ../docs
mv ../docs/docs-source ../docs/docs

cd $MY_PATH
cp ../permanent-files/CNAME ../docs
cp ../permanent-files/.nojekyll ../docs
cp ../permanent-files/404.html ../docs
cp -r ../permanent-files/merch ../docs
