use <baseplatemodule.scad>
use <../electrocookie/knurlpocket.scad>
include <../gridfinity-rebuilt-openscad/standard.scad>
module FrontLeft()
{
  difference () {
    sizeX=57.5;
    //sizeX=183.5;
    sizeY=185;
    
    rowX=1;
    //rowX=4;
    rowY=4;

    deltaX=sizeX-rowX*42;
    deltaY=sizeY-rowY*42;
  
    myBaseplate(rowX,rowY,sizeX,sizeY);    
    notchX=1;
    notchY=7;
    translate([-((rowX*42))/2-deltaX+5,-(rowY*42)/2-deltaY+6,-1.25]) m3knurl_pocket(11);  
  }
}
  
FrontLeft();