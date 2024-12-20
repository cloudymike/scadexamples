use <m5.scad>
use <deckscrew.scad>

diameter=77.33;

module basecylinder(height=90)
{
  screw_edge=5;
  screw_hole_d=6.8;
  screw_offset=screw_edge+screw_hole_d/2;
  screw_position_r=diameter/2-screw_offset;
  
  difference()
  {
    translate([0,0,height/2]) cylinder(d=diameter,h=height,center=true,$fn=128);
    translate([screw_position_r,0,0]) screw_hole(height);
    translate([cos(60)*screw_position_r,sin(60)*screw_position_r,0]) screw_hole(height);
    translate([cos(-60)*screw_position_r,sin(-60)*screw_position_r,0]) screw_hole(height);
    translate([cos(120)*screw_position_r,sin(120)*screw_position_r,0]) screw_hole(height);
    translate([cos(-120)*screw_position_r,sin(-120)*screw_position_r,0]) screw_hole(height);
    
    if (height>40)
    {
      translate([0,0,height/3])deckscrew(diameter);
      rotate([0,0,180]) translate([0,0,height/3])deckscrew(diameter);
      translate([0,0,2*height/3])deckscrew(diameter);
      rotate([0,0,180]) translate([0,0,2*height/3])deckscrew(diameter);
    }
  }
}

module sliver(offset=0, height=90)
{
  difference()
  {
    basecylinder(height);
    translate([offset,0,0])cube([diameter,diameter, height*2],center=true);
  }
}

//basecylinder();

sliver(-9.07,88.0);