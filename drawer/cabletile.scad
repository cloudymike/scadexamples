use <interlockingmodule.scad>
use <cable.scad>

height=20;

BoxUnits=40;
BoxWidthUnits=3;
BoxLengthUnits=3;

interlockingbox(BoxWidthUnits,BoxLengthUnits,height);

for (x=[interval/2+1*WallAdjust:interval-WallAdjust:BoxUnits*BoxWidthUnits])
    for (y=[interval/2+2*WallAdjust:interval-WallAdjust:BoxUnits*BoxWidthUnits])
        translate([x,y,height/2]) cable(BoxUnits,BoxUnits,height);


