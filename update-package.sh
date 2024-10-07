#!/bin/bash
VERSION=$1

set -x

# Check Semver
if [[ ! $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid version: $VERSION"
    exit 1
fi

# Get file directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SRC_DIR="$DIR/"
DEST_DIR="$DIR/../packages/packages/preview/resume-ng/$VERSION"

if [ -d "$DEST_DIR" ]; then
  echo "$DEST_DIR already exists, remove it"
  rm -rf $DEST_DIR
fi

cp -r $SRC_DIR $DEST_DIR

pushd $SRC_DIR
cd $DEST_DIR || exit

rm -rf .git
mv README-typst.md README.md
rm example-main.pdf
rm update-package.sh

popd
