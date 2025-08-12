include <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>
include <../gridfinity-rebuilt-openscad/standard.scad>

depth=8;
difference()
{
  union()
  {
    translate([(2+depth)/2,0,0]) cube([2,10,4.2],center=true);
    translate([(9+depth)/2,0,0]) cube([9,2,4.2],center=true);
    cube([depth, 5.3,l_grid/10], center = true);
  }
  translate([0,0,2])cylinder(h=4.2, d=6.6, center = true, $fn=6);
}