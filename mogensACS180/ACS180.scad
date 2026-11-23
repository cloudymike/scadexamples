use <prism.scad>


$fn=64;

thickness=1;
//ductLength=50;
//ductLength=9;
ctrlWidth=60.5;
fanHeight=55.2;
ctrlNotch=8;
bottomNotch=4.5;
sideNotch=9;
screwHoleD=5;



module screwFlap()
{
    //Upper inside corner is origo
    
    difference()
    {
        translate([sideNotch/2,-0.75*thickness,-ctrlNotch/2])cube([sideNotch,thickness,ctrlNotch],center=true);
        translate([sideNotch/2,-0.75*thickness,-ctrlNotch/2])rotate([90,0,0])cylinder(d=screwHoleD,h=2*thickness,center=true);
    }
    translate([0,-1.25*thickness,-ctrlNotch/2-sideNotch/2+thickness/2])mirror([0,0,1])prism(thickness,sideNotch,sideNotch);
    
}




module ACS180(ductLength=9)
{
    sideLength=ductLength+ctrlNotch;
    
    translate([0,0,sideLength/2])
    union()
    {
        difference()
        {
            cube([ctrlWidth+2*thickness,fanHeight+2*thickness,sideLength],center=true);
            
            translate([0,0,thickness])cube([ctrlWidth,fanHeight,sideLength-thickness],center=true);
            translate([0,0,ductLength/2])cube([ctrlWidth,fanHeight+2*thickness,ctrlNotch],center=true);
            translate([thickness,fanHeight/2-bottomNotch/2+thickness,ductLength/2])cube([ctrlWidth,bottomNotch,ctrlNotch],center=true);   
        }
    translate([ctrlWidth/2,fanHeight/2-bottomNotch/2-thickness,sideLength/2])screwFlap();
    }
}

module ACS180cutout(Length=20)
{
   translate([0,0,Length/2])cube([ctrlWidth+2*thickness,fanHeight+2*thickness,Length],center=true);
}

ACS180();

