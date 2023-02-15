use <interlockingmodule.scad>

// AAA battery holder
// Tries to pack as many as possible based on tile size
// Does not try to make it symmetric

$fn=120;
OverExtrusion = 0.2;

height=20;
interval = 12.5;
diameter=10.2+2*OverExtrusion;

BoxUnits=40;
BoxWidthUnits=3;
BoxLengthUnits=3;

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

for (x=[interval/2:interval:BoxUnits*BoxLengthUnits-diameter/2-WallAdjust])
    for (y=[interval/2+2*WallAdjust:interval:BoxUnits*BoxWidthUnits-diameter/2])
        translate([x,y,height/2+2]) cylinder(d=diameter,h=height+2,center=true);
}
