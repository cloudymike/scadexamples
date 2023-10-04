//Creates a hook for a Standard double slot shelf track
//Coordinates are made so it should line up with the top of the thing you are adding
//   Yes the hooks needs to stick up a bit otherwise you can not put them in.



//Draw a prism based on a 
//right angled triangle
//l - length of prism
//w - width of triangle
//h - height of triangle
//From https://github.com/orionrobots/openscad_parts_library/blob/master/prism.scad
module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}
module oneslot(backwallwidth=22) {
  
  // These are numbers that make it fit, not necessarily the real numbers as measured on the track
  slotwidth=2.5;
  slotdepth=2;
  slotheight=18;  
  raildepth=13;
  backwallheight=22;
  
  dummythick=2;
  
  translate([0,slotwidth,0]) rotate(180) prism(slotwidth, raildepth, slotheight);
  cube([slotdepth,slotwidth,slotheight]);
  difference () {
    translate([-raildepth,0,-raildepth]) cube([raildepth,slotwidth,raildepth]);
    translate([-raildepth,0,-raildepth]) prism(slotwidth, raildepth/4, raildepth/4);
  }
  
  translate([slotdepth,slotwidth/2-backwallwidth/2,(slotheight-backwallheight)/2]) cube([dummythick,backwallwidth,backwallheight]);

  // Dummy wall for testing, creating a foot to easier test print. Rotate so foot is on build plate rotate([180,0,0])
  //translate([slotdepth,slotwidth/2-backwallwidth/2,backwallheight+(slotheight-backwallheight)]) cube([20,backwallwidth,dummythick]);
  

}

module twoslot(backwallwidth=22) {
  slotdepth=2;
  slotwidth=2.5;
  slotspace=11;
  backwallwidth = max(backwallwidth,11);
  translate([0,0,-slotdepth]) rotate([0,180,90]) {
    translate([-slotdepth,-slotspace/2-slotwidth/2,0])oneslot(backwallwidth);
    translate([-slotdepth,slotspace/2-slotwidth/2,0]) oneslot(backwallwidth);
  }
  echo (Slot_distance=(slotspace/2-slotwidth/2)-(-slotspace/2-slotwidth/2));
}
twoslot(11);
