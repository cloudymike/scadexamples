use <interlockingmodule.scad>

// AA battery holder
// Tries to pack as many as possible based on tile size
// Does not try to make it symmetric

$fn=120;
OverExtrusion = 0.2;

height=14;
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
  for (count = [0:6])
     CR2032cell(count*5+5,count);

}
translate([1,3,height ]) linear_extrude(1) text("CR2032",size=3,font="Liberation Sans:style=Bold");


module CR2032cell(y=0,count=0) {
  x = (count % 2 == 1 ) ? 12:28;
  translate([x,y,11]) rotate([90,0,0]) cylinder(d=20.4,h=3.65,center=true);
  translate([x,y,13]) rotate([90,0,0]) cube([20.4,4,3.65],center=true);
}