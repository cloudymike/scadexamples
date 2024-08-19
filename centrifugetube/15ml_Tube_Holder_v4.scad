// Vial dimensions from:
// https://www.viaglobalhealth.com/wp-content/uploads/corning-docs/t_centrifuge_tube_insert_DL.pdf

vial_radius = 17.5/2;
vial_cap_radius = 24/2;
bottom_hole_radius = 3.8;

stand_height = 70;
base_height = 10;

vial_cap_clearance = 2;

wall_size = 3;


module tube_cutouts() {
    translate([0,base_height,0]) rotate([-90,0,0]) cylinder(h=stand_height, r=vial_radius);
    #translate([0,3.9,0]) rotate([-90,0,0]) cylinder(h=base_height+0.1-3.9, r1=bottom_hole_radius,r2=bottom_hole_radius+1.5);
    translate([0,-0.1,0]) rotate([-90,0,0]) cylinder(h=4.1, r=vial_cap_radius);
}


stand_width = vial_cap_radius*4+(wall_size*2)+6;

difference() {
    cube([stand_width,stand_height,stand_width]);
    translate([wall_size,base_height,-0.1]) cube([stand_width-(wall_size*2),stand_height-(base_height)-wall_size,stand_width+1]);
    translate([wall_size+2+vial_cap_radius,0,4+2+vial_cap_radius]) tube_cutouts();
    translate([wall_size+4+vial_cap_radius*3,0,4+2+vial_cap_radius]) tube_cutouts();
    translate([wall_size+2+vial_cap_radius,0,wall_size+4+vial_cap_radius*3]) tube_cutouts();
    translate([wall_size+4+vial_cap_radius*3,0,wall_size+4+vial_cap_radius*3]) tube_cutouts();
}



