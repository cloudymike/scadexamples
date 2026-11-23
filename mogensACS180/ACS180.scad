
$fn=64;

thickness=1;
//ductLength=50;
ductLength=9;
ctrlWidth=60.5;
fanHeight=55.2;
ctrlNotch=8;
bottomNotch=4.5;
sideNotch=9;
screwHoleD=5;

sideLength=ductLength+ctrlNotch;

//right angled triangle
//l - length of prism
//w - width of triangle
//h - height of triangle
//From https://github.com/orionrobots/openscad_parts_library/blob/master/prism.scad
module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

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




module ACS180()
{

    difference()
    {
        cube([ctrlWidth+2*thickness,fanHeight+2*thickness,sideLength],center=true);
        
        cube([ctrlWidth,fanHeight,sideLength],center=true);
        translate([0,0,ductLength/2])cube([ctrlWidth,fanHeight+2*thickness,ctrlNotch],center=true);
        translate([thickness,fanHeight/2-bottomNotch/2+thickness,ductLength/2])cube([ctrlWidth,bottomNotch,ctrlNotch],center=true);
        
    }
    
    translate([ctrlWidth/2,fanHeight/2-bottomNotch/2-thickness,sideLength/2])screwFlap();

}

ACS180();

