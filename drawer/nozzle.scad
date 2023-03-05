use <../threads/isothreads.scad>
use <interlockingmodule.scad>

// AAA battery holder
// Tries to pack as many as possible based on tile size
// Does not try to make it symmetric

//$fn=120;
module nozzleTile(
  BoxWidthUnits=1,
  BoxLengthUnits=1
)
{
  height=6;
  length=5;
  interval = 9;
  diameter=6.6;
  
  BoxUnits=40;
  
  WallAdjust = 1;
  
  difference () {
  interlockingbox(
      //Box Width in units
      BoxWidthUnits = BoxWidthUnits,
      //Box Length in units
      BoxLengthUnits = BoxLengthUnits,
      //Box Height in mm
      BoxHeight = height,
      //Box Floor Thickness in mm
      BoxFloor = height+0.01
  );
  
  for (x=[interval/2:interval:BoxUnits*BoxLengthUnits-diameter/2-WallAdjust])
      for (y=[interval/2+2*WallAdjust:interval:BoxUnits*BoxWidthUnits-diameter/2])
          translate([x,y,height-length]) 
            metric_thread(diameter=diameter, pitch=1, length=length);
  }
}





// Test design to print a simple tile to see that the nozzles fit into the 
// threads
module nozzleTest()
{
  difference()
  {
    cube([10,10,6],center=true);
    translate([0,0,-2]) metric_thread(diameter=6.6, pitch=1, length=5);
  }
}

nozzleTile(1,1);

