use<interlockingmodule.scad>

// CGAL error, only in combination (union -> CGAL -> error)
//  - try newer version of (2021) of opensca
//  - Problem is in lenscap model, find another


difference() {
  interlockingbox(2,2,12.5,12.5);
  translate([40,40,1])cylinder(d=50,h=12);
}



translate([8,8,0]) 
import(
  "/home/mikael/3dprint/LensCaps/Pentax_Rear_Lens_Cap_v1-2.STL",
  convexity=3
);

