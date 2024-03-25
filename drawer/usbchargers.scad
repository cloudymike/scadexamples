use <interlockingmodule.scad>

height=20;
interval = 30;

BoxUnits=40;
BoxWidthUnits=3;
BoxLengthUnits=3;

WallAdjust = 1;

interlockingbox(BoxWidthUnits,BoxLengthUnits,height);

for (x=[interval/2+1*WallAdjust:interval-WallAdjust:BoxUnits*BoxWidthUnits])
    for (y=[interval/2+2*WallAdjust:interval-WallAdjust:BoxUnits*BoxWidthUnits])
        translate([x,y,height/2]) 
              acsocket(30,30,20);
         

module acsocket(x=38,y=38,z=16.5) {
  difference() {
    cube([x,y,z],center=true);
    acpin(x,y,z);
  }
}

module acpin(x=38,y=38,z=16.5) {
  overextrusion = 0.2;
  pin_thickness = 1.5 + 2 * overextrusion;
  pin_width = 6.5 + 2 * overextrusion;
  pin_length = 16.5;
  newZ=max(z,pin_length);
  translate([-6.5,0,newZ-pin_length])
    cube([pin_thickness,pin_width,pin_length],center=true);
  translate([6.5,0,newZ-pin_length])
    cube([pin_thickness,pin_width,pin_length],center=true);
}

