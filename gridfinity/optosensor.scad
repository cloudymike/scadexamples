use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-bins.scad>
use <../drawer/usbchargers.scad>


// AA battery holder
// Tries to pack as many as possible based on tile size
// Does not try to make it symmetric


$fa = 1;
$fs = 0.4;


boxdepth = 10;
boxwidth = 22.5;
wallthickness = 1;
ringheight = 6;
braceoffset = 16;
tubediameter = 11;

module lid() {
  difference () {
    cube([boxwidth-2*wallthickness,boxdepth-1*wallthickness,2],center=true);
    translate([0,boxdepth/2-3.5,1]) cube([20.5,1.5,1],center=true); // slot
    translate([0,-boxdepth/2,0]) cube([boxwidth-2*wallthickness,7*wallthickness,2],center=true); //space for bow
  }
}

module topbox(
  boxwidth=boxwidth,
  boxdepth=boxdepth,
  wallthickness=wallthickness,
  tbheight = 17
  ) {
  difference () {
    cube([boxwidth,boxdepth,tbheight],center=true);
    translate([0,-1,6]) cube([boxwidth-2*wallthickness,boxdepth,10],center=true);
    cube([boxwidth-2*wallthickness,boxdepth-2*wallthickness,tbheight],center=true);
  }  
}
module cardslot (boxwidth=boxwidth,boxdepth=boxdepth,wallthickness=wallthickness, csheight=8) {
  difference () {
    cube([boxwidth,boxdepth,csheight],center=true);
    translate([0,boxdepth/2-3.5,0]) cube([boxwidth-2*wallthickness,1.5,csheight],center=true);
    cube([10,boxdepth-2*wallthickness,csheight],center=true);
  }  
}  

module compressionring(ringheight=ringheight,tubediam=11,ringwall=2) {
  difference() {
    cylinder(h=ringheight,d=tubediam+2*ringwall,center=true);
    cylinder(h=ringheight,d=tubediam,center=true);
    translate([0,-ringheight,0]) cube([1,3,ringheight],center=true);
    
  }
}


module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [-w,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [-w,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

module bottombox(
  boxwidth=boxwidth,
  boxdepth=boxdepth,
  wallthickness=wallthickness,
  ringheight = ringheight, 
  braceoffset=braceoffset, 
  tubediam=tubediameter, 
  ringwall=2, 
  bboxh=13
  ) {
  
  difference () {
    cube([boxwidth,boxdepth,bboxh],center=true);
    cube([boxwidth-2*wallthickness,boxdepth-2*wallthickness,13],center=true);
    //Create a notch for the cable connector
    translate([0,-boxdepth/2+wallthickness,0]) cube([10,wallthickness,bboxh],center=true);
  }
  }

module sensorbox(
  boxwidth = boxwidth,
  boxdepth = boxdepth,
  wallthickness = wallthickness,
  ringheight = ringheight, 
  braceoffset=braceoffset, 
  tubediam=tubediameter, 
  ringwall=2
  ) {
    bboxh=13;
    csheight=8;
    tbheight = 18;
    bottombox(boxwidth,boxdepth,wallthickness,ringheight, braceoffset, tubediam, ringwall, bboxh);
    translate([0,0,bboxh/2+csheight/2]) cardslot(boxwidth,boxdepth,wallthickness,csheight);
    translate([0,0,bboxh/2+csheight+tbheight/2]) topbox(boxwidth,boxdepth,wallthickness,tbheight);
}


SlotWidth=18;
SlotLength=34;

$fn=120;
OverExtrusion = 0.2;
theanswer=42;
Unit=theanswer;
height7=0;
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


//bottombox();
//topbox();  
//cardslot(); 

translate([3,14,13]) sensorbox();
translate([-3,-14,13]) rotate([0,0,180]) sensorbox();
//translate ([40,0,0])  lid();

