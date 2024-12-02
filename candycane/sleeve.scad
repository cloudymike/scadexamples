// model the candy cane tube
module tube(height=5)
{
  difference()
  {
    cylinder(h=height, d=25.4, center=true, $fn=64);
    cylinder(h=height, d=22, center=true, $fn=64);
  }
}

module sleeve(depth=5, sleeve_d=29)
{
  floor_thickness = 2;
  difference()
  {
    cylinder(d=sleeve_d,h=depth+floor_thickness, center=true, $fn=64);
    translate([0,0,floor_thickness])tube(depth);
  }
}

sleeve();