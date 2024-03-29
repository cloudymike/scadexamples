// Case for Electrocookie board

use <knurlpocket.scad>
use <MCAD/boxes.scad>


//================Variables=========================
//Define type of electrocookie board
// full, half, mini
//=======================================================
module baseplate(
    board_version,
    bottom_holes=[],
    top_holes=[],
    lightswitch_holes=true // add mounting holes for lightswitch size and distance
    )
{
include <parameters.scad>

    base_height = 2 * wall_depth;
    base_length = box_length;
    base_width = box_width;
    cablehole_radius = 2.5;
    cable_y_offset = wall_depth + cablehole_radius + 1;
    echo("baseplate size:",base_length,base_width,base_height);

    //base plate
    difference() {
      //cube([base_length,base_width,base_height],center=true);
      roundedBox(size=[base_length,base_width,base_height],radius=corner_radius,sidesonly=true);
      translate([base_length/2-corner_screw_distance,
        base_width/2-corner_screw_distance,
        0.001])
        m3knurl_pocket();
      translate([-base_length/2+corner_screw_distance,
        base_width/2-corner_screw_distance,
        0.001])
        m3knurl_pocket();
      translate([base_length/2-corner_screw_distance,
        -base_width/2+corner_screw_distance,
        0.001])
        m3knurl_pocket();
      translate([-base_length/2+corner_screw_distance,
        -base_width/2+corner_screw_distance,
        0.001])
        m3knurl_pocket();

        // cable holes, below card
        for (pin = bottom_holes)
        {
            center_y=cable_y_offset-base_width/2;
            board_x = first_row + (pin - 1) * row_spacing;
            center_x = board_x - board_length/2;
            translate([center_x, center_y, 0])
                cylinder(r=cablehole_radius,h=4*wall_depth, center=true);
        }
        // cable holes, above card
        for (pin = top_holes)
        {
            center_y=-cable_y_offset+base_width/2;
            board_x = first_row + (pin - 1) * row_spacing;
            center_x = board_x - board_length/2;
            translate([center_x, center_y, 0])
                cylinder(r=cablehole_radius,h=4*wall_depth, center=true);
        }
        
        //mounting holes on lightswitch disance
        if (lightswitch_holes)
        {
          translate([96.5/2,0,0]) cylinder(d=3.5,h=base_height*2,center=true);
          translate([-96.5/2,0,0]) cylinder(d=3.5,h=base_height*2,center=true);
        }
    }


    //top knurdle holder for PCB standoff
    echo("PCB standoff distance:",m3_hole_distance);
    if (m3_hole_distance * 2 < base_length) {
        translate([(m3_hole_distance),0,5])
            m3knurl_ring();
        translate([-(m3_hole_distance),0,5])
            m3knurl_ring();
        translate([0,0,5])
            m3knurl_ring();
        echo("PCP standoff from edge:", (base_length-2*m3_hole_distance)/2);

    }
    else {
        translate([(m3_hole_distance/2),0,5])
            m3knurl_ring();
        translate([-(m3_hole_distance/2),0,5])
            m3knurl_ring();
        echo("PCP standoff from edge:", (base_length-m3_hole_distance)/2);
    }
    
}

// Example instantiation
baseplate(
    board_version="full",
    bottom_holes=[1,31,32,33,63],
    top_holes=[32],
    lightswitch_holes=true
);
