

linear_extrude(height = 20, center = false, convexity = 10, twist = 360, $fn = 100)
translate([4, 0, 0])
//sphere(r=2);
circle(r = 2);


$fn=64;
difference() {
    cylinder(r=8,h=2,center=true);
    cylinder(r=2.2,h=2.2,center=true);
    translate([-5,0,0]) cube([8,4,2.2],center=true);
}

translate([4,0,20]) sphere(r=2);