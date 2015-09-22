#!/bin/bash

SOURCE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BUILD_DIR=`mktemp -d`

# copy_resource SOURCE_FILE DESTINATION_DIRECTORY [OPTIONS]
copy_resource ()
{
  local SRC_FILE DEST_DIR

  SRC_FILE=${SOURCE_DIR}/$1
  DEST_DIR=${BUILD_DIR}/$2

  mkdir -p "${DEST_DIR}"

  cp $3 "${SRC_FILE}" "${DEST_DIR}"
}

copy_resource deb/DEBIAN "" -r
copy_resource src/git-submit usr/local/bin
copy_resource src/git-submit.1 usr/local/share/man/man1

dpkg-deb --build "${BUILD_DIR}" "${SOURCE_DIR}"

rm -r "${BUILD_DIR}"

