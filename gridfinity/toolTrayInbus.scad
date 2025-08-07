// A simple tray for Allen keys
// by URSPB 2023-01

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
  translate([0,-l1*.3,0]) magHole(d_key, r_key);
}  

// Main part
// takes a cube and substracts the hex-keys with magnet holes from it
difference(){
//  translate([-2.5,0,-4]) cube([40,93,8],center=true);
  translate([0,0,-4]) cube([50,110,8],center=true);
  translate([8,36,0]) hexKeyMM(4,68,22,5.5);
  translate([3,29,0]) hexKeyMM(3,63,17,5,5); // this key isn't 90°, so the angle had to be modified
  translate([-1.5,20,0]) hexKeyMM(2.5,52,15,4.5);
  translate([-6,15,0]) hexKeyMM(2,48,14,4.5);
  translate([-10,10,0]) hexKeyMM(1.5,45,12,4.5);
  translate([0,-27.5,0]) cuboid([42,30,15], rounding=5);  // cuboid can replaced by cube, if BOSL is not available
}
