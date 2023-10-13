use <../scad-utils/morphology.scad>
use <ball_joint.scad>
use <basetile.scad>

$fn = 101;
sides = 4;
lower_radius = 90;
upper_radius = 85;
ball_radius = 5.5;  //base of ball
height=16;


module ballplacements(sides, lower_radius, upper_radius, ball_radius) {
    theta = 360/sides;
    fn = $fn;
    rise = lower_radius-upper_radius;
    for (i=[0:theta:360-theta]) {
        rotate([0, 0, i]) translate([upper_radius - ball_radius, 0, 0]) socket();
    }
}

basetile(true,true,false,true,height);
translate([100,100,height-1]) rotate([0,0,45]) ballplacements(sides,lower_radius,upper_radius,ball_radius);