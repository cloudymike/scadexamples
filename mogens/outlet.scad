
thickness=1;

function ringHeight() = 22;
function outerD() = 54.8;
function outletD()= outerD()-2*thickness;

module budOutlet()
{

    notchX=6;
    notchY=1;
    notchz=1.6;
    notchOffset=ringHeight()/2-5;
    
    
    difference()
    {
        cylinder(h=ringHeight(),d=outerD(),center=true, $fn=128);
        cylinder(h=ringHeight(),d=outletD(),center=true, $fn=128);       
    }
    
    //Notches
    //translate([0,outerD()/2-thickness/2,notchOffset])cube([notchX,thickness,notchz],center=true);
    //translate([0,outerD()/2+notchY/2,notchOffset])cube([notchX,notchY,notchz],center=true);

    //translate([0,-outerD()/2+thickness/2,notchOffset])cube([notchX,thickness,notchz],center=true);
    //translate([0,-outerD()/2-notchY/2,notchOffset])cube([notchX,notchY,notchz],center=true);
}



module louveredOutlet()
{
    tabringD=54.5;
    tabThick=1;
    tubeD = 51;
    tubeHeight = ringHeight();
    innerD = tubeD-2*thickness;
    narrowHeight=5;
    difference()
    {
        union()
        {
            // tab ring
            translate([0,0,-tubeHeight/2+tabThick/2])cylinder(h=tabThick,d=tabringD,center=true, $fn=128);
            //match standard ring, not needed but nice
            translate([0,0,(tubeHeight-narrowHeight)/2])cylinder(h=tubeHeight-narrowHeight,d=outerD(),center=true,$fn=128);
            // The main tube
            cylinder(h=tubeHeight,d=tubeD,center=true, $fn=128);
        }
        cylinder(h=tubeHeight,d=innerD,center=true, $fn=128);
        translate([0,0,-tubeHeight/2+tabThick/2])cube([tabringD,20,tabThick],center=true);
    }
}


module outlet(style="bud")
{
    if (style=="bud")
        budOutlet();
    else
        louveredOutlet();
}

outlet();