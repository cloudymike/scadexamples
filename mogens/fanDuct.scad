use <outlet.scad>
use <controller.scad>
use <duct.scad>


thickness=wallThickness();
height=controllerHeight();



module fanDuct(
    dL=50,
    dH=80,
    dD=110,
)
{
union()
{
    // Use a function call to get this number later
    outletH=ringHeight();
    OutletD=outletD();
    outX=dD/2-OutletD/2-2;
    translate([0,35,27/2-dH/2])controller(depth=dD);
    translate([0,-dL/2,0])duct(length=dL,ductHeight=dH,ductDepth=dD,outX=outX);
    translate([outX,-(dL+outletH/2),0])rotate([90,90,0])budOutlet();
}

}


difference(){
    fanDuct(dH=30,dD=40);
    translate([0,105,0])cube([200,200,200],center=true);
    translate([0,-105,0])cube([200,200,200],center=true);}

//fanDuct();
