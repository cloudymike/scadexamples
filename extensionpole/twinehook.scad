use <extension_pole_thread.scad>

module twinefinger(length=40,thickness=5)
{
  difference()
  {
    translate([0,0,-thickness])cube([length,thickness,thickness]);
    translate([length-thickness/2-1,0,-thickness])cube([2,thickness,thickness/2]);
  } 
}

module top()
{
  thickness=5;
  radius=14.5;
  translate([0,0,-thickness])cylinder(r=radius,h=thickness, $fn=128);
  translate([0,radius-thickness,0])twinefinger();
  translate([0,-radius,0])twinefinger();
  
}

translate([0,0,-0.1])extension_pole_nut(0);
top();


