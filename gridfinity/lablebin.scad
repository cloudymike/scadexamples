use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-bins.scad>
use <screwtest.scad>
use <../Write/Write.scad>

// M screw holder
// Tries to pack as many as possible based on tile size
// Does not try to make it symmetric


module labelbin(  label="", 
  label2="",
  BoxLengthUnits=1,
  BoxWidthUnits=1,
  divx=1 )
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
  //divx = 1;
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
  //BoxWidthUnits=1;
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
    translate([-17-(BoxLengthUnits-1)*21,17-textsize+(BoxWidthUnits-1)*theanswer/2,height])write(str(label), h=labelHeight, t=labelThickness, font=labelFont, center=false, bold=0, space=1.1);
    translate([-17-(BoxLengthUnits-1)*21,11-textsize+(BoxWidthUnits-1)*theanswer/2,height])write(str(label2), h=labelHeight, t=labelThickness, font=labelFont, center=false, bold=0, space=1.1);
  }
  else
    translate([-17-(BoxLengthUnits-1)*21,15-textsize+(BoxWidthUnits-1)*theanswer/2,height])write(str(label), h=labelHeight, t=labelThickness, font=labelFont, center=false, bold=0, space=1.1);
    
}

labelbin("1N4004",label2="", BoxWidthUnits=2, divx=1);
