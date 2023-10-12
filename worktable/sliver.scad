// Create sliver of one side with the straight edge

use <basetile.scad>

$fn = 101;
height=16;

module sliver(side="north",west=true,height=16,width=10) {
  //straight edge
  translate([0,1.99*width-200,0])
  difference () {
    basetile(false,false,false,false,height);
    translate([0,0,0]) cube([200,200-width,height]);
  }
  
  //dovetail edge
  difference () {
    basetile(true,true,true,true,height);
    translate([-50,width,0]) cube([300,300,height]);
  }
  
}

sliver();