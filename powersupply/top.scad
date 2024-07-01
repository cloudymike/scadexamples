include <../gridfinity-rebuilt-openscad/standard.scad>

use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>
use <../usbc2power/usbcslot.scad>


plateThickness=2;
printmargin=0.2;

module topPlate()
{
  //translate([0,0,plateThickness/2])cube([83,83,plateThickness],center=true);
  rounded_rectangle(l_grid*2, l_grid*2, plateThickness, 4);
}


difference ()
{
  topPlate();
  translate([0,15,plateThickness/2])cube([76,39,plateThickness+printmargin],center=true);
  translate([-25,-25,plateThickness/2]) cube([boardBoxX(),boardBoxZ(),plateThickness],center=true); // USB connector
}

translate([-25,-25-boardBoxZ()/2,-boardBoxY()/2+plateThickness-0.5])rotate([-90,0,0]) boardBox();