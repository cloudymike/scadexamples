use <material.scad>

//center
rotate([0,0,90])lumber6feet2x4();

//ends
translate([foot(4)-nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
translate([-foot(4)+nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();

//rafters
translate([inch(16)-nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
translate([inch(32)-nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
translate([-inch(16)+nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
translate([-inch(32)+nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();


translate([0,foot(3)+nominal(2)/2,0])lumber8feet2x4();
translate([0,-foot(3)-nominal(2)/2,0])lumber8feet2x4();




