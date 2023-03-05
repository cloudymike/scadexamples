#!/bin/bash

IGNOREFILES="./electrocookie/parameters.scad ./drawer/TOUL.scad"

for FILE in $(find -name \*.scad)
do
    DIR="$(dirname "${FILE}")"
    BASE="$(basename "${FILE}")"
    pushd ${DIR} &> /dev/null
    if echo $IGNOREFILES | grep -wq $FILE
    then
      echo "Skipping $FILE"
    else
      echo "Testing $BASE in $DIR"
      STLFILE="${BASE%.*}.stl"
      time openscad -o $STLFILE --hardwarnings -D '$fn=2' $BASE
      if [ "$?" != "0" ]
      then
          echo "FAIL: $FILE"
          exit 1
      fi
    fi
    popd &> /dev/null
done
echo "All file passed"
