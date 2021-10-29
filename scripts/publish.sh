#!/bin/bash -xe

function generate() {
  ./scripts/generate-build.sh
  ./scripts/generate-landing.sh
}

function git_push() {
  git config --global user.email "luanpotter27@gmail.com"
  git config --global user.name "Luan Nico"
  git add -A
  git commit -m "Deploy new website version"
  git push
}

function main() {
  generate()
  git_push()
}

main
