use <../threads/isothreads.scad>

// Use finest resolution of Cura for screws smaller than m5


//function segments (diameter) = min (($fn < 0.01) ? 50 : 2, ceil (diameter*6));


// ----------------------------------------------------------------------------
// diameter -    outside diameter of threads in mm. Default: 8.
// pitch    -    thread axial "travel" per turn in mm.  Default: 1.
// length   -    overall axial length of thread in mm.  Default: 1.
// internal -    true = clearances for internal thread (e.g., a nut).
//               false = clearances for external thread (e.g., a bolt).
//               (Internal threads should be "cut out" from a solid using
//               difference ()).
// n_starts -    Number of thread starts (e.g., DNA, a "double helix," has
//               n_starts=2).  See wikipedia Screw_thread.
// thread_size - (non-standard) axial width of a single thread "V" - independent
//               of pitch.  Default: same as pitch.
// groove      - (non-standard) subtract inverted "V" from cylinder (rather than
//               add protruding "V" to cylinder).
// square      - Square threads (per
//               https://en.wikipedia.org/wiki/Square_thread_form).
// rectangle   - (non-standard) "Rectangular" thread - ratio depth/(axial) width
//               Default: 1 (square).
// angle       - (non-standard) angle (deg) of thread side from perpendicular to
//               axis (default = standard = 30 degrees).
// taper       - diameter change per length (National Pipe Thread/ANSI B1.20.1
//               is 1" diameter per 16" length). Taper decreases from 'diameter'
//               as z increases.
// leadin      - 1 (default): chamfer (45 degree) at max-z end; 0: no chamfer;
//               2: chamfer at both ends, 3: chamfer at z=0 end.
// leadfac     - scale of leadin chamfer (default: 1.0 = 1/2 thread).

module halfdome(d=8)
{
  difference() {
    sphere(d=d,$fn=60);
    translate([0,0,-d/2])cube([d,d,d],center=true); 
    
  }
}


module cap(d=8,h=6)
{
  domeheight=d/2;
  cylinderheight=h-domeheight;
  cylinder(d=d,h=cylinderheight,$fn=60);
  translate([0,0,cylinderheight])halfdome(d);
}

module capnut(
  m=3,
  tolerance=0.14,
  sphere_d=8,
  screwlength=5
)
{
  difference() {
    cap(d=sphere_d, h=screwlength+1);
    metric_thread (diameter=m+(2*tolerance), pitch=0.5, length=(sphere_d-1)/2, internal=true);
    
  }
}


capnut(screwlength=6);