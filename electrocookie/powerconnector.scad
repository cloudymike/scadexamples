
board_version = "full";  
include <parameters.scad>


module powerconnector()
{
  aviatorD=16;
  aviatorY=pc_height/2-aviatorD/2-5;
  printmargin=0.2;

  $fn=64;

  // Plate and hole
  difference() 
  {
    union()
    {
      translate([0,0,-(wall_depth+printmargin)/2])cube([pc_width+2*pc_overlap,pc_height,wall_depth-printmargin],center=true);
      translate([0,0,(wall_depth-printmargin)/2])cube([pc_width,pc_height,wall_depth+printmargin],center=true);
    }
    translate([0,aviatorY,0])cylinder(d=aviatorD,h=2*wall_depth,center=true);
  }
  // Slots for connector
  translate([aviatorD/2,0,0]) cube([1.3,pc_height,2*wall_depth],center=true);
  translate([-aviatorD/2,0,0]) cube([1.3,pc_height,2*wall_depth],center=true);
  

}


powerconnector();
