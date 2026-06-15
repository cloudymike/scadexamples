use <outlet.scad>
use <controller.scad>
use <duct.scad>
use <screwtab.scad>

// Experimental, try turn outlet 2 degrees
turnOutlet=false;

thickness=wallThickness();
height=controllerHeight();



module fanDuct(
    totalDuctLengthL=50, // Including Ring
    dH=80,
    dD=110,
    splitSide="None"
)
{
    dL=totalDuctLengthL-ringHeight();
    outletH=ringHeight();
    OutletD=outletD();
    outX=dD/2-OutletD/2-thickness;
    outZ=dH/2-OutletD/2-thickness;
    ABBbacktab=8;

    translate([0,-dL/2,0])splitDuct(length=dL,ductHeight=dH,ductDepth=dD,outX=outX, outZ=outZ,top="flat", splitSide=splitSide);

    if (splitSide!="outlet")
        translate([0,controllerWidth()/2,controllerHeight()/2-dH/2])controller(depth=dD);

    if (splitSide!="controller")
        if (turnOutlet)
        {
            difference ()
            {
                // Outlet with 2 degrees turn
                translate([outX,-(dL+outletH/2)+1,outZ])rotate([90,0,-2])budOutlet();
                //Shave off ring to get aligned with bottom
                translate([outX+OutletD/2+thickness+1,0,0])cube([2,200,200],center=true);
            }
            //support strip
            translate([outX+OutletD/2+thickness/2,-(dL+outletH/2),outZ])cube([thickness,outletH,0.2],center=true);
        }
        else
           translate([outX,-(dL+outletH/2),outZ])rotate([90,0,0])budOutlet();

    //Screw tabs
    translate([-ABBbacktab-dD/2,controllerWidth(),0-dH/2+controllerHeight()/2])rotate([90,0,90])screwtab();
    tab2height=ABBbacktab+tabCut()+10;
    translate([-dD/2-ABBbacktab,-dL/2,dH/2-thickness])rotate([0,-90,180])screwtab(tab2height);
}

difference(){
fanDuct(
    totalDuctLengthL=60,
    dH=190,
    dD=80,
    splitSide="None"
);
    translate([-80,0,0])cube([200,400,400],center=true);
    translate([0,0,-180])cube([400,400,400],center=true);
}

/*
fanDuct(
    totalDuctLengthL=50,
    dH=200,
    dD=80,
    splitSide="None"
);
*/