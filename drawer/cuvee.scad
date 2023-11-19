use <interlockingmodule.scad>

$fn=120;

height=15;

BoxUnits=40;
BoxWidthUnits=1;
BoxLengthUnits=1;

interlockingbox(BoxWidthUnits,BoxLengthUnits,height);

difference() {
    union() {
    for (x=[BoxUnits/2:BoxUnits:BoxUnits*BoxLengthUnits])
        for (y=[BoxUnits/2:BoxUnits:BoxUnits*BoxWidthUnits])
            translate([x,y,height/2]) cuveetile(BoxUnits,BoxUnits,height);
    }
    negativeBox(BoxWidthUnits,BoxLengthUnits,height,BoxUnits);
}



module cuveetile(x=38,y=38,z=75) {
  newZ=max(z,10);
  difference() {
    cube([x,y,newZ],center=true);
    translate([10,10,0])
     cube([12.5,12.5,newZ],center=true);
    translate([-10,-10,0])
      cube([12.5,12.5,newZ],center=true);
    translate([10,-10,0])
     cube([12.5,12.5,newZ],center=true);
    translate([-10,10,0])
      cube([12.5,12.5,newZ],center=true);

 }
}
