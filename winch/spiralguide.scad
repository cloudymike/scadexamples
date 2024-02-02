

linear_extrude(height = 20, center = false, convexity = 10, twist = 1440, $fn = 100)
translate([3, 0, 0])
//sphere(r=2);
circle(r = 2);


$fn=64;
difference() {
    cylinder(r=8,h=2,center=true);
    cylinder(r=0.5,h=2.2,center=true);
    translate([-5,0,0]) cube([10,1,2.2],center=true);
}

translate([3,0,20]) sphere(r=2);