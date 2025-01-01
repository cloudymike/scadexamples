use <dimlines.scad>
DIM_LINE_WIDTH=10;
myl=3;
translate([0,4,0])dimensions(length=myl,mytext=str(myl));
translate([5,5,0])line(length=12, left_arrow=false, right_arrow=false);


cube([myl,myl,myl]);

