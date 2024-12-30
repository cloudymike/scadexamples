use <edging.scad>
use <extender.scad>
module shankring(sectionHeight=40) {
  shankHole=23.4;
  kegTowerOD=3*25.4;
  wallThickness=4;
  nutSide=32;
  
  
  difference () {
    union() {
      difference () {
        cylinder(d=kegTowerOD,h=sectionHeight,center=true, $fn=128);
        cylinder(d=kegTowerOD-2*wallThickness, h=sectionHeight,center=true, $fn=128);
      }
      rotate([0,0,45])translate([kegTowerOD/2-wallThickness*1.5,0,0])cube([wallThickness,nutSide,nutSide],center=true);
      rotate([0,0,-45])translate([kegTowerOD/2-wallThickness*1.5,0,0])cube([wallThickness,nutSide,nutSide],center=true);
    }
    rotate([0,90,45])cylinder(d=shankHole,h=kegTowerOD/2, $fn=64);
    rotate([0,90,-45])cylinder(d=shankHole,h=kegTowerOD/2, $fn=64);
  }
  rotate([0,180,-45])translate([-kegTowerOD/2+wallThickness*1,-nutSide/2,nutSide/2+0.0*wallThickness])prism(nutSide,wallThickness,wallThickness);
  rotate([0,180,45])translate([-kegTowerOD/2+wallThickness*1,-nutSide/2,nutSide/2+0.0*wallThickness])prism(nutSide,wallThickness,wallThickness);
  
}

module shanktube(totalHeight=60)
{
  overlap=20;
  shankHeight=40;
  shankring();
  tubeHeight=totalHeight-shankHeight;
  assert(tubeHeight>=overlap);
  translate([0,0,-(tubeHeight/2+shankHeight/2)])tubeOnly(tubeHeight);
  
}


shanktube();