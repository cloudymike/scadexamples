

module riser(
  leg_d=30.5,
  rise=40.6,
)
{
  wall_thickness=5;
  leg_overlap=leg_d;
  outer_d=leg_d+2*wall_thickness;
  total_h=rise+leg_overlap;
  difference() 
  {
    cylinder(d=outer_d,h=total_h, center=true, $fn=64);
    translate([0,0,total_h/2-leg_overlap/2])cylinder(d=leg_d,h=leg_overlap, center=true, $fn=64);
  }
  
}
 

riser();
  