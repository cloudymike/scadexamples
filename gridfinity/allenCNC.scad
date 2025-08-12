// A simple tray for Allen keys
// by URSPB 2023-01
use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-bins.scad>

// the usage of the BOSL lib is necessary for cuboid 
include <BOSL2/std.scad>


$fn=64;

function hexTol(d_key) = max(0.5, d_key/4);

module hexKey(d_key, l1, l2, r_key, korr_Angle=0){
  // d_key: key diameter (face to face, not edge to edge)
  // l1: lengh of longer arm
  // l2: length of shorter arm
  // r_key: Angle radius of Allen key
  // korr_Angle: compensation if ankle angle is not 90° (default 0)
  d_key_tol = d_key + hexTol(d_key);
  translate([0,0,-d_key/2]){
    // Ankle
    rotate_extrude(angle=90+korr_Angle, convexity = 10)
     translate([r_key,0,0]) rotate([0,0,90]) 
     { circle(d=d_key_tol/cos(30), $fn=6); translate([0,-d_key_tol/2,0]) square([2*d_key_tol, d_key_tol]);}
    // long arm 
    translate([r_key,0,0]) rotate([90,0,0]) rotate([0,0,90]) linear_extrude(height=l1) 
      {circle(d=d_key_tol/cos(30), $fn=6);translate([0,-d_key_tol/2,0]) square([2*d_key_tol, d_key_tol]);}
    // short arm  
    rotate([0,0,korr_Angle]) translate([0,r_key,0]) rotate([0,-90,0])  linear_extrude(height=l2) 
      { circle(d=d_key_tol/cos(30), $fn=6); 
        translate([0,-d_key_tol/2,0]) square([2*d_key_tol, d_key_tol]);
      }
  }
}

// cylindrical structure for magnet
module magHole(d_key, r_key, d_mag=5, h_mag=1, d_magTol= 0.3){
  // d_key: key diameter (face to face, not edge to edge)
  // r_key: Angle radius of Allen key
  // d_mag: magnet diameter (default=5)
  // h_mag: magnet height (default=1)
  // d_magTol: tolerance for magnet diameter (default= 0.3)
  h_membrane = 0.1;
  d_push_hole = 2.5;
  d_magH = d_mag +d_magTol;
  d_key_tol = d_key + hexTol(d_key);
  translate([r_key,0,-d_key_tol-h_membrane])
  union(){
    cylinder(h=40,d=d_push_hole, center=true);
    translate([0,0,-h_mag*1.5]) cylinder(h=h_mag*1.5, d=d_magH);
    translate([0,0,+0]) cube([ d_magH*0.9,d_magH*0.4,0.56],center=true);
    translate([0,0,-h_mag*4.5]) cylinder(h=h_mag*3, d2=d_magH, d1=d_magH*1.3);
    translate([0,0,-h_mag*4.5-20]) cylinder(h=20, d=d_magH*1.3);
    }
}

module hexKeyMM(d_key, l1, l2, r_key, korr_Angle=0){
  hexKey(d_key, l1, l2, r_key, korr_Angle);
  //Skip the magholes for now
  //translate([0,-l1*.3,0]) magHole(d_key, r_key);
}  

module keyPart()
{
// Main part
// takes a cube and substracts the hex-keys with magnet holes from it
difference(){
//  translate([-2.5,0,-4]) cube([40,93,8],center=true);
  //translate([0,0,-4]) cube([42,126,8],center=true);
  translate([0,0,-14])gridfinityTray();

  
  translate([7,50,0]) hexKeyMM(3,95,22,5,0);
  translate([0,15,0]) hexKeyMM(2.5,57,19,4,0);

  translate([0,-40,0]) cuboid([38,30,15], rounding=5);  // cuboid can replaced by cube, if BOSL is not available
}
}

module gridfinityTray()
{
  
$fn=120;
OverExtrusion = 0.2;
theanswer=42;
Unit=theanswer;
height7=2;
heightmm = height7*7+9;
gridz=height7;
interval = 16.5;
diameter=14.2+2*OverExtrusion;

BoxUnits=42;
BoxLengthUnits=1;
BoxWidthUnits=3;
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
}


}

keyPart();
