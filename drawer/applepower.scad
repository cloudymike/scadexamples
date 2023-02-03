use <interlockingmodule.scad>
use <applesocket.scad>

height=13;

BoxUnits=40;
BoxWidthUnits=3;
BoxLengthUnits=5;

interlockingbox(BoxWidthUnits,BoxLengthUnits,height);

difference() {
    union() {
    for (x=[BoxUnits/2:BoxUnits:BoxUnits*BoxLengthUnits])
        for (y=[BoxUnits/2:BoxUnits:BoxUnits*BoxWidthUnits])
            translate([x,y,height/2]) applesocket(BoxUnits,BoxUnits,height);
    }
    negativeBox(BoxWidthUnits,BoxLengthUnits,height,BoxUnits);
}