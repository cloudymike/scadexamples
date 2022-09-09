// Case for Electrocookie board

include <parameters.scad>
use <knurlpocket.scad>
use <MCAD/boxes.scad>

base_height = 2 * wall_depth;
base_length = box_length;
base_width = box_width;
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

