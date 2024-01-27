

module slotring(outer_radius=3,inner_radius=1,height=2)
{
  difference () 
  {
    cylinder(r=outer_radius,h=height,center=true,$fn=64);
    cylinder(r=inner_radius,h=height,center=true,$fn=64);
    translate([outer_radius/2,0,0])cube([outer_radius,inner_radius,height],center=true);
  }
  
}

module spacer(outer_radius=3,inner_radius=1,height=2)
{
  cube([outer_radius-inner_radius,outer_radius-inner_radius,height],center=true);
}

module onestep(
  outer_radius=3,
  inner_radius=1,
  height=2,
  slotdegree=0
)
{
  rotate([0,0,slotdegree]) slotring(outer_radius,inner_radius,height);
  translate([-outer_radius+inner_radius,0,height])spacer(outer_radius,inner_radius,height);
}

module wireguide(
  outer_radius=3,
  inner_radius=1,
  height=2,
  steps=3
)
{
  echo(steps);
  for (step = [1:steps])
  {
    direction=(step%3-1)*90;
    echo(step*2*height,direction);
    
    translate([0,0,step*2*height]) onestep(outer_radius,inner_radius,height,direction);
//    translate(0,0,step*2*height) 
  }
}


wireguide();

//onestep();
