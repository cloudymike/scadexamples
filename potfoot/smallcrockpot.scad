
$fa = 1;
$fs = 0.1;
rotate([0,90,0]) {
  difference() {
    cylinder(h=20,d1=22,d2=18);
    translate([0,-12,-0.01])
      cube([24,24,24],center=false);
    translate([0,0,-0.01])
      cylinder(h=4.4,d=5);
    translate([0,0,3.5])
      cylinder(h=2.5,d=7.5);
  }
}
