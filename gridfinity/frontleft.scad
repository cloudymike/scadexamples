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
  
    union() {
      //myBaseplate(4,3,sizeX,sizeY);
      myThickPlate(4,3,sizeX,sizeY);
      //translate([-rowX*42/2-deltaX,-(3*42)/2-deltaY-0.3,-11/2-1.25])cube([sizeX,3,11.15]);
    }
    notchX=1;
    notchY=7;
    translate([-((4*42))/2-deltaX,-(3*42)/2-deltaY/2,0])cube([notchX,notchY,20],center=true);
    translate([-((4*42))/2-deltaX+5,-(3*42)/2-deltaY+70,-1.25]) m3knurl_pocket(11);
    translate([-((4*42))/2-deltaX+5,-(3*42)/2-deltaY+14,-1.25]) m3knurl_pocket(11);
  
  }
}
  
FrontLeft();