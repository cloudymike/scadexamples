// Case for Electrocookie board

use <../electrocookie/knurlpocket.scad>
use <MCAD/boxes.scad>



//================Variables=========================
//Define type of electrocookie board
// full, half, mini
//=======================================================
module baseplate(
    board_length=300,
    board_width=50,
    bottom_holes=[],
    mount_holes=[],
    )
{

    //Global rendering vars
    $fa = 1;
    $fs = 0.4;
    
    
    //Common parameters
    
    board_buffer = 3;
    wall_depth = 2.5;
    
    row_spacing = 2.54;
    
    
    box_length = board_length +4*wall_depth + 2*board_buffer;
    box_width = board_width + 4*wall_depth + 2*board_buffer;
    corner_radius=5;
    
    knurl_depth = 5;
    
    corner_screw_distance = 5;

    // Base parameters
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
   
    }
    
    for (mountxy=mount_holes)
    {
      echo(mountxy);
      translate([mountxy[0],mountxy[1],5])
            m2knurl_ring();
    }
    
    /*
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
    */    
}

// Example instantiation

baseplate(
    board_length=30,
    board_width=52,
    bottom_holes=[1,11],
    mount_holes=[[0,0]]
);
