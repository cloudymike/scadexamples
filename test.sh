#!/bin/bash

for FILE in $(find -name \*.scad); do # Not recommended, will break on whitespace
    echo "Testing $FILE"
    STLFILE="${FILE%.*}.stl"
    openscad -o $STLFILE $FILE
    if [ "$?" != "0" ]
    then
        echo "FAIL: $FILE"
        exit 1
    fi
done
echo "All file passed"
