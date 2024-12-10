use <frontplate.scad>
use <mountplate.scad>

box_width=100;
box_height=40;
box_depth=mountplate_depth();
box_thickness=2;


difference()
{
    mountplate();
    cube([box_width,box_depth, 100],center=true);
}
translate([0,-mountplate_depth()/2+frontplate_thickness()/2,box_height/2-mountplate_thickness()/2])
    rotate([90,0,0])frontplate(box_height,box_width);

//side walls
translate([box_width/2,-box_depth/2,-mountplate_thickness()/2])
    cube([box_thickness,box_depth,box_height]);
translate([-box_width/2,-box_depth/2,-mountplate_thickness()/2])
    cube([box_thickness,box_depth,box_height]);

translate([0,0,box_height-box_thickness]) cube([box_width,box_depth,box_thickness],center=true);

