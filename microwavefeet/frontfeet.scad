
$fn=64;
difference()
{
  cube([30,30,5.5],center=true);
  cylinder(d=18,h=6,center=true);
}
translate([30/2-4/2,0,10/2+5.5/2]) cube([4,30,10],center=true);
translate([-(30/2-4/2),0,10/2+5.5/2]) cube([4,30,10],center=true);