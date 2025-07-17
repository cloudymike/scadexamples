
railX=37.0;
railY=40;
railZ=8;
holeD=4.8;
holeX=railX/2-6.8;
hole1Y=-railY/2+5;
hole2Y=-railY/2+12.5;
frameThickness=1;

guardholeD=6.3;
guardholeX=railX/2-(16.8+guardholeD/2);
guardholeY=-railY/2+(32.2+guardholeD/2);

module FReverbuilt()
{
difference() {
    cube([railX,railY,railZ],center=true);
    translate([holeX,hole1Y,0])cylinder(d=holeD,h=railZ+0.01,$fn=64,center=true);
    translate([holeX,hole2Y,0])cylinder(d=holeD,h=railZ+0.01,$fn=64,center=true);
    translate([guardholeX,guardholeY,0])cylinder(d=guardholeD,h=railZ+0.01,$fn=64,center=true);
}

//Frame
translate([railX/2+frameThickness/2,0,frameThickness/2])cube([frameThickness,railY,railZ+frameThickness],center=true);
translate([-railX/2-frameThickness/2,0,frameThickness/2])cube([frameThickness,railY,railZ+frameThickness],center=true);

}

FReverbuilt();