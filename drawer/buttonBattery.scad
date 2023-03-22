use <interlockingmodule.scad>

// AA battery holder
// Tries to pack as many as possible based on tile size
// Does not try to make it symmetric

$fn=120;
OverExtrusion = 0.2;

height=8;
interval = 16.5;
diameter=14.2+2*OverExtrusion;

BoxUnits=40;
BoxWidthUnits=1;
BoxLengthUnits=1;

WallAdjust = 1;


difference () {
  interlockingbox(
    //Box Width in units
    BoxWidthUnits = BoxWidthUnits,
    //Box Length in units
    BoxLengthUnits = BoxLengthUnits,
    //Box Height in mm
    BoxHeight = height,
    //Box Floor Thickness in mm
    BoxFloor = height+0.01
);
  for (count = [0:4])
     buttoncell(count*7+6);

}
translate([16.5,3,height ]) linear_extrude(1) text("357",size=3,font="Liberation Sans:style=Bold");


module buttoncell(y=0)
{
  translate([10,y,7]) rotate([90,0,0]) cylinder(d=12,h=5.8,center=true);
  translate([10,y,7]) rotate([90,0,0]) cube([12,2,5.8],center=true);
  translate([30,y,7]) rotate([90,0,0]) cylinder(d=12,h=5.8,center=true);
  translate([30,y,7]) rotate([90,0,0]) cube([12,2,5.8],center=true);
}