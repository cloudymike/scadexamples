use <screwhang.scad>

thickness=1;

module right_angle_prism(l, w, h) {
    linear_extrude(height = h) {
        polygon(points=[[0,0],[l,0],[0,w]], paths=[[0,1,2]]);
    }
}

module back()
{
    translate([0,0,60])cube([thickness,30,120],center=true);
}

module foot()
{
    cube([180,30,thickness],center=true);    
}

back();
foot();
translate([-12+3-thickness,0,110])rotate([0,90,0])screwhang();
rotate([90,0,0])right_angle_prism(90,120,thickness);
