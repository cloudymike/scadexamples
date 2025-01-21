use <MCAD/boxes.scad>

base_length=140;
base_width=25;
base_height=3;


module plain_plate()
{
  corner_radius=5;
  translate([0,0,base_height/2])roundedBox(size=[base_length,base_width,base_height],radius=corner_radius,sidesonly=true);
}

module wood_grain()
{
linear_extrude(height = 1, center = true, convexity = 10)
   import (file = "woodgrain.dxf");
}

module plate()
{
  difference()
  {
    plain_plate();
    translate([45,0,0])scale([1.3,1,1])rotate([0,0,90])wood_grain();  
  }
}


module peg(width=11)
{
  height=8;
  length=20;
  translate([-width/2,0,0])cube([width,height,length]);
  
}

module end_plate()
{
  plate();
  translate([0,-base_width/2,base_height])peg();
  
  translate([-24,-base_width/2,base_height])peg();
  translate([24,-base_width/2,base_height])peg();

  translate([-48,-base_width/2,base_height])peg(8);
  translate([48,-base_width/2,base_height])peg(8);
  
}

end_plate();
