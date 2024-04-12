
socket_height=7.5;
oldgasket_height=0;
newgasket_height=3.5;
nut_height=5;
m6_length=16;
m5_length=16;
m5_countersink_depth=2.9;
m5_countersink_top_diameter=9.2;

top_height=m6_length-newgasket_height;

full_height=top_height+socket_height+oldgasket_height;

new_diameter=104;
socket_diameter=90;
hole_diameter=30.5;

oldscrewhole_diameter=5.5;
oldscrewhole_distance=77.5/2;

newscrewhole_distance=83.31/2;
newscrewhole_diameter=6.5;

nut_diameter=12;

difference()
{
  //outside
  cylinder(d=new_diameter,h=full_height,center=true, $fn=128);
  //Hole for tubing
  cylinder(d=hole_diameter,h=full_height,center=true, $fn=128);
  //Fit current socket on kegerator
  translate([0,0,full_height/2-(socket_height+oldgasket_height)/2])cylinder(d=socket_diameter,h=socket_height+oldgasket_height,center=true, $fn=128);
  
  4holes(newscrewhole_distance,newscrewhole_diameter);
  translate([0,0,full_height/2-(nut_height+socket_height+oldgasket_height)/2])
  4holes(newscrewhole_distance,nut_diameter,nut_height+socket_height+oldgasket_height,6);

  rotate([0,0,45])4holes(oldscrewhole_distance,oldscrewhole_diameter);
  //Assuming that m5 goes to bottom of socket
  m5_top = m5_length+m5_countersink_depth;
  m5_well = full_height-m5_top;
  rotate([0,0,45])translate([0,0,-full_height/2+m5_well/2])4holes(oldscrewhole_distance,m5_countersink_top_diameter,m5_well+0.1);

  //countersinks
  rotate([0,0,45])translate([oldscrewhole_distance,0,-full_height/2+m5_well])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
  rotate([0,0,-45])translate([oldscrewhole_distance,0,-full_height/2+m5_well])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
  rotate([0,0,135])translate([oldscrewhole_distance,0,-full_height/2+m5_well])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
  rotate([0,0,-135])translate([oldscrewhole_distance,0,-full_height/2+m5_well])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
  
  //Cutout for testing screw holes, comment out later
  //rotate([0,0,45])translate([oldscrewhole_distance,0,0]) donutmask();
  //rotate([0,0,0])translate([newscrewhole_distance,0,0]) donutmask();
  
  //Cutout for ring size
  //translate([0,0,-3]) cylinder(h=full_height,d=120,center=true);
  
  //Cutout for top
  translate([0,0,2]) cylinder(h=full_height,d=120,center=true);
}


module 4holes(distance, diameter, height=full_height, FN=128)
{
  translate([distance,0,0])rotate([0,0,30])cylinder(d=diameter,h=height, center=true,$fn=FN);
  translate([-distance,0,0])rotate([0,0,30])cylinder(d=diameter,h=height, center=true,$fn=FN);
  translate([0,distance,0])cylinder(d=diameter,h=height, center=true,$fn=FN);
  translate([0,-distance,0])cylinder(d=diameter,h=height, center=true,$fn=FN);
 
}

module countersink(top_radius, hole_radius, sink_depth)
{

      rotate_extrude($fn=200) 
      polygon([[0,0],[top_radius,0],[hole_radius,sink_depth],[0,sink_depth]]);
}

module donutmask()
{
  difference()
  {
    cylinder(r=120,h=40,center=true);
    cylinder(d=20,h=40,center=true);
  }
}


// Test designs, remove later
///////////////////////////////////////////

// Countersink test
//translate([60,0,0]) countersink(4.5,2.5,2.9);

// nut sizing
//cylinder(d=nut_diameter,h=10,center=true,$fn=6);translate([0,0,10])cylinder(d=nut_diameter,h=10,center=true,$fn=128);