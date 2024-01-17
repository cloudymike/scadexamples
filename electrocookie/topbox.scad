// Case for Electrocookie board
// Top and actual box


// TODO
// Side walls are 2.5 mm. OK but change name of params to reflect reality
// Top is 7.5 mm
//   Full 5 mm depth
//   -5mm from center, but should be 2.5 mm and then if wall is really 2.5 mm change wall depth
// With this box can be 5mm lower and USB port still fit


use <knurlpocket.scad>
use <MCAD/boxes.scad>

//================Variables=========================
//Define type of electrocookie board
// full, half, mini

// Row where the first pin of the display is placed
// Set to 0 (default) if no display
// Display type is 0.96" OLED

// Row where the first pin of the phone jack is placed
// Set to 0 (default) if no phone jack
// Assume using column A

// Column where the first pin of the ESP32 board is placed
// Set to empty string (default) if no ESP32
// ESP32 board is DEVKIT, 30pin
//=======================================================
module topbox(
    board_version,
    display_pin1_row=0,
    jack_pin1_row=0,
    ESP32_pin1_column=""
    )
{
include <parameters.scad>
    board_height = 17.25;
    air_gap = 5.75; // space above top of board
    top_height = 2*wall_depth + board_height + knurl_depth + air_gap;
    top_length = box_length;
    top_width = box_width;
    screw_radius = 1.75;
    echo("topbox size:",top_length,top_width,top_height);

    inside_length = top_length-2*wall_depth;
    inside_width = top_width-2*wall_depth;
    inside_height = top_height-wall_depth;
    inside_offset = wall_depth/2+0.01;
    echo("Inside size:",inside_length,inside_width,inside_height);
    echo("Side wall width:",(top_length-inside_length)/2);
    echo("Top wall width:",top_height - inside_height);

    display_indent=12;
    display_frame = 10;


    difference() {
    union() {
    difference() {
    //top box walls
      //cube([top_length,top_width,top_height],center=true);
      roundedBox(size=[top_length,top_width,top_height],radius=corner_radius,sidesonly=true);
      translate([0,0,inside_offset])
      cube([inside_length,inside_width,inside_height],center=true);
    }

    // screw columns
      translate([(top_length/2-corner_screw_distance),
        (top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius + wall_depth,h=top_height, center=true);
      translate([(top_length/2-corner_screw_distance),
        -(top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius + wall_depth,h=top_height, center=true);
      translate([-(top_length/2-corner_screw_distance),
        (top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius + wall_depth,h=top_height, center=true);
      translate([-(top_length/2-corner_screw_distance),
        -(top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius + wall_depth,h=top_height, center=true);

    // display hole if exist
        if (display_pin1_row != 0) {
            // Assume it is in column J
            oled_center_from_top = first_column+(oled_height/2-oled_pin_from_top);
            oled_top_space = oled_height - oled_display_height - oled_bottom_space;
            y_offset = oled_bottom_space - oled_top_space;
            display_center_from_top = oled_center_from_top - y_offset;
            oled_center_y = - (board_width/2 - display_center_from_top);
            // Use display_row
            oled_pin1_from_left = first_row + (display_pin1_row-1)*row_spacing;
            oled_center_from_pin1 = oled_width/2 - oled_pin1;
            oled_center_x = (oled_pin1_from_left + oled_center_from_pin1) - board_length/2;
            echo("OLED center",oled_center_x, oled_center_y);
            echo("OLED left edge from box edge",box_length/2 + oled_center_x - oled_display_width/2);
            echo("OLED bottom edge from box edge",box_width/2 - oled_center_y - oled_display_height/2);
            translate([oled_center_x, oled_center_y, -top_height/2+wall_depth+display_indent/2])
                cube([oled_display_width+display_frame*2,oled_display_height+display_frame*2,display_indent],center=true);
            
            
            
        }
 
    }

    //screw holes
      translate([top_length/2-corner_screw_distance,
        top_width/2-corner_screw_distance,
        0])
        cylinder(r=screw_radius,h=top_height+0.01, center=true);
      translate([- (top_length/2-corner_screw_distance),
        top_width/2-corner_screw_distance,
        0])
        cylinder(r=screw_radius,h=2*top_height+0.01, center=true);
      translate([(top_length/2-corner_screw_distance),
        -(top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius,h=top_height+0.01, center=true);
      translate([-(top_length/2-corner_screw_distance),
        -(top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius,h=top_height+0.01, center=true);


    // display hole if exist
        if (display_pin1_row != 0) {
            // Assume it is in column J
            oled_center_from_top = first_column+(oled_height/2-oled_pin_from_top);
            oled_top_space = oled_height - oled_display_height - oled_bottom_space;
            y_offset = oled_bottom_space - oled_top_space;
            display_center_from_top = oled_center_from_top - y_offset;
            oled_center_y = - (board_width/2 - display_center_from_top);
            // Use display_row
            oled_pin1_from_left = first_row + (display_pin1_row-1)*row_spacing;
            oled_center_from_pin1 = oled_width/2 - oled_pin1;
            oled_center_x = (oled_pin1_from_left + oled_center_from_pin1) - board_length/2;
            echo("OLED center",oled_center_x, oled_center_y);
            echo("OLED left edge from box edge",box_length/2 + oled_center_x - oled_display_width/2);
            echo("OLED bottom edge from box edge",box_width/2 - oled_center_y - oled_display_height/2);
            translate([oled_center_x, oled_center_y, 0])
                cube([oled_display_width,oled_display_height,top_height+1],center=true);
            translate([oled_center_x, oled_center_y, -top_height/2+display_indent/2])
                cube([oled_display_width+display_frame*2-1,oled_display_height+display_frame*2-1,display_indent+2*wall_depth-1],center=true);
        }

    // USB hole if ESP32 exist
        if ((ESP32_pin1_column == "A") || (ESP32_pin1_column == "B")) {

            usb_width = 12;
            usb_height = 8;
            usb_center_from_bottom = 21;

            // center_z is 21mm from bottom plate or top of this print
            center_z = top_height / 2 - usb_center_from_bottom;
            // If Column A, half row above center Y, if B half row below center Y
            center_y = (ESP32_pin1_column == "A") ? row_spacing/2 : -row_spacing/2;
            translate([-top_length/2, center_y, center_z])
                cube([4*wall_depth, usb_width,usb_height],center=true);
            echo("Looking at outside, plate at bottom");
            echo("usb right edge from box edge",top_width/2-center_y-usb_width/2);
            echo("usb bottom edge from bottom edge",usb_center_from_bottom-usb_height/2);

        }
    // Jack hole if exist
        if (jack_pin1_row != 0) {

            jack_radius = 6;
            jack_center_from_bottom = 12;

            // center_z is 12mm from bottom plate or top of this print
            center_z = top_height / 2 - jack_center_from_bottom;
            // center_x is pin1 + 2 row_spacings
            // add 1, 2 more -1 as as first pin is 1 not 0
            board_x = first_row + (jack_pin1_row + 1) * row_spacing;
            center_x = board_x - board_length/2;
            translate([center_x, top_width/2, center_z])
                rotate([90,0,0])
                cylinder(r=jack_radius,h=4*wall_depth, center=true);
            echo("Looking at outside, plate at bottom");
            echo("jack center from box right edge",top_length/2-center_x);
            echo("jack center from bottom edge",jack_center_from_bottom);

        }
    }
}


//Size of electrocookie board for testing
//Do not include in design
//roundedBox(size=[board_length,board_width,1],radius=5.1,sidesonly=true);
difference() {
topbox(
    board_version="half",
    display_pin1_row = 20,
    jack_pin1_row = 16,
    ESP32_pin1_column = "B"
);
    cube([50,80,100],center=true);
    translate([60,0,0]) cube([40,80,100],center=true);
    translate([-40,0,0]) cube([40,80,100],center=true);
}