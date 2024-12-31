use <extender.scad>

module cap()
{
  ringHeight=3;
  capHeight=2;
  kegTowerOD=3*25.4;
  wallThickness=4;
  overlap=20;

  overlapRing(ringHeight,kegTowerOD,wallThickness);
  translate([0,0,-(ringHeight+capHeight)/2])cylinder(d=kegTowerOD,h=capHeight, center=true, $fn=128);
  
}

cap();