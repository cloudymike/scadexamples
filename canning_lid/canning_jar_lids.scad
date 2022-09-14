// A threaded lid for a standard narrow mouth home canning jar (Ball, Mason, etc.)
// Dependency:  round_threads.scad

//  David O'Connor https://www.thingiverse.com/lizard00
//
//  This work is under the Creative Commons 3.0 Attribution Unported (CC-BY-3.0) license.
//  (https://creativecommons.org/licenses/by/3.0/)
//
// 23 November 2018

// Reference:  https://en.wikipedia.org/wiki/Mason_jar

// You'll need to change the path to work with your particular file system
use <round_threads.scad>

module canning_jar_lid (jar_size="narrow") {
    
    thread = 3;             // Thread diameter
    
    // According to Wikipedia, the outside diameter is 70 mm (86 mm for wide mouth) 
    // Below is some trial-and-error for getting the dimensions correct.  This was on a Creality CR-10S
    //   with Tianse PLA filament; bed at 60 C and hot end at 225.  Your results may vary.
    //d_nominal = 70.6;     // Nominal measured jar rim diameter (This value way too big; threads don't even engage.)
    //d_nominal = 66.5;     // Snug; barely fits
    
    d_narrow = 67.2;       // *** USE THIS ONE FOR NARROW ***
                            //        Good compromise for narrow mouth; spins onto jar nicely without being overly sloppy
                            
    //d_nominal = 83.2;     // Estimate for wide mouth, *slightly* snug but works fine.
    
    d_wide = 83.3;     //  *** USE THIS ONE FOR WIDE ***
                       //         Wide mouth, if I were going to do it again.
    
    d_nominal = jar_size == "narrow" ? d_narrow : d_wide;
     
    d_clearance = thread + 0.5;  // Add 0.5 mm for slop
    d = d_nominal + d_clearance; // Diameter for the base cylinder
    pitch = 0.25 * 25.4;  // Thread pitch
    thread_length = 16;   // Length of threaded section
    thickness = 1;        // Wall thickness 
    rounding = 3;         // Bevel radius 
    total_height = thread_length + thickness;
    
    rotate([180,0,0])
    translate([0,0,-total_height])
    difference() {
        difference() {
            minkowski() 
            {
                sphere(r = rounding, $fa=5, $fs=0.2);
                translate([0, 0, rounding])
                    // The default faceting works nicely for making the lid easy to grip
                    cylinder(r = d * 0.5 + thickness, h = thread_length + thickness - 2* rounding);
            }
            round_threads(diam = d, thread_diam = thread, pitch = pitch, thread_length = thread_length, groove = true, num_starts = 1);
        }
    }
}  

        

