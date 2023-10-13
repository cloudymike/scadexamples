
$fa = 1;
$fs = 0.4;

//Fit the rod
holediameter=6.7;

//For enough strength, and also matching Cura wall
//Start with cura wall size
curawalltopbottom=0.8;
curainternalwall=0.4;
wallmin=curawalltopbottom+curainternalwall;

tileheight=16;

//Offset holes to match wallmin from top/bottom wall
holeoffset=tileheight/2-holediameter/2-wallmin;

difference () {
  cube([tileheight,tileheight,tileheight], center = true);
  translate([0,0,holeoffset]) rotate([90,0,0]) cylinder(d=holediameter,h=tileheight,center=true);
  translate([0,0,-holeoffset]) rotate([90,0,90]) cylinder(d=holediameter,h=tileheight,center=true);
}