
thickness=1;

function ringHeight() = 10;
function outerD() = 54.8;
function outletD()= outerD()-2*thickness;

module outlet()
{

    notchX=6;
    notchY=1;
    notchz=1.6;
    notchOffset=0;
    
    
    difference()
    {
        cylinder(h=ringHeight(),d=outerD(),center=true, $fn=128);
        cylinder(h=ringHeight(),d=outletD(),center=true, $fn=128);       
    }
    translate([0,outerD()/2-thickness/2,notchOffset])cube([notchX,thickness,notchz],center=true);
    translate([0,outerD()/2+notchY/2,notchOffset])cube([notchX,notchY,notchz],center=true);

    translate([0,-outerD()/2+thickness/2,notchOffset])cube([notchX,thickness,notchz],center=true);
    translate([0,-outerD()/2-notchY/2,notchOffset])cube([notchX,notchY,notchz],center=true);
}



outlet();