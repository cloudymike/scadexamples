// Create hole and countersink space that can be used
// to diff to create a proper hole for an M screw
// 
// Original design only for M5

//m5_length=16;
//m5_countersink_depth=2.9;
//m5_countersink_top_diameter=10.0;
//m5_diameter=5.5;

//Simple vector with parameters.
//Add in the values as we collect them
//Yes,the first one is for 0, so leave at 0
countersink_top_diameter=[0,0,0,0,0,10.0];
countersink_depth=[0,0,0,0,0,2.9];
diameter=[0,0,0,0,0,5.5];

module countersink(top_radius, hole_radius, sink_depth)
{
      rotate_extrude($fn=200) 
      polygon([[0,0],[top_radius,0],[hole_radius,sink_depth],[0,sink_depth]]);
}

module countersinkScrewHole(Msize=5,length=25)
{
    assert(Msize==5, "Invalid M size");
      cylinder(d=countersink_top_diameter[Msize],h=1,center=true, $fn=64);
      translate([0,0,0.5])countersink(countersink_top_diameter[Msize]/2,2.5,countersink_depth[Msize]);
      translate([0,0,length/2])cylinder(d=diameter[Msize],h=length,center=true, $fn=64);
}



countersinkScrewHole(Msize=5,length=25);