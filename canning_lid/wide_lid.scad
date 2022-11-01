use <canning_jar_lids.scad>

top_thickness = 1;
//Global rendering vars
$fa = 1;
$fs = 0.4;

difference () {
union () {
    canning_jar_lid("wide");
    cylinder(r=45,h=3.5+top_thickness);
}

    translate([0,0,top_thickness+0.01]) difference () {
        cylinder(r=43,h=3.5);
        cylinder(r=34.5,h=3.6);
        
    }
}