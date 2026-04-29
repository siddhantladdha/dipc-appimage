#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=1.2.0
export ARCH VERSION
export OUTPATH=./dist
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=./dipc.svg
export DESKTOP=./dipc.desktop

export PATH=$PATH:$HOME/.cargo/bin

# Deploy dependencies
quick-sharun /github/home/.cargo/bin/dipc

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
