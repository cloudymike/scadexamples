

module outlet()
{
    ringHeight=10;
    outerD=54.8;
    thickness=1;
    innerD=outerD-2*thickness;

    notchX=6;
    notchY=1;
    notchz=1.6;
    notchOffset=0;
    
    
    difference()
    {
        cylinder(h=ringHeight,d=outerD,center=true, $fn=128);
        cylinder(h=ringHeight,d=innerD,center=true, $fn=128);       
    }
    translate([0,outerD/2-thickness/2,notchOffset])cube([notchX,thickness,notchz],center=true);
    translate([0,outerD/2+notchY/2,notchOffset])cube([notchX,notchY,notchz],center=true);

    translate([0,-outerD/2+thickness/2,notchOffset])cube([notchX,thickness,notchz],center=true);
    translate([0,-outerD/2-notchY/2,notchOffset])cube([notchX,notchY,notchz],center=true);
}



outlet();