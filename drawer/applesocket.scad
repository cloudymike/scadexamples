
$fn=360;

module applesocket(x=38,y=38,z=11) {
  newZ=max(z,11);
  difference() {
    cube([x,y,newZ],center=true);
    difference() {
      union() {
        translate([-4.5,0,0])cylinder(r=4,h=newZ,center=true);
        translate([4.5,0,0])cylinder(r=4,h=newZ,center=true);
        cube([9,8,newZ],center=true);
      }
      translate([0,4,0])cylinder(r=1.63,h=newZ,center=true);
      translate([0,-4,0])cylinder(r=1.63,h=newZ,center=true);
    }
  }
}

applesocket(40,40,12);