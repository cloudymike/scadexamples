use <../threads/isothreads.scad>
use <../Hose_Adaptor/hose_adaptor_module.scad>

//Global rendering vars
//$fa = 1;
//$fs = 0.4;
$fn = 100*1;
NOZZLE_WIDTH=0.4;
OVEREXTRUSION = NOZZLE_WIDTH / 2;
OE_inch = OVEREXTRUSION / 25.4;
echo (str ("Overextrusion in inch: ", OE_inch));

top_diameter = 26.9875;
wall_thickness = 3;

union () {
translate([0,0,19.05])
Hose_Adaptor (
// Outer Diameter (bottom)
//outer_diameter_1 = washer_diameter + 4 * wall_thickness,
outer_diameter_1 = 30,
// Wall Thickness (bottom)
wall_thickness_1 = 3,
// Rib Thickness (bottom), set to Zero to remove
barb_size_1 = 0,
// Length (bottom)
length_1 = 0,
// Outer Diameter (top), should be smaller than or equal to Outer Diameter (bottom)
outer_diameter_2 = 4,
// Wall Thickness (top)
wall_thickness_2 = 1,
// Rib Thickness (top), set to Zero to remove
barb_size_2 = 0.75,
// Length (top)
length_2 = 11,
// Middle Diameter
//mid_diameter = washer_diameter + 2 * wall_thickness,
mid_diameter = 30,
// Middle Length
mid_length = 15
);


difference () {

    // Hex outside
    translate([0,0,0]) // For no fake ceiling
        cylinder(d=40, h=19.05, $fn=6);

    // Tapered.  Example -- pipe size 3/4" -- per:
    // http://www.engineeringtoolbox.com/npt-national-pipe-taper-threads-d_750.html
    english_thread (diameter=1.050+OE_inch, threads_per_inch=14, length=3/4, taper=1/16);

    // mask out most stuff...to create a test cut
    //translate([25,-25,0]) cube([50,50,2*(19.05+3.175)],center=true);
}
}