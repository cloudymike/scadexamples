use<interlockingmodule.scad>

// CGAL error, only in combination (union -> CGAL -> error)
//  - try newer version of (2021) of opensca
//  - Problem is in lenscap model, find another

$fn=64;
$fa=1;

height = 16.6;

difference() {
  interlockingbox(2,2,height,height);
  translate([41,41,1])cylinder(d=50,h=height);
}



translate([10,10,0]) 
import(
  "/home/mikael/3dprint/LensCaps/PK-mount_rear_lenscap.STL",
  convexity=3,
  $fa=1
);

bump_radius=2;
translate([6,56,height-bump_radius/3])
sphere(r=bump_radius);
