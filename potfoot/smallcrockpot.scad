
$fa = 1;
$fs = 0.1;
rotate([0,90,0]) {
  difference() {
    cylinder(h=20,d1=22,d2=18);
    translate([0,-12,-0.01])
      cube([24,24,24],center=false);
    cylinder(h=4.4,d=4.6);
    translate([0,0,3.8])
      cylinder(h=2,d=7);
  }
}
