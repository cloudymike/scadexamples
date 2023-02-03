use <interlockingmodule.scad>

height=75;

BoxUnits=40;
BoxWidthUnits=1;
BoxLengthUnits=1;

interlockingbox(BoxWidthUnits,BoxLengthUnits,height);

difference() {
    union() {
    for (x=[BoxUnits/2:BoxUnits:BoxUnits*BoxLengthUnits])
        for (y=[BoxUnits/2:BoxUnits:BoxUnits*BoxWidthUnits])
            translate([x,y,height/2]) cabletile(BoxUnits,BoxUnits,height);
    }
    negativeBox(BoxWidthUnits,BoxLengthUnits,height,BoxUnits);
}



module cabletile(x=38,y=38,z=75) {
  newZ=max(z,20);
  difference() {
    cube([x,y,newZ],center=true);
    translate([-9,-9,0])
      cylinder(r=8,h=newZ,center=true);
    translate([9,-9,0])
      cylinder(r=8,h=newZ,center=true);
    translate([0,9,0])
      cube([16,16,newZ],center=true);

    translate([-9,9,0])
      cylinder(r=8,h=newZ,center=true);
    translate([9,9,0])
      cylinder(r=8,h=newZ,center=true);
    translate([0,-9,0])
      cube([16,16,newZ],center=true);

 }
}
