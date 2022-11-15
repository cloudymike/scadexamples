use <../canning_lid/canning_jar_lids.scad>

$fa = 1;
$fs = 0.4;

hole_offset = 20;
difference() {
    union () {
        sealed_lid("wide");
        translate([hole_offset,0,0]) cylinder(d=14,h=150);
    }
    translate([hole_offset,0,-0.1]) cylinder(d=10,h=900);
    translate([-hole_offset,0,-0.1]) cylinder(d=13.5,h=900);
    translate([-hole_offset,0,2.5]) cylinder(d=22,h=900);
}
