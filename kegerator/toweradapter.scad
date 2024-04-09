
socket_height=9;
oldgasket_height=1;
newgasket_height=3.5;
nut_height=5;
m6_length=18;
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
  
  rotate([0,0,45])4holes(oldscrewhole_distance,oldscrewhole_diameter);
  4holes(newscrewhole_distance,newscrewhole_diameter);
  translate([0,0,full_height/2-(nut_height+socket_height+oldgasket_height)/2])
  4holes(newscrewhole_distance,nut_diameter,nut_height+socket_height+oldgasket_height,6);
}


module 4holes(distance, diameter, height=full_height, FN=128)
{
  translate([distance,0,0])rotate([0,0,30])cylinder(d=diameter,h=height, center=true,$fn=FN);
  translate([-distance,0,0])rotate([0,0,30])cylinder(d=diameter,h=height, center=true,$fn=FN);
  translate([0,distance,0])cylinder(d=diameter,h=height, center=true,$fn=FN);
  translate([0,-distance,0])cylinder(d=diameter,h=height, center=true,$fn=FN);
  
}