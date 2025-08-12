use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-baseplate.scad>
include <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>
include <../gridfinity-rebuilt-openscad/standard.scad>


// ===== PARAMETERS ===== //

/* [Setup Parameters] */
$fa = 8;
$fs = 0.25;

/* [General Settings] */
/* [Screw Together Settings - Defaults work for M3 and 4-40] */
// screw diameter
d_screw = 3.35;
// screw head diameter
d_screw_head = 5;
// screw spacing distance
screw_spacing = .5;
// number of screws per grid block
n_screws = 1; // [1:3]



// where to align extra space along x
fitx = -1; // [-1:0.1:1]
// where to align extra space along y
fity = -1; // [-1:0.1:1]


/* [Styles] */

// baseplate styles
style_plate = 1; // [0: thin, 1:weighted, 2:skeletonized, 3: screw together, 4: screw together minimal]

// enable magnet hole
enable_magnet = true;

// hole styles
style_hole = 0; // [0:none, 1:countersink, 2:counterbore]


// ===== IMPLEMENTATION ===== //
screw_together = (style_plate == 3 || style_plate == 4);

module myThickplate(
  gridx=1, // number of bases along x-axis
  gridy=1, // number of bases along y-axis
  distancex=0, // minimum length of baseplate along x (leave zero to ignore, will automatically fill area if gridx is zero)
  distancey=0 // minimum length of baseplate along y (leave zero to ignore, will automatically fill area if gridy is zero)
 )
{
  difference () {
    gridfinityBaseplate(gridx, gridy, l_grid, distancex, distancey, style_plate, enable_magnet, style_hole, fitx, fity);
    // Hack for long screwholes
    //my_cutter_screw_together(gridx, gridy, calculate_off(style_plate, enable_magnet, style_hole));
  }
}


module my_cutter_screw_together(gx, gy, off) {

    screw(gx, gy);
    rotate([0,0,90])
    screw(gy, gx);

    module screw(a, b) {
        copy_mirror([1,0,0])
        translate([a*l_grid/2, 0, -off/2])
        pattern_linear(1, b, 1, l_grid)
        pattern_linear(1, n_screws, 1, d_screw_head + screw_spacing)
        rotate([0,90,0])
        cylinder(h=l_grid/2+42, d=d_screw, center = true);
    }
}

myThickplate(1,1,0,0);