use <outlet.scad>
use <controller.scad>
use <duct.scad>
use <screwtab.scad>


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

    translate([0,-dL/2,0])splitDuct(length=dL,ductHeight=dH,ductDepth=dD,outX=outX, outZ=outZ,top="flat", splitSide=splitSide);

    if (splitSide!="outlet")
        translate([0,controllerWidth()/2,27/2-dH/2])controller(depth=dD);

    if (splitSide!="controller")
        translate([outX,-(dL+outletH/2),outZ])rotate([90,0,0])budOutlet();

    //Screw tabs
    translate([-8-dD/2,controllerWidth()-screwTabThick()/2,screwTabWidth()/2-dH/2])rotate([90,0,90])screwtab();
    //translate([-8-dD/2,0,0])rotate([0,0,0])screwtab();
}

/*
difference(){
    fanDuct(dH=30,dD=40);
    translate([0,105,0])cube([200,200,200],center=true);
    translate([0,-105,0])cube([200,200,200],center=true);}
*/

difference(){
fanDuct(
    totalDuctLengthL=50,
    dH=190,
    dD=80,
    splitSide="None"
);
//    translate([-50,0,110])cube([200,200,200],center=true);
}

/*
fanDuct(
    totalDuctLengthL=50,
    dH=150,
    dD=110
);
*/