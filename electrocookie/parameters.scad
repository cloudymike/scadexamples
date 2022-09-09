// Case for Halfsize Electrocookie board
// Parameters for include to keep them same for top and bottom.
// Provide parameters for different electrocookie boards
// Default to halfsize.
// All sizes in mm (even though it is mostly inch based board)

//TODO, this should be modulerized
//For now keep the vars in an include file

//================Customization variables=========================
//Define type of electrocookie board
// full, half, mini
board_version = "half";

// Row where the first pin of the display is placed
// Comment out if no display
// Display type is 0.96" OLED
display_pin1_row = 23;

// Row where the first pin of the phone jack is placed
// Comment out if no phone jack
// Assume using column A
jack_pin1_row = 16;

// Column where the first pin of the ESP32 board is placed
// Comment out if no ESP32
// ESP32 board is DEVKIT, 30pin
ESP32_pin1_column = "B";
//=================End of customization===========================



//Global rendering vars
$fa = 1;
$fs = 0.4;

// board_length
board_length =
(board_version == "full") ? 172.7:
(board_version == "half") ? 88.9:
(board_version == "mini") ? 50.8:88.9;

// board_length
board_width =
(board_version == "full") ? 52.1:
(board_version == "half") ? 52.1:
(board_version == "mini") ? 38.1:52.1;

//m3_hole_distance
m3_hole_distance = 
(board_version == "full") ? 78.7:
(board_version == "half") ? 73.7:
(board_version == "mini") ? 40.6:73.7;

//row_count
row_count =
(board_version == "full") ? 63:
(board_version == "half") ? 30:
(board_version == "mini") ? 17:30;

//Distance from edge to first row
first_row =
(board_version == "full") ? 7.65:
(board_version == "half") ? 7.6:
(board_version == "mini") ? 5.1:7.6;

first_column =
(board_version == "full") ? 12:
(board_version == "half") ? 12:
(board_version == "mini") ? 5.1:12;


//Common parameters

board_buffer = 3;
wall_depth = 2.5;

row_spacing = 2.54;


box_length = board_length +4*wall_depth + 2*board_buffer;
box_width = board_width + 4*wall_depth + 2*board_buffer;
corner_radius=5;

knurl_depth = 5;

corner_screw_distance = 5;

// Custom features

// OLED display
oled_width = 27.40;
oled_display_width = oled_width;
oled_height = 28;
oled_display_height = 15;
oled_bottom_space = 8;
oled_pin1 = 10;
oled_pin_from_top = 2;

