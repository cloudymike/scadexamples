use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-bins.scad>
use <../drawer/usbchargers.scad>
use <../Write/Write.scad>


// AA battery holder
// Tries to pack as many as possible based on tile size
// Does not try to make it symmetric

SlotWidth=13;
SlotLength=13;

$fn=120;
OverExtrusion = 0.2;
theanswer=42;
Unit=theanswer;
height7=4;
heightmm = height7*7+9;
gridz=height7;
interval = 16.5;
diameter=14.2+2*OverExtrusion;

BoxUnits=42;
BoxLengthUnits=1;
BoxWidthUnits=1;
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
difference() {
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
  translate([-SlotLength/2-2,-SlotWidth+2,heightmm/2+5])
    cube([SlotLength+2*OverExtrusion,SlotWidth+2*OverExtrusion,heightmm],center=true);
  translate([SlotLength/2+2,-SlotWidth+2,heightmm/2+5])
    cube([SlotLength+2*OverExtrusion,SlotWidth+2*OverExtrusion,heightmm],center=true);

  translate([-SlotLength/2-2,SlotWidth-2,heightmm/2+5])
    cube([SlotLength+2*OverExtrusion,SlotWidth+2*OverExtrusion,heightmm],center=true);
  translate([SlotLength/2+2,SlotWidth-2,heightmm/2+5])
    cube([SlotLength+2*OverExtrusion,SlotWidth+2*OverExtrusion,heightmm],center=true);


}

  labelString=str("CNC bits");
  labelHeight=6;
  labelThickness=2;
  labelFont="Letters.dxf";
  translate([0,0,heightmm-9])write(labelString, h=labelHeight, t=labelThickness, font=labelFont, center=true, bold=0, space=1.1);

