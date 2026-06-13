

use <controller.scad>

function screwTabWidth()=16; 
function screwTabThick()=2; 
 
module right_angle_prism(l, w, h) {
    linear_extrude(height = h) {
        polygon(points=[[0,0],[l,0],[0,w]], paths=[[0,1,2]]);
    }
}

module screwtab(tabHeight=20)
{
    tabX=21;
    tabY=screwTabWidth();
    tabThick=screwTabThick();
    screwD=5;
    screwHeadD=10;

    difference()
    {
        translate([tabX/2,0,tabThick/2])cube([tabX,tabY,tabThick],center=true);
        translate([tabX-screwD,0,0])cylinder(d=screwD,h=4*tabThick,center=true, $fn=64);
        translate([tabX-1.5*screwD-screwHeadD/2,0,0])cylinder(d=screwHeadD,h=4*tabThick,center=true, $fn=64);
        translate([tabX-1.5*screwD,0,0])cube([screwD,screwD,4*tabThick],center=true);
    }
    translate([tabThick/2,0,tabHeight/2])cube([tabThick,tabY,tabHeight],center=true);
    
    translate([tabThick,tabY/2,tabThick])rotate([90,0,0])right_angle_prism(tabX-tabThick,tabHeight-tabThick,tabThick);
    translate([tabThick,-tabY/2+tabThick,tabThick])rotate([90,0,0])right_angle_prism(tabX-tabThick,tabHeight-tabThick,tabThick);

    translate([tabX/2,0,tabThick-0.1])cube([tabX,tabY,0.2],center=true);
    
}

screwtab();