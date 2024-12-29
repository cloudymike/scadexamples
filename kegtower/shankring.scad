

shankHole=7/8*25.4;
kegTowerOD=3*25.4;
wallThickness=4;
sectionHeight=30;


difference () {
  cylinder(d=kegTowerOD,h=sectionHeight,center=true, $fn=128);
  cylinder(d=kegTowerOD-2*wallThickness, h=sectionHeight,center=true, $fn=128);
  rotate([0,90,45])cylinder(d=shankHole,h=kegTowerOD/2, $fn=64);
  rotate([0,90,-45])cylinder(d=shankHole,h=kegTowerOD/2, $fn=64);

  
}

