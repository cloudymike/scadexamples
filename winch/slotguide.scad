

module slotring(outer_radius=3,inner_radius=1,height=2)
{
  difference () 
  {
    cylinder(r=outer_radius,h=height,center=true,$fn=64);
    cylinder(r=inner_radius,h=height,center=true,$fn=64);
    translate([outer_radius/2,0,0])cube([outer_radius,inner_radius,height],center=true);
  }
  
}

module halfring(outer_radius=3,inner_radius=1,height=2)
{
  difference () 
  {
    cylinder(r=outer_radius,h=height,center=true,$fn=64);
    cylinder(r=inner_radius,h=height,center=true,$fn=64);
    translate([outer_radius/2,0,0])cube([outer_radius,outer_radius*2,height],center=true);
  }
  
}

module spacer(outer_radius=3,inner_radius=1,height=2)
{
  cube([outer_radius-inner_radius,outer_radius,height*2],center=true);
}

module onestep(
  outer_radius=3,
  inner_radius=1,
  height=2,
  slotdegree=0
)
{
  rotate([0,0,slotdegree]) slotring(outer_radius,inner_radius,height);
  translate([-outer_radius/2-inner_radius/2,0,height/2])spacer(outer_radius,inner_radius,height);
}

module wireguide(
  outer_radius=4.43,
  inner_radius=1,
  height=3,
  steps=3,
  spacer_column=1
)
{
  translate ([outer_radius+spacer_column,0,height*steps*2+height/2])rotate([180,0,0])
  {
  for (step = [0:steps-1])
  {
    direction=(step%3-1)*45;
    translate([0,0,step*2*height]) onestep(outer_radius,inner_radius,height,direction);
  }
  //Last ring
  translate([0,0,steps*2*height])rotate([0,0,-90]) halfring(outer_radius,inner_radius,height);
  translate([-outer_radius/2-inner_radius/2,outer_radius/4,steps*2*height])cube([outer_radius-inner_radius,outer_radius/2, height],center=true);
  //Extra distance column
  xposition = -outer_radius-spacer_column+0.01;
  translate([xposition,-outer_radius/2,-height/2])cube([spacer_column,outer_radius,steps*2*height]);
  translate([xposition,0,steps*2*height-height/2])cube([spacer_column,outer_radius/2,height]);
}
  
}

module holster(
  outer_radius=4.43,
  inner_radius=1,
  height=3,
  steps=3,
  spacer_column=1
)
{
  
  wall=2;
  space=0.5;
  
  difference() {
    cylinder(r=outer_radius+space+wall,h=2*height*steps,center=true, $fn=64);
    cylinder(r=outer_radius+space,h=2*height*steps,center=true, $fn=64);
    translate([-(outer_radius+3)/2,0,0])cube([outer_radius+3,outer_radius-inner_radius+2,2*height*steps],center=true);     
  }
  translate([0,0,height*steps+wall/2])
  difference() {
    cylinder(r=outer_radius+space+wall,h=wall,center=true, $fn=64);
    cylinder(r=inner_radius,h=wall,center=true,$fn=64);
    translate([-(outer_radius+space+wall)/2,0,0])cube([outer_radius+space+wall,inner_radius,wall],center=true);
  }
}


//wireguide(outer_radius=8.86/2,inner_radius=1,height=3,steps=3);
//halfring();
//onestep(outer_radius=4,inner_radius=1,height=2);

#translate([5.5,0,12])holster(outer_radius=8.86/2,height=3,steps=3);
