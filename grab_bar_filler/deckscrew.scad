
module countersink(top_radius, hole_radius, sink_depth)
{

      rotate_extrude($fn=200) 
      polygon([[0,0],[top_radius,0],[hole_radius,sink_depth],[0,sink_depth]]);
}


module deckscrew(depth=40)
{
  head_r=4.2;
  head_depth=4;
  screwhole_r=2;
  
  rotate([0,90,0])
  {
    cylinder(r=screwhole_r,h=depth,center=true,$fn=64);
    translate([0,0,-depth/2])countersink(head_r, screwhole_r, head_depth);
  }
}

difference()
{
  cube([10,10,10],center=true);
  deckscrew(10);
}