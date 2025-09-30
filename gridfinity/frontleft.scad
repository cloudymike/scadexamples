//use <baseplatemodule.scad>
use <thickbaseplatemodule.scad>
use <../electrocookie/knurlpocket.scad>
include <../gridfinity-rebuilt-openscad/standard.scad>
module FrontLeft()
{
  difference () {
    sizeX=183.5;
    sizeY=136;
    
    rowX=4;
    rowY=3;

    deltaX=sizeX-rowX*42;
    deltaY=sizeY-rowY*42;
  
    myThickPlate(rowX,rowY,sizeX,sizeY);
    
    notchX=1;
    notchY=7;
    translate([-((rowX*42))/2-deltaX,-(rowY*42)/2-deltaY/2,0])cube([notchX,notchY,20],center=true);
    translate([-((rowX*42))/2-deltaX+5,-(rowY*42)/2-deltaY+70,-1.25]) m3knurl_pocket(11);
    translate([-((rowX*42))/2-deltaX+5,-(rowY*42)/2-deltaY+14,-1.25]) m3knurl_pocket(11);
  
  }
}
  
FrontLeft();