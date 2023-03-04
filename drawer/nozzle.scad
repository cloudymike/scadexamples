use <../threads/isothreads.scad>

module tile1nozzle()
{
  difference()
  {
    cube([10,10,6],center=true);
    translate([0,0,-2]) metric_thread(diameter=6.5, pitch=1, length=5);
  }
}



tile1nozzle();