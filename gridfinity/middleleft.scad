use <thickbaseplatemodule.scad>
use <../electrocookie/knurlpocket.scad>
include <../gridfinity-rebuilt-openscad/standard.scad>
module MiddleLeft()
{
  difference () {

    rowX=4;
    rowY=4;
    sizeX=183.5;
    sizeY=rowY*42;
    

    deltaX=sizeX-rowX*42;
    deltaY=sizeY-rowY*42;
  
    myThickPlate(rowX,rowY,sizeX,0);
    
    translate([-((rowX*42))/2-deltaX+5,-(rowY*42)/2-deltaY+139.73,-1.25]) m3knurl_pocket(11);
  
  }
}
difference()
{
MiddleLeft();
  //cube([168,168,50],center=true);
  //translate([0,0,4])cube([200,200,10],center=true);
}