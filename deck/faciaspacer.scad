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
  
  
  difference()
  {
    cube([nominal(4),inch(1),inch(3/16)],center=true);
    cylinder(d=5,h=100,center=true, $fn=64);
    countersink(screwHeadD, screwD, screwHeadH);
    translate([boardScrewDistance+boardOffset/2,0,0])cylinder(d=trexScrewD*2,h=100, center=true, $fn=65);
    translate([-boardScrewDistance+boardOffset/2,0,0])cylinder(d=trexScrewD*2,h=100, center=true, $fn=65);

  }

}

faciaspacer();


