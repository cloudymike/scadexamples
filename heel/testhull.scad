$fn=64;

hull() {
    translate([10,0,-2.6]) cylinder(d=28,h=0.01,center=true);
    translate([10,0,2.6]) cylinder(d=20,h=0.01,center=true);
    translate([0,0,-2.6]) cube([10,28,0.01],center=true);
    translate([0,0,2.6]) cube([10,20,0.01],center=true);
}
