
railX=22.0;
railY=20;
railZ=8;

frameThickness=2;
frameHeight=6;



guardholeD=6.37;
holeD=5.24;

holeDistance=16-guardholeD/2-holeD/2;
echo(holeDistance);

guardholeX=0;
guardholeY=-holeDistance/2;

holeX=0;
holeY=holeDistance/2;

module Reverbuilt()
{
difference() {
    cube([railX,railY,railZ],center=true);
    translate([holeX,holeY,0])cylinder(d=holeD,h=railZ+0.01,$fn=64,center=true);
    translate([guardholeX,guardholeY,0])cylinder(d=guardholeD,h=railZ+0.01,$fn=64,center=true);
}

//Frame
translate([railX/2+frameThickness/2,0,frameHeight/2])cube([frameThickness,railY,railZ+frameHeight],center=true);
translate([-railX/2-frameThickness/2,0,frameHeight/2])cube([frameThickness,railY,railZ+frameHeight],center=true);

}

Reverbuilt();