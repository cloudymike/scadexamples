use <baseplatemodule.scad>
use <../electrocookie/knurlpocket.scad>
include <../gridfinity-rebuilt-openscad/standard.scad>
module BackMiddle()
{

  sizeX=0;
  sizeY=185;
  rowX=4;
  rowY=4;

  difference () {
    myBaseplate(rowX,rowY,sizeX,sizeY);    
    }
}
  
BackMiddle();