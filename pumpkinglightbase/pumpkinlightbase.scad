
// Requires support


//$fn = 80;
$fa = 1;
$fs = 0.4;

module lampholder() {
  difference () {
    cylinder(d=20,h=26,center=true);
    cylinder(d=16,h=26,center=true);
    cube([24,10,26],center=true);
  }
}

module lampbase() {
  difference () {
    cylinder(d=120,h=3,center=true);
    translate([54,0,0]) cube([12,5,3],center=true);
  }
  translate([0,0,6.5]) difference () {
    cylinder(d=100,h=10,center=true);
    cylinder(d=96,h=10,center=true);
    translate([48,0,0]) cube([10,5,10],center=true);
  }
}

module cablehook() {
  difference() {
    cube([5,15,11],center=true);
    translate([0,3,-2]) cube([5,9,5],center=true);
    }
}

union () {
lampbase();
translate([0,0,14.5]) lampholder();
translate([18,-2,6]) cablehook();
translate([38,-2,6]) cablehook(); 
}
