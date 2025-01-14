use <extender.scad>

socket_height=7.5;
oldgasket_height=0;
newgasket_height=3.5;
nut_height=5;
m6_length=16;
m5_length=16;
m5_countersink_depth=2.9;
m5_countersink_top_diameter=9.2;
wallHeight=4;

//top_height=m6_length-newgasket_height;
top_height=wallHeight;

full_height=top_height+socket_height+oldgasket_height;

new_diameter=104;
socket_diameter=90;
hole_diameter=30.5;

oldscrewhole_diameter=5.5;
oldscrewhole_distance=77.5/2;

newscrewhole_distance=83.31/2;
newscrewhole_diameter=6.5;

nut_diameter=12;

shankHole=7/8*25.4;
kegTowerOD=3*25.4;
wallThickness=4;
overlap=20;

//Extra depth for the top of the m5 screw
m5_well=1;

module foot()
{
  
  translate([0,0,-(full_height+overlap)/2])rotate([0,0,45])overlapRing(overlap,kegTowerOD,wallThickness);

  difference()
  {
    //outside
    cylinder(d=new_diameter,h=full_height,center=true, $fn=128);
    //Hole for tubing
    cylinder(d=hole_diameter,h=full_height,center=true, $fn=128);
    //Fit current socket on kegerator
    translate([0,0,full_height/2-(socket_height+oldgasket_height)/2])cylinder(d=socket_diameter,h=socket_height+oldgasket_height,center=true, $fn=128);
  
    rotate([0,0,45])4holes(oldscrewhole_distance,oldscrewhole_diameter);
    //Assuming that m5 goes to bottom of socket
    rotate([0,0,45])translate([0,0,-full_height/2+m5_well/2])4holes(oldscrewhole_distance,m5_countersink_top_diameter,m5_well+0.2);
  
    //countersinks
    rotate([0,0,45])translate([oldscrewhole_distance,0,-full_height/2+m5_well])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
    rotate([0,0,-45])translate([oldscrewhole_distance,0,-full_height/2+m5_well])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
    rotate([0,0,135])translate([oldscrewhole_distance,0,-full_height/2+m5_well])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
    rotate([0,0,-135])translate([oldscrewhole_distance,0,-full_height/2+m5_well])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
  }
  
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

//difference()
//{
  foot();
//  translate([0,0,2])cylinder(d=120,h=full_height,center=true);
//}
  
