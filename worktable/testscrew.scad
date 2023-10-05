use <../threads/isothreads.scad>
use <phillips.scad>


$fa = 1;
$fs = 0.4;

//Fit the rod
holediameter=6.7;

//For enough strength, and also matching Cura wall
//Start with cura wall size
curawalltopbottom=0.8;
curainternalwall=0.4;
wallmin=curawalltopbottom+curainternalwall;

thread_size=1;
pitch = 4;
tileheight=16;

//Offset holes to match wallmin from top/bottom wall
holeoffset=tileheight/2-holediameter/2-wallmin;
  

module testcube() {
  //difference () {
  //  cube([tileheight,tileheight,tileheight], center = true);
  //  translate([0,0,holeoffset]) rotate([90,0,0]) cylinder(d=holediameter,h=tileheight,center=true);
  //  translate([0,0,-holeoffset]) rotate([90,0,90]) cylinder(d=holediameter,h=tileheight,center=true);
  //}
  
  difference () {
    cube([tileheight,tileheight,tileheight], center = true);
    translate([0,tileheight/2,holeoffset]) rotate([90,0,0]) metric_thread(diameter=holediameter+thread_size,pitch=pitch,length=tileheight*2,internal=true);
    translate([0,0,holeoffset]) rotate([90,0,0]) cylinder(d=holediameter,h=tileheight,center=true);
    translate([0,0,-holeoffset]) rotate([90,0,90]) cylinder(d=holediameter,h=tileheight,center=true);
  }
}

module screwrod () {
  difference () {
    metric_thread(diameter=holediameter+thread_size,thread_size=thread_size, pitch=4,length=tileheight/2,internal=false);
    translate([0,0,4.5]) phillipsDrive(2);
  }
}

screwrod();
//testcube();