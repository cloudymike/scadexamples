// All sizes in mm (even though it is mostly inch based board)

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

// Top parameters
board_height = 17.25;
air_gap = 5.75; // space above top of board
top_height = 2*wall_depth + board_height + knurl_depth + air_gap;
top_length = box_length;
top_width = box_width;

// Base parameters
base_height = 2 * wall_depth;
base_length = box_length;
base_width = box_width;


//power_connector parameters
pc_overlap = 5;
pc_width = base_width-4*corner_radius-2*pc_overlap;
pc_height=top_height-wall_depth;


// Custom features

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
