use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-bins.scad>
use <screwtest.scad>
use <../Write/Write.scad>

// M screw holder
// Tries to pack as many as possible based on tile size
// Does not try to make it symmetric


module labelbin(  label="", 
  label2="",
  size=1 )
{
  textsize = 5; //Smaller requires high res printing
  $fn=120;
  OverExtrusion = 0.2;
  theanswer=42;
  height7=5;
  height = height7*7;
  interval = 16.5;
  diameter=14.2+2*OverExtrusion;
  
  /* [Linear Compartments] */
  // number of X Divisions (set to zero to have solid bin)
  divx = 1;
  // number of Y Divisions (set to zero to have solid bin)
  divy = 1;
  
  /* [Features] */
  // the type of tabs
  style_tab = 0; //[0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]
  // how should the top lip act
  style_lip = 0; //[0: Regular lip, 1:remove lip subtractively, 2: remove lip and retain height]
  // scoop weight percentage. 0 disables scoop, 1 is regular scoop. Any real number will scale the scoop.
  scoop = 1; //[0:0.1:1]
  
  BoxUnits=42;
  BoxLengthUnits=size;
  BoxWidthUnits=1;
  StyleHole=4; // [0:no holes, 1:magnet holes only, 2: magnet and screw holes - no printable slit, 3: magnet and screw holes - printable slit, 4: Gridfinity Refined hole - no glue needed]
  WallAdjust = 2;
  union () {
    gridfinityInit(BoxLengthUnits, BoxWidthUnits, height(height7), 0, theanswer) {
      cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop);
    }
    gridfinityBase(
      gx=BoxLengthUnits, 
      gy=BoxWidthUnits, 
      l=theanswer, 
      dx=0, 
      dy=0, 
      style_hole=StyleHole 
    );
  }
  
  
  labelHeight=textsize;
  labelThickness=2;
  labelFont="Letters.dxf";
  if (label2!="") 
  {
    translate([-17,17-textsize,height])write(str(label), h=labelHeight, t=labelThickness, font=labelFont, center=false, bold=0, space=1.1);
    translate([-17,11-textsize,height])write(str(label2), h=labelHeight, t=labelThickness, font=labelFont, center=false, bold=0, space=1.1);
  }
  else
    translate([-17,15-textsize,height])write(str(label), h=labelHeight, t=labelThickness, font=labelFont, center=false, bold=0, space=1.1);
    
}


module labletest(
  label="", 
  label2="",
  size=1
)
{
  textsize = 5; //Smaller requires high res printing
  height=1;
  cube([38,13,height]);
  labelHeight=textsize;
  labelThickness=2;
  labelFont="Letters.dxf";
  if (label2!="") 
  {
    translate([textsize/2,6-textsize,height])write(str(label2), h=labelHeight, t=labelThickness, font=labelFont, center=false, bold=0, space=1.1);
    translate([textsize/2,12-textsize,height])write(str(label), h=labelHeight, t=labelThickness, font=labelFont, center=false, bold=0, space=1.1);
  }
  else
        translate([textsize/2,10-textsize,height])write(str(label), h=labelHeight, t=labelThickness, font=labelFont, center=false, bold=0, space=1.1);

}
labelbin("M3x50mm",label2="",size=2);

//labletest("M3 spring",label2="washer",size=1);
