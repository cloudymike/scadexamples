use <../threads/isothreads.scad>;

thread_length = 8;
testcube=8;
top_edge=testcube/2;
difference()
{
  cube([testcube,testcube,testcube],center=true);
  screw_hole(top_edge);
}

module screw_hole(top_edge)
{
  thread_length=16;
  tolerance=0.2;
  diameter=5;
  pitch=0.8; //See https://en.wikipedia.org/wiki/ISO_metric_screw_thread

  translate([0,0,top_edge-thread_length]) metric_thread (diameter=diameter+2*tolerance, pitch=pitch, length=thread_length, internal=true);
  
}