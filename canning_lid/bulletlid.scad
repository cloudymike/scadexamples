use <round_threads.scad>

// Parameters: 
// diam          -   Diameter of base cylinder
// thread_diam   -   Diameter of circular thread profile
// pitch         -   Thread pitch
// thread_length -   Length of part
// groove        -   [true] to create groove in base cylinder, otherwise normal thread
// num_starts    -   Number of starts


lidheight=13;
difference () 
{
  translate([0,0,lidheight/2])cylinder(d=87.5,h=lidheight,center=true);
  round_threads(diam = 83.5, thread_diam = 1, pitch = 3, thread_length = lidheight-2, groove = true, num_starts = 1);
}
