

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
    translate([0,0,-total_h/2]) skirt((outer_d),(outer_d)/2,total_h);

    //cylinder(d=outer_d,h=total_h, center=true, $fn=64);
    translate([0,0,total_h/2-leg_overlap/2])cylinder(d=leg_d,h=leg_overlap, center=true, $fn=64);
  }
  
}
 
module skirt(foot_radius, outer_radius, foot_height)
{

      rotate_extrude($fn=200) 
      polygon([[0,0],[foot_radius,0],[outer_radius,foot_height],[0,foot_height]]);
}

  riser();
  //translate([47,0,0])cube([90,90,72],center=true);
  //translate([-47,0,0])cube([90,90,72],center=true);
