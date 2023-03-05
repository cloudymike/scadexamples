#!/bin/bash
EXITCODE=0
for FILE in $(find -name \*.scad)
do
  ./testone.sh $FILE
  if [ "$?" != "0" ]
  then
    echo "Test failed"
    exit 1
  fi
done
echo "All file passed"
