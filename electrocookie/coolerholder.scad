
$fn=64;
large_heatpipe=6.3;
small_heatpipe=4.19;

horizontal_distance = 21.8;
vertical_distance = 62.3;

vertical_shift = 8;

bottom_distance = 10;
side_distance=7;

thickness=1;

difference() {
    cube([90,35,thickness]);
    translate([bottom_distance,side_distance,0])cylinder(d=small_heatpipe,h=thickness);
    translate([bottom_distance+vertical_distance,side_distance,0])cylinder(d=large_heatpipe,h=thickness);
    translate([bottom_distance+vertical_shift,side_distance+horizontal_distance,0])cylinder(d=large_heatpipe,h=thickness);
    translate([bottom_distance+vertical_shift+vertical_distance,side_distance+horizontal_distance,0])cylinder(d=small_heatpipe,h=thickness);
  
}


