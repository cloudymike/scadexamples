use <../threads/threads.scad>
//Global rendering vars
$fa = 1;
$fs = 0.4;
NOZZLE_WIDTH=0.4;
OVEREXTRUSION = NOZZLE_WIDTH / 2;
OE_inch = OVEREXTRUSION / 25.4;
echo (str ("Overextrusion in inch: ", OE_inch));

difference () {

    // Hex outside
    translate([0,0,0.01]) // For no fake ceiling
        cylinder(d=40, h=19.05+3.175+9.525-0.1, $fn=6); 
 
    // Tapered.  Example -- pipe size 3/4" -- per:
    // http://www.engineeringtoolbox.com/npt-national-pipe-taper-threads-d_750.html
    english_thread (diameter=1.050+OE_inch, threads_per_inch=14, length=3/4, taper=1/16);
 
    // washer space
    translate([0,0,19.05])
        cylinder(d=26.9875,h=3.175+0.01);

    // Tapered.  Example -- pipe size 1/2" -- per:
    // https://pickhose.com/garden-hose-thread-vs-npt/
    translate([0,0,19.05+3.175])
       english_thread (diameter=1+1/16+1/32, threads_per_inch=11.5, length=3/8);
        
    // mask out most stuff...to create a test nut
    //cube([50,50,2*(19.05+3.175)],center=true);
}