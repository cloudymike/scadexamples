// Creates slots across the length of the tiles
// Must be longer than 1 unit to be useful, assert statement will check this.
// Initially inteded to store some phones

use <interlockingmodule.scad>

$fn=120;

height=50;

BoxUnits=40;
BoxWidthUnits=1;
BoxLengthUnits=2;

assert(BoxLengthUnits>1,"Must be longer than one unit");

interlockingbox(BoxWidthUnits,BoxLengthUnits,height);

difference() {
    union() {
    for (row=[0:1:BoxLengthUnits-1])
        for (col=[0:1:BoxWidthUnits-1])
            tilePlacer(row,col,BoxUnits,height);
    } 
    negativeBox(BoxWidthUnits,BoxLengthUnits,height,BoxUnits);
}

module tilePlacer(row,col,BoxUnits,height) 
{
  x = BoxUnits/2+row*BoxUnits;
  y = BoxUnits/2+col*BoxUnits;
  left = row % 2;
  right = row +1 % 2;
  translate([x,y,height/2]) phonetile(BoxUnits,BoxUnits,height,left,right);
}

module phonetile(x=38,y=38,z=40,left,right) {
  newZ=max(z,20);
  ydlt = 10;
  difference() {
    cube([x,y,newZ],center=true);
    translate([-9,-ydlt,0])
      cylinder(r=8,h=newZ,center=true);
    translate([9,-ydlt,0])
      cylinder(r=8,h=newZ,center=true);
    translate([0,ydlt,0])
      cube([16,16,newZ],center=true);

    translate([-9,ydlt,0])
      cylinder(r=8,h=newZ,center=true);
    translate([9,ydlt,0])
      cylinder(r=8,h=newZ,center=true);
    translate([0,-ydlt,0])
      cube([16,16,newZ],center=true);
    if (left == 1)
    {
      translate([-12,ydlt,0])
      cube([16,16,newZ],center=true);
      translate([-12,-ydlt,0])
      cube([16,16,newZ],center=true);
    }
    if (right == 1)
    {
      translate([12,ydlt,0])
      cube([16,16,newZ],center=true);
      translate([12,-ydlt,0])
      cube([16,16,newZ],center=true);
    }
       

 }
}

