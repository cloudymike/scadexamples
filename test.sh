#!/bin/bash

IGNOREFILES="./electrocookie/parameters.scad"

for FILE in $(find -name \*.scad)
do
    if echo $IGNOREFILES | grep -wq $FILE
    then
      echo "Skipping $FILE"
    else
      echo "Testing $FILE"
      STLFILE="${FILE%.*}.stl"
      openscad -o $STLFILE $FILE
      if [ "$?" != "0" ]
      then
          echo "FAIL: $FILE"
          exit 1
      fi
    fi
done
echo "All file passed"
