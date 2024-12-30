use <edging.scad>
module shankring() {
  shankHole=23.4;
  kegTowerOD=3*25.4;
  wallThickness=4;
  sectionHeight=36;
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
  rotate([0,180,-45])translate([-kegTowerOD/2+wallThickness*1,-nutSide/2,nutSide/2+1*wallThickness])prism(nutSide,wallThickness,wallThickness);
  
}

//difference ()
//{
  shankring();
//  translate([0,-20,0])cube([80,40,34],center=true);
//  translate([-20,0,0])cube([40,80,34],center=true);
//}