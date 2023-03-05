#!/bin/bash
LIBRARYDIR=$HOME/.local/share/OpenSCAD/libraries
mkdir -p ${LIBRARYDIR}


# Install BOLS library
BOSLVERSION="1.0.3"
pushd ${LIBRARYDIR}
wget https://github.com/revarbat/BOSL/archive/refs/tags/v${BOSLVERSION}.tar.gz
tar xvzf v${BOSLVERSION}.tar.gz
rm -f v${BOSLVERSION}.tar.gz
rm -rf BOSL
mv BOSL-${BOSLVERSION} BOSL
popd

#Debugging info
echo "Home is ${HOME}"
echo "OPENSCAD library directory:"
ls -l ${LIBRARYDIR}
echo "OPENSCAD directory:"
ls -l $HOME/.local/share/OpenSCAD
#openscad --info
