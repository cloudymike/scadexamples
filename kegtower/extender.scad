use <foot.scad>
use <knurlpocket.scad>


module extender(  
  sectionHeight=30
) {
  kegTowerOD=3*25.4;
  wallThickness=4;
  overlap=20;

  tubeOnly(sectionHeight,kegTowerOD,wallThickness);
  
  translate([0,0,overlap])overlapRing(sectionHeight,kegTowerOD,wallThickness);
  difference ()
  {
    translate([0,0,overlap/2])cylinder(d=kegTowerOD,h=sectionHeight-overlap,center=true, $fn=128);
    translate([0,0,overlap/2])cylinder(d=kegTowerOD-2*wallThickness-0.4,h=sectionHeight-overlap,center=true, $fn=128);
  }
  
}

module tubeOnly(
  sectionHeight=10,
  kegTowerOD=3*25.4,
  wallThickness=4,
)
{
  m5_length=16;
  m5_countersink_depth=2.9;
  m5_countersink_top_diameter=9.2;
  m5_diameter=5.5;
  screwPosition=10;

   difference () {
    cylinder(d=kegTowerOD,h=sectionHeight,center=true, $fn=128);
    cylinder(d=kegTowerOD-2*wallThickness, h=sectionHeight,center=true, $fn=128);
    translate([-kegTowerOD/2,0,-sectionHeight/2+screwPosition])rotate([0,90,0])cylinder(d=m5_diameter,h=kegTowerOD/2);
    // screw hole
    translate([-kegTowerOD/2,0,-sectionHeight/2+screwPosition])rotate([0,90,0])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
  }
 
}

module overlapRing(
  sectionHeight=10,
  kegTowerOD=3*25.4,
  wallThickness=4,
)
{
  knurlDepth=6;
  knurlRingD=12;
  screwPosition=10;

  difference () {
    cylinder(d=kegTowerOD-2*wallThickness-0.4, h=sectionHeight,center=true, $fn=128);
    cylinder(d=kegTowerOD-5*wallThickness,h=sectionHeight,center=true, $fn=128);
    translate([-kegTowerOD/2+wallThickness+knurlDepth/2+0.2,0,sectionHeight/2-screwPosition])rotate([0,-90,0])m5knurl_pocket(knurlDepth);
    // camfer
    if (sectionHeight > 20)
      translate([0,0,-sectionHeight+4*wallThickness-1])countersink((kegTowerOD-1.8*wallThickness)/2,(kegTowerOD-5*wallThickness)/2,4*wallThickness);

  }
}


extender(32);
