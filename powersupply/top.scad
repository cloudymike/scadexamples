include <../gridfinity-rebuilt-openscad/standard.scad>

use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>
use <../usbc2power/usbcslot.scad>

$fn=64;

plateThickness=2;
printmargin=0.2;

screwradius = 1.75;

contactdiameter=5+2*printmargin;
contactdistance=18.8;

module topPlate()
{
  //translate([0,0,plateThickness/2])cube([83,83,plateThickness],center=true);
  rounded_rectangle(l_grid*2-0.6, l_grid*2-0.6, plateThickness, 4);
}

module contactholes()
{
  translate([-contactdistance/2,0,plateThickness/2])cylinder(d=contactdiameter,h=plateThickness,center=true);
  translate([contactdistance/2,0,plateThickness/2])cylinder(d=contactdiameter,h=plateThickness,center=true);
}


difference ()
{
  topPlate();
  
  //controller hole
  translate([0,10,plateThickness/2])cube([75.5,39.5,plateThickness+printmargin],center=true);
  
  //contact holes
  translate([20,-23,0])contactholes();
  
  //slot for USB connector module
  translate([-25,-22,plateThickness/2]) cube([boardBoxX(),boardBoxZ(),plateThickness],center=true); 

  // screw holes
  translate([-36,-36,plateThickness/2])cylinder(r=screwradius,h=plateThickness,center=true);
  translate([36,-36,plateThickness/2])cylinder(r=screwradius,h=plateThickness,center=true);
  translate([-36,36,plateThickness/2])cylinder(r=screwradius,h=plateThickness,center=true);
  translate([36,36,plateThickness/2])cylinder(r=screwradius,h=plateThickness,center=true);

}

// USBC board holder
translate([-25,-22-boardBoxZ()/2,-boardBoxY()/2+plateThickness-0.5])rotate([-90,0,0]) boardBox("");