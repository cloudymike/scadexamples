// Cable holder v1.0
// Copyright (c)2022 DaTT.cz
// https://www.printables.com/model/272519-drzak-plocheho-kabelu-flat-cable-holder-openscad-p
// Creative Commons (4.0 International License)
// Updated by Mikael Hakansson for nail in cable holder
//-------------------------

//edit setting: 
length           =  15; //holder size
width            = 6.0; //holder width
material         = 2.4; //material width
cabel_x          = 6.0; //cable X
cabel_z          = 3.5; //cable Z
hole             = 1.7; //nail bottom hole diameter
countersink      =hole; //nail countersink diameter

//end of setting
//=================================
$fn=95;

module nail_cabel(){
    difference(){
        union(){
            translate([width/2,0,0]) cylinder(h=material+cabel_z, d=width);
            translate([width/2,-width/2,0]) cube([length-width/2-material-cabel_x, width, material+cabel_z]);
            translate([length-(cabel_x+material*2),-width/2,0]) cube([cabel_x+material*2,width,cabel_z+material]);
        }
        translate([length-(cabel_x+material),-width/2,0]) cube([cabel_x,width,cabel_z]);
        translate([width/2,0,material]) cylinder(h=material+cabel_z, d=countersink);
        translate([width/2,0,0]) cylinder(h=material, d1=hole, d2=countersink);
    }
}   
  
//Print it upside down to avoid bridge
rotate([180,0,0]) nail_cabel();
