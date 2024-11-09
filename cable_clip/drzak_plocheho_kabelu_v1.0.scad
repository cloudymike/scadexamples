// Držák kabelu v1.0
// Cable holder v1.0
//Copyright (c)2022 DaTT.cz
//-------------------------

//nastavení:            //edit setting: 
velikost         =  17; //holder size
sirka            =   7; //holder width
material         = 2.4; //material width
kabel_x          =   6; //cable X
kabel_z          = 2.5; //cable Z
sroub_s          = 3.2; //screw bottom hole diameter
sroub_v          =   6; //screw top hole diameter

//konec nastavení  //end of setting
//=================================
$fn=95;

module hacek_plochy(){
    difference(){
        union(){
            translate([sirka/2,0,0]) cylinder(h=material, d=sirka);
            translate([sirka/2,-sirka/2,0]) cube([velikost-sirka/2-material-kabel_x, sirka, material]);
            translate([velikost-(kabel_x+material*2),-sirka/2,0]) cube([kabel_x+material*2,sirka,kabel_z+material]);
        }
        translate([velikost-(kabel_x+material),-sirka/2,0]) cube([kabel_x,sirka,kabel_z]);
        translate([sirka/2,0,material]) cylinder(h=material+kabel_z, d=sroub_v);
        translate([sirka/2,0,0]) cylinder(h=material, d1=sroub_s, d2=sroub_v);
    }
}   
  

hacek_plochy();
