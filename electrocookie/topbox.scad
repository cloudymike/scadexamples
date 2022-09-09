// Case for Electrocookie board
// Top and actual box


// TODO
// Side walls are 2.5 mm. OK but change name of params to reflect reality
// Top is 7.5 mm
//   Full 5 mm depth
//   -5mm from center, but should be 2.5 mm and then if wall is really 2.5 mm change wall depth
// With this box can be 5mm lower and USB port still fit


include <parameters.scad>
use <knurlpocket.scad>
use <MCAD/boxes.scad>

board_height = 17.25; 
air_gap = 5.75; // space above top of board
top_height = 2*wall_depth + board_height + knurl_depth + air_gap;
top_length = box_length;
top_width = box_width;
screw_radius = 1.75;
echo("topbox size:",top_length,top_width,top_height);

inside_length = top_length-2*wall_depth;
inside_width = top_width-2*wall_depth;
inside_height = top_height-2*wall_depth;
inside_offset = 2*wall_depth;
echo("Inside size:",inside_length,inside_width,inside_height);
echo("Side wall width:",(top_length-inside_length)/2);
echo("Top wall width:",top_height - inside_height+inside_offset/2);


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
    if (!is_undef(display_pin1_row)) {
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
    }

// USB hole if ESP32 exist
    if (!is_undef(ESP32_pin1_column)) {
        
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
    if (!is_undef(jack_pin1_row)) {
        
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

//Size of electrocookie board for testing
//Do not include in design
//roundedBox(size=[board_length,board_width,1],radius=5.1,sidesonly=true);

