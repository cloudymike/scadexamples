use <thickbaseplatemodule.scad>
use <../electrocookie/knurlpocket.scad>
include <../gridfinity-rebuilt-openscad/standard.scad>
module BackRight()
{
  difference () {

    rowX=4;
    rowY=4;
    sizeX=0;
    sizeY=191;  //rowY*42+24;
    
    myThickPlate(rowX,rowY,sizeX,sizeY);
      
  }
}
difference()
{
  rotate([0,0,180])BackRight();
  //cube([168,240,50],center=true);
  //translate([0,0,4])cube([200,240,10],center=true);
}