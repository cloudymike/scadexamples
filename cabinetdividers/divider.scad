
ridge_width=5.5;
valley_width=7.5;
ridge_height=6.5;
ridge_top_length=42;
ridge_full_length=52;
plate_height = 0.65;
plate_length=69;
screwhead_radius=2.7;

tolerance=0.2;

module countersink()
{
  
  //assume a 90 degree angle. For US inch screws it is probably 82 degrees
  radius=screwhead_radius;
  depth=2.75;
  rotate_extrude($fn=200)
  polygon(points=[[0,0],[radius,0],[0,depth]], paths=[[0,1,2]]);
}

module ridge()
{
  cube([ridge_width,42,ridge_height],center=true);
  translate([0,21,0])slope();
  translate([0,-21,0])rotate([0,0,180])slope();
}


module slope()
{
  length=(ridge_full_length-ridge_top_length)/2;
  translate([-ridge_width/2,0,-ridge_height/2])rotate([90,0,90])
    linear_extrude(height=ridge_width)
        {
            polygon(points=[[0,0],[length,0],[0,ridge_height]], paths=[[0,1,2]]);
        }
}

module strip(ridges=2)
{
  //ridges
  for (step = [0:ridges-1])
  {
    ridge_x_pos = step*(ridge_width+valley_width);
    translate([ridge_x_pos,0,0]) ridge();
  }
  //baseplate
  plate_width = ridges*(ridge_width+valley_width);
  translate([-ridge_width/2,-plate_length/2,-ridge_height/2-plate_height])cube([plate_width,plate_length,plate_height]);
}

module screwstrip(ridges=2)
{
  difference()
  {
    strip(ridges);
    for (step = [0:ridges-1])
    {
      if ((step % 7) == 0)
      {
        ridge_x_pos = step*(ridge_width+valley_width);
        translate([ridge_x_pos,0,ridge_height/2-0.5]) rotate([180,0,0])countersink();
        translate([ridge_x_pos,0,ridge_height/2]) cylinder(r=screwhead_radius,h=1,center=true,$fn=64);
        translate([ridge_x_pos,0,ridge_height/2]) cylinder(r=1.6,h=100,center=true,$fn=64);
      }
     }
    
  }
}

// 15 is right length for cabinets
screwstrip(15);

