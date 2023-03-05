#!/bin/bash
parallel ./testone.sh ::: $(find -name \*.scad)
if [ "$?" != "0" ]
then
  echo "Test failed"
  exit 1
fi
echo "All file passed"
