// Cable holder v1.0
// Copyright (c)2022 DaTT.cz
// https://www.printables.com/model/272519-drzak-plocheho-kabelu-flat-cable-holder-openscad-p
// Creative Commons (4.0 International License)
// Updated by Mikael Hakansson for nail in cable holder
//-------------------------

//edit setting: 
length           =  11; //holder size
width            = 4.0; //holder width
material         = 1.6; //material width
cabel_x          = 6.0; //cable X
cabel_z          = 3.5; //cable Z
cabel_d          = 3.5; // Diameter for rount cable;
hole             = 1.7; //nail bottom hole diameter
countersink      = hole; //nail countersink diameter
cable            = "round";

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
        if (cable == "round")            
        {    
            translate([length-(cabel_d/2+material),-width/2,cabel_d/2])rotate([90,0,0])cylinder(d=cabel_d,h=width*10,center=true);
            translate([length-(cabel_d+material),-width/2,0]) cube([cabel_d,width,cabel_d/2]);
        }
        else
            translate([length-(cabel_x+material),-width/2,0]) cube([cabel_x,width,cabel_z]);
        translate([width/2,0,material]) cylinder(h=material+cabel_z, d=countersink);
        translate([width/2,0,0]) cylinder(h=material, d1=hole, d2=countersink);
    }
    //translate([length-(cabel_x/2+material/2),-width/2,0]) rotate([90,0,0])cylinder(d=cabel_x,h=width*10,center=true);
}   
  
//Print it upside down to avoid bridge
rotate([180,0,0]) nail_cabel();
