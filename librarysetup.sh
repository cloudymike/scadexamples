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

# Install BOLS2 library
BOSLVERSION="1.0.3"
pushd ${LIBRARYDIR}
wget https://github.com/BelfrySCAD/BOSL2/archive/refs/heads/master.zip
unzip master.zip
rm -f master.zip
rm -rf BOSL2
mv BOSL2-master BOSL2
popd

# Install MCAD library
MCADVERSION="2019.05"
pushd ${LIBRARYDIR}
wget https://github.com/openscad/MCAD/archive/refs/tags/openscad-${MCADVERSION}.tar.gz
tar xvzf openscad-${MCADVERSION}.tar.gz
rm -f openscad-${MCADVERSION}.tar.gz
rm -rf MCAD
mv MCAD-openscad-${MCADVERSION} MCAD
popd
