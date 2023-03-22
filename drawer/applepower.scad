use <interlockingmodule.scad>

$fn=360;

height=13;

BoxUnits=40;
BoxWidthUnits=3;
BoxLengthUnits=3;

interlockingbox(BoxWidthUnits,BoxLengthUnits,height);

difference() {
    union() {
    for (x=[BoxUnits/2:BoxUnits:BoxUnits*BoxLengthUnits])
        for (y=[BoxUnits/2:BoxUnits:BoxUnits*BoxWidthUnits])
            translate([x,y,height/2]) applesocket(BoxUnits,BoxUnits,height);
    }
    negativeBox(BoxWidthUnits,BoxLengthUnits,height,BoxUnits);
}

module applesocket(x=38,y=38,z=11) {
  newZ=max(z,11);
  difference() {
    cube([x,y,newZ],center=true);
    difference() {
      union() {
        translate([-4.5,0,0])cylinder(r=4,h=newZ,center=true);
        translate([4.5,0,0])cylinder(r=4,h=newZ,center=true);
        cube([9,8,newZ],center=true);
      }
      translate([0,4,0])cylinder(r=1.63,h=newZ,center=true);
      translate([0,-4,0])cylinder(r=1.63,h=newZ,center=true);
    }
  }
}
