use <nut.scad>

module cap(
    threadDiameter = 17.7,
    cableHole = 14,
    outsideHeight = 10    
)
{
  lowpowernut(
    threadDiameter = 17.7,
    cableHole = 14,
    outsideHeight = 10    
  );
  translate([0,0,outsideHeight-1])cylinder(d=cableHole+1,h=2,center=true);
  
}

rotate([180,0,0])cap();
