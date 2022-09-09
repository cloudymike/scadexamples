#!/bin/bash
# Create stl files from scad files
# Check that the echoed output is the same as previous run
#    poor mans diff
set -e
echo "=========== Base plate ==========="
openscad -o baseplate_example.stl baseplate_example.scad |& tee baseplate_example.tmp
diff baseplate_example.ref baseplate_example.tmp

echo "=========== Top box ==========="
openscad -o topbox_example.stl topbox_example.scad |& tee topbox_example.tmp
diff topbox_example.ref topbox_example.tmp

echo Rendering OK
