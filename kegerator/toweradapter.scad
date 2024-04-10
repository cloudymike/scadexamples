
socket_height=9;
oldgasket_height=1;
newgasket_height=3.5;
nut_height=5;
m6_length=16;
m5_length=16;
m5_countersink_depth=2.9;
m5_countersink_top_diameter=9;

top_height=m6_length-newgasket_height;

full_height=top_height+socket_height+oldgasket_height;

new_diameter=98.5;
socket_diameter=89;
hole_diameter=30.5;

oldscrewhole_diameter=6;
oldscrewhole_distance=77.5/2;

newscrewhole_distance=87.32/2;
newscrewhole_diameter=6.5;

nut_diameter=9.80;

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

//translate([60,0,0]) countersink(4.5,2.5,2.9);