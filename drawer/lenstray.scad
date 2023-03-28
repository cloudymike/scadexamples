use<interlockingmodule.scad>

// CGAL error, only in combination (union -> CGAL -> error)
//  - try newer version of (2021) of opensca
//  - Problem is in lenscap model, find another

difference() {
  interlockingbox(2,2,12.5,12.5);
  translate([40,40,1])cylinder(d=50,h=12);
}



translate([40,40,11.1]) 
import(
  "/home/mikael/3dprint/LensCaps/Pentax_K_Rear_Cap.stl",
  convexity=3,
  $fn=120
);

