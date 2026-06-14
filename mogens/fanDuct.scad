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
    ABBbacktab=8;

    translate([0,-dL/2,0])splitDuct(length=dL,ductHeight=dH,ductDepth=dD,outX=outX, outZ=outZ,top="flat", splitSide=splitSide);

    if (splitSide!="outlet")
        translate([0,controllerWidth()/2,controllerHeight()/2-dH/2])controller(depth=dD);

    if (splitSide!="controller")
        translate([outX,-(dL+outletH/2),outZ])rotate([90,0,0])budOutlet();

    //Screw tabs
    translate([-ABBbacktab-dD/2,controllerWidth(),0-dH/2+controllerHeight()/2])rotate([90,0,90])screwtab();
    tab2height=ABBbacktab+tabCut()+10;
    //translate([-dD/2-ABBbacktab,-dL+thickness,0])rotate([-90,0,-90])screwtab(tab2height);
    translate([-dD/2-ABBbacktab,-dL/2,dH/2-thickness])rotate([0,-90,180])screwtab(tab2height);
}

difference(){
fanDuct(
    totalDuctLengthL=50,
    dH=200,
    dD=80,
    splitSide="None"
);
//    translate([-50,0,110])cube([200,200,200],center=true);
}

/*
fanDuct(
    totalDuctLengthL=50,
    dH=200,
    dD=80,
    splitSide="None"
);
*/