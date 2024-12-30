use <foot.scad>



module extender() {
  kegTowerOD=3*25.4;
  wallThickness=4;
  sectionHeight=30;
  overlap=20;
  screwPosition=10;

  m5_length=16;
  m5_countersink_depth=2.9;
  m5_countersink_top_diameter=9.2;
  m5_diameter=5.5;

  
  difference () {
    cylinder(d=kegTowerOD,h=sectionHeight,center=true, $fn=128);
    cylinder(d=kegTowerOD-2*wallThickness, h=sectionHeight,center=true, $fn=128);
    translate([-kegTowerOD/2,0,-sectionHeight/2+screwPosition])rotate([0,90,0])cylinder(d=m5_diameter,h=kegTowerOD/2);
    translate([-kegTowerOD/2,0,-sectionHeight/2+screwPosition])rotate([0,90,0])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
  }
  translate([0,0,overlap])overlapRing(sectionHeight,kegTowerOD,wallThickness);
}

module overlapRing(
  sectionHeight=10,
  kegTowerOD=3*25.4,
  wallThickness=4,
)
{
  difference () {
    cylinder(d=kegTowerOD-2*wallThickness-0.4, h=sectionHeight,center=true, $fn=128);
    cylinder(d=kegTowerOD-4*wallThickness,h=sectionHeight,center=true, $fn=128);
  }
}
extender();
