use <honeycomb_lamp.scad>
use <ring.scad>

// Interior diameter (mm)
inner_diameter = 90; 

// Height (mm)
height = 140;

// Inner width of translucent wall - should be no less than nozzle width (mm)
inner_width = 0.4;

// Width of honeycomb (mm)
comb_width = 10;

// Honeycomb wall width (mm)
wall_width = 1;

// Honeycomb cells for a complete circle
comb_cells = 17; // [5:180]


honeycomb_vase(inner_diameter = inner_diameter,
                          height = height,
                          inner_width = inner_width,
                          comb_width = comb_width,
                          wall_width = wall_width,
                          comb_cells = comb_cells);

translate([0,0,3]) ringattachment(outsidediameter=inner_diameter);