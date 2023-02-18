use <interlockingmodule.scad>

// spacer to fill out drawer

$fn=120;
OverExtrusion = 0.2;

height=2;
interval = 12.5;
diameter=10.2+2*OverExtrusion;

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

}
