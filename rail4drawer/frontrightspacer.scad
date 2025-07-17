
railX=35;
railY=40;
railZ=8;
holeD=4.8;
holeX=railX/2-3.7;
hole1Y=-railY/2+4.8;
hole2Y=-railY/2+(4.5+7.5);
frameThickness=1;

module frontrightspacer()
{
difference() {
    cube([railX,railY,railZ],center=true);
    translate([holeX,hole1Y,0])cylinder(d=holeD,h=railZ,$fn=64,center=true);
    translate([holeX,hole2Y,0])cylinder(d=holeD,h=railZ,$fn=64,center=true);
}

//Frame
translate([railX/2+frameThickness/2,0,frameThickness/2])cube([frameThickness,railY,railZ+frameThickness],center=true);
translate([-railX/2-frameThickness/2,0,frameThickness/2])cube([frameThickness,railY,railZ+frameThickness],center=true);

}

frontrightspacer();