
thick=1.2;

module ballhole() {translate([9,0,0])cylinder(h=thick+0.01,d=6,center=true, $fn=64);}

difference()
{
  cylinder(h=thick,d=30,center=true, $fn=64);
  cylinder(h=thick+0.01,d=10,center=true, $fn=64);
  rotate([0,0,0])ballhole();
  rotate([0,0,120])ballhole();
  rotate([0,0,-120])ballhole();
  
}