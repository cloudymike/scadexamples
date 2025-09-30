use <thickbaseplatemodule.scad>
use <../electrocookie/knurlpocket.scad>
include <../gridfinity-rebuilt-openscad/standard.scad>
module BackRight()
{
  difference () {

    rowX=4;
    rowY=4;
    sizeX=183.5;
    sizeY=191;  //rowY*42+24;
    

    deltaX=sizeX-rowX*42;
    deltaY=sizeY-rowY*42;
  
    myThickPlate(rowX,rowY,sizeX,sizeY);
    
    translate([-((rowX*42))/2-deltaX+5,-(rowY*42)/2-deltaY+11.2,-1.25]) m3knurl_pocket(11);
  
  }
}
difference()
{
  rotate([0,0,180])BackRight();
  //cube([168,240,50],center=true);
  //translate([0,0,4])cube([200,240,10],center=true);
}