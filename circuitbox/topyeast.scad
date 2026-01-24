// Case for Electrocookie board
// Top and actual box


// TODO
// Side walls are 2.5 mm. OK but change name of params to reflect reality
// Top is 7.5 mm
//   Full 5 mm depth
//   -5mm from center, but should be 2.5 mm and then if wall is really 2.5 mm change wall depth
// With this box can be 5mm lower and USB port still fit


use <../electrocookie/knurlpocket.scad>
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
    board_length=300,
    board_width=50,
    jack_pins=[],
    notches=[],
    oled_center_x=0,oled_center_y=0,oled_vertical=false,
    ESP32_pin1_column="",
    power_connector=false
    )
{
//include <../electrocookie/parameters.scad>
    
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

    // Top parameters
    board_height = 17.25;
    air_gap = 5.75; // space above top of board
    top_height = 2*wall_depth + board_height + knurl_depth + air_gap;
    top_length = box_length;
    top_width = box_width;

    cablehole_radius = 2.5;
    cable_y_offset = wall_depth + cablehole_radius + 1;

    screw_radius = 1.75;
    echo("topbox size:",top_length,top_width,top_height);

    inside_length = top_length-2*wall_depth;
    inside_width = top_width-2*wall_depth;
    inside_height = top_height-wall_depth;
    inside_offset = wall_depth/2+0.01;
    echo("Inside size:",inside_length,inside_width,inside_height);
    echo("Side wall width:",(top_length-inside_length)/2);
    echo("Top wall width:",top_height - inside_height);

    // OLED display
    oled_width = 27.40;
    oled_display_width = oled_width;
    oled_height = 28;
    oled_display_height = 15;
    oled_bottom_space = 8;
    oled_pin1 = 10;
    oled_pin_from_top = 2;
    display_indent=10;
    display_frame = 10;
    
    
    display_rotate= oled_vertical? 90 : 0;


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
        if (oled_center_x != 0 && oled_center_y !=0) {
            /*
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
            */
            echo("OLED center",oled_center_x, oled_center_y);
            echo("OLED left edge from box edge",box_length/2 + oled_center_x - oled_display_width/2);
            echo("OLED bottom edge from box edge",box_width/2 - oled_center_y - oled_display_height/2);
            translate([oled_center_x, oled_center_y, -top_height/2+wall_depth+display_indent/2])
                rotate([0,0,display_rotate])cube([oled_display_width+display_frame*2,oled_display_height+display_frame*2,display_indent],center=true);
            
            
            
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
        if (oled_center_x != 0 && oled_center_y !=0) {
            /*
            oled_center_from_top = first_column+(oled_height/2-oled_pin_from_top);
            oled_top_space = oled_height - oled_display_height - oled_bottom_space;
            y_offset = oled_bottom_space - oled_top_space;
            display_center_from_top = oled_center_from_top - y_offset;
            oled_center_y = - (board_width/2 - display_center_from_top);
            // Use display_row
            oled_pin1_from_left = first_row + (display_pin1_row-1)*row_spacing;
            oled_center_from_pin1 = oled_width/2 - oled_pin1;
            oled_center_x = (oled_pin1_from_left + oled_center_from_pin1) - board_length/2;
            */
            echo("OLED center",oled_center_x, oled_center_y);
            echo("OLED left edge from box edge",box_length/2 + oled_center_x - oled_display_width/2);
            echo("OLED bottom edge from box edge",box_width/2 - oled_center_y - oled_display_height/2);
            translate([oled_center_x, oled_center_y, 0])
                rotate([0,0,display_rotate])cube([oled_display_width,oled_display_height,top_height+1],center=true);
//            translate([oled_center_x, oled_center_y, -top_height/2+display_indent/2])
//                cube([oled_display_width+display_frame*2-1,oled_display_height+display_frame*2-1,display_indent+2*wall_depth-1],center=true);


       trappoints = [
        [-(oled_display_width+display_frame*2-1)/2,-(oled_display_height+display_frame*2-1)/2,-(display_indent+2*wall_depth-1)/2],  //0
        [(oled_display_width+display_frame*2-1)/2,-(oled_display_height+display_frame*2-1)/2,-(display_indent+2*wall_depth-1)/2],   //1
        [(oled_display_width+display_frame*2-1)/2,(oled_display_height+display_frame*2-1)/2,-(display_indent+2*wall_depth-1)/2],  //2
        [-(oled_display_width+display_frame*2-1)/2,(oled_display_height+display_frame*2-1)/2,-(display_indent+2*wall_depth-1)/2], //3
        [-(oled_display_width)/2,-(oled_display_height)/2,(display_indent+2*wall_depth-1)/2],  //4
        [(oled_display_width)/2,-(oled_display_height)/2,(display_indent+2*wall_depth-1)/2],   //5
        [(oled_display_width)/2,(oled_display_height)/2,(display_indent+2*wall_depth-1)/2],    //6
        [-(oled_display_width)/2,(oled_display_height)/2,(display_indent+2*wall_depth-1)/2],   //7
        ];
        
       trapfaces = [
       [0,1,2,3], //bottom
       [4,5,1,0], //front
       [7,6,5,4], //top
       [5,6,2,1], //right
       [6,7,3,2], //back
       [7,4,0,3]]; //left

       translate([oled_center_x, oled_center_y, -top_height/2+display_indent/2]) rotate([0,0,display_rotate])polyhedron(points=trappoints,faces=trapfaces);


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
    // Jack holes if exist
        if (jack_pins) {

            jack_radius = 6;
            jack_center_from_bottom = 12;

            // center_z is 12mm from bottom plate or top of this print
            center_z = top_height / 2 - jack_center_from_bottom;
            for (jack = jack_pins)
            {
                if (jack[1]>top_width)
                    translate([jack[0], top_width/2, center_z-jack[2]])
                        rotate([90,0,0])
                        cylinder(r=jack_radius,h=4*wall_depth, center=true);
                else if (jack[1]<-top_width)
                    translate([jack[0], -top_width/2, center_z-jack[2]])
                        rotate([90,0,0])
                        cylinder(r=jack_radius,h=4*wall_depth, center=true);
                else if (jack[0]>top_length)
                    translate([top_length/2, jack[1], center_z-jack[2]])
                        rotate([0,90,0])
                        cylinder(r=jack_radius,h=4*wall_depth, center=true);
                else if (jack[0]<-top_length)
                    translate([-top_length/2, jack[1], center_z-jack[2]])
                        rotate([0,90,0])
                        cylinder(r=jack_radius,h=4*wall_depth, center=true);
            }
        }
        if (notches)
        {
            notchlevel=top_height/2;
            notchsize=4*wall_depth;
            for (notch = notches)
            {
                 if (notch[1]>top_width)
                    translate([notch[0], top_width/2, notchlevel])
                        cube([notchsize,notchsize,notchsize/2 ], center=true);
                else if (notch[1]<-top_width)
                    translate([notch[0], -top_width/2, notchlevel])
                        cube([notchsize,notchsize,notchsize/2 ], center=true);
                else if (notch[0]>top_length)
                    translate([top_length/2, notch[1], notchlevel])
                        cube([notchsize,notchsize,notchsize/2 ], center=true);
                else if (notch[0]<-top_length)
                    translate([-top_length/2, notch[1], notchlevel])
                        cube([notchsize,notchsize,notchsize/2 ], center=true);
            }
       }
      if (power_connector)
        {

          translate([top_length/2-wall_depth/2,0,0+wall_depth/2])cube([wall_depth,pc_width,pc_height],center=true);
        }
    }
    if (power_connector)
    {
      topstrip=2;
      printmargin=0.2;
      translate([top_length/2-wall_depth/2-2*wall_depth-printmargin,0,-top_height/2+topstrip/2+wall_depth])cube([wall_depth,pc_width,topstrip],center=true);
    }
}


//Size of electrocookie board for testing
//Do not include in design
//roundedBox(size=[board_length,board_width,1],radius=5.1,sidesonly=true);
// difference is for useful cuts to see internal. Do not use in final form
difference()
{
// Uncomment for 2d for outline print
//projection(cut=true) translate([0, 0, -33])rotate([90,0,0])
topbox(
  board_length=68.49986,
  board_width=52.999919999999996,
  jack_pins=[[19.25,999,-3],[-999,4,2]],
  notches=[[-999,17]],
  oled_center_x=17.75,oled_center_y=11,
  oled_vertical=true
//    display_pin1_row = 20,
//    ESP32_pin1_column = "B",
//    power_connector=false
);

// For test prints
translate([0,0,-43])cube([100,100,100],center=true);
//translate([0,0,46])cube([100,100,100],center=true);
//translate([0,0,-55])cube([100,100,100],center=true);
}