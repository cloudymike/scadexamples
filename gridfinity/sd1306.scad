use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-bins.scad>
use <../drawer/usbchargers.scad>


// sd1306 holder
// assymetric to pack closer

theanswer=42;
Unit=theanswer;
height7=4;
heightmm = height7*7+9;

module gridfinityBlock(
  BoxLengthUnits=1,
  BoxWidthUnits=1
)
{
  $fn=120;
  OverExtrusion = 0.2;
  gridz=height7;
  interval = 16.5;
  diameter=14.2+2*OverExtrusion;
  
  BoxUnits=42;
  StyleHole=4; // [0:no holes, 1:magnet holes only, 2: magnet and screw holes - no printable slit, 3: magnet and screw holes - printable slit, 4: Gridfinity Refined hole - no glue needed]
  gridz_define = 0; // [0:gridz is the height of bins in units of 7mm increments - Zack's method,1:gridz is the internal height in millimeters, 2:gridz is the overall external height of the bin in millimeters]
  height_internal = 0;
  // snap gridz height to nearest 7mm increment
  enable_zsnap = false;
  
  /* [Features] */
  // the type of tabs
  style_tab = 5; //[0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]
  // how should the top lip act
  style_lip = 1; //[0: Regular lip, 1:remove lip subtractively, 2: remove lip and retain height]
  // scoop weight percentage. 0 disables scoop, 1 is regular scoop. Any real number will scale the scoop.
  scoop = 1; //[0:0.1:1]
  // only cut magnet/screw holes at the corners of the bin to save uneccesary print time
  WallAdjust = 2;
    union () {
      gridfinityInit(BoxLengthUnits, BoxWidthUnits, height(gridz), 0, Unit,sl=style_lip) {}
       gridfinityBase(
        gx=BoxLengthUnits, 
        gy=BoxWidthUnits, 
        l=theanswer, 
        dx=0, 
        dy=0, 
        style_hole=4 
      );    
    }
}

module sd1306()
{
  cube([28,6,26],center=true);
  translate([0,7,0])cube([10,8,26],center=true);
}

module sd1306Block(
  BoxLengthUnits=1,
  BoxWidthUnits=1
)
{
  difference() {
    gridfinityBlock(BoxLengthUnits,BoxWidthUnits);
    translate([4,-15,13+6]) sd1306();
    //translate([-6,-1,13+6]) rotate([0,0,180]) sd1306();
    translate([-15,-4,13+6]) rotate([0,0,-90]) sd1306();
    translate([15,4,13+6]) rotate([0,0,90]) sd1306();
    translate([-4,15,13+6]) rotate([0,0,180])sd1306();
  }
}


sd1306Block();
//translate([0,25,13+6])sd1306();
