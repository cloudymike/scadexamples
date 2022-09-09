#!/bin/bash
# Create stl files from scad files
# Check that the echoed output is the same as previous run
#    poor mans diff
set -e
echo "=========== Base plate ==========="
openscad -o baseplate.stl baseplate.scad |& tee baseplate.tmp
diff baseplate.ref baseplate.tmp

echo "=========== Top box ==========="
openscad -o topbox.stl topbox.scad |& tee topbox.tmp
diff topbox.ref topbox.tmp

echo Rendering OK
