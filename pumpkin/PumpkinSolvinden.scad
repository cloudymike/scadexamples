use <Pumpkin-DDmodule.scad>
use <../solvinden/ring.scad>


$fa = 1;
$fs = 0.4;


module spacerring(outsidediameter=87, height=2) {
  difference() {
    cylinder(d=outsidediameter,h=height,center=true);
    cylinder(d=87,h=height,center=true);
  }
}

difference() {
  translate([0,0,68]) scale([2,2,2]) pumpkinBottom();
  cylinder(h=30,d=87,center=true);
  //translate([0,0,107]) cylinder(h=200, d=300, center=true); // testcut
}

translate([0,0,1]) ringattachment(outsidediameter=100);
spacerHeight=4;
translate([0,0,spacerHeight/2]) spacerring(outsidediameter=110, height=spacerHeight);

