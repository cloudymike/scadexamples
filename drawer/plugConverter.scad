use <interlockingmodule.scad>

$fn=360;

height=5;

BoxUnits=40;
BoxWidthUnits=1;
BoxLengthUnits=1;

interlockingbox(BoxWidthUnits,BoxLengthUnits,height,height+0.01);

difference() {
    union() {
    for (x=[BoxUnits/2:BoxUnits:BoxUnits*BoxLengthUnits])
        for (y=[BoxUnits/2:BoxUnits:BoxUnits*BoxWidthUnits])
            translate([x,y,height/2]) acplug(BoxUnits,BoxUnits,height);
    }
}

module acplug(x=38,y=38,z=5) {
  overextrusion = 0.2;
  pin_thickness = 1.5 - 2 * overextrusion;
  pin_width = 6.5 - 2 * overextrusion;
  pin_length = 16.5;
  translate([6.5,0,z/2+pin_length/2])
    cube([pin_thickness,pin_width,pin_length],center=true);
  translate([-6.5,0,z/2+pin_length/2])
    cube([pin_thickness,pin_width,pin_length],center=true);
}

