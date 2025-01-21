use <material.scad>


module countersink(top_radius, hole_radius, sink_depth)
{
  rotate_extrude($fn=200) 
  polygon([[0,0],[top_radius,0],[hole_radius,sink_depth],[0,sink_depth]]);
}


module faciaspacer()
{
  screwD=4;
  screwHeadD=9;
  screwHeadH=3;
  
  trexScrewD=5;
  
  boardScrewDistance=inch(1.4);
  boardOffset=3;
  
  spacing=inch(3/16);
  //spacing=6;
  
  
  difference()
  {
    cube([nominal(4),inch(1),spacing],center=true);
    cylinder(d=screwD,h=100,center=true, $fn=64);
    translate([0,0,spacing/2])rotate([180,0,0])countersink(screwHeadD/2, screwD/2, screwHeadH);
    translate([boardScrewDistance+boardOffset/2,0,0])cylinder(d=trexScrewD*2,h=100, center=true, $fn=65);
    translate([-boardScrewDistance+boardOffset/2,0,0])cylinder(d=trexScrewD*2,h=100, center=true, $fn=65);
  }
}

faciaspacer();


