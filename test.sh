#!/bin/bash

IGNOREFILES="./worktable/dimple_vectors.scad ./electrocookie/parameters.scad ./drawer/TOUL.scad"
IGNOREDIRS="./Write.scad ./scad-utils"

for FILE in $(find -name \*.scad)
do
    DIR="$(dirname "${FILE}")" 
    BASE="$(basename "${FILE}")"
    pushd ${DIR} &> /dev/null
    if echo $IGNOREFILES | grep -wq $FILE
    then
      echo "Skipping file $FILE"
    elif echo $IGNOREDIRS | grep -wq $DIR
    then  
      echo "Skipping directory $DIR"
    elif echo $DIR | grep '.git'
    then
        echo "Skipping git hidden files"
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
