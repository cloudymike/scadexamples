#!/bin/bash
FILE=potfoot/smallcrockpot.scad
DIR="$(dirname "${FILE}")"
BASE="$(basename "${FILE}")"
pushd ${DIR} &> /dev/null
echo "Testing $BASE in $DIR"
STLFILE="${BASE%.*}.stl"
openscad -o $STLFILE $BASE
if [ "$?" != "0" ]
then
    echo "FAIL: $FILE"
    exit 1
fi
popd &> /dev/null
echo "All file passed"
