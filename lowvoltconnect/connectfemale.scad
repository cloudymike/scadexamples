// connectors that can use contacts for Molex 093 connectors
// two contact versions

//$fn=24;

use <bolt.scad>
use <molex.scad>

$fa = 1;
$fs = 0.1;

delta=1;  // for making surfaces non-coincident
//difference() {
connectfemalepin(
    recepBodyHeight = 26.1, // height of overall body
    femaleDepth=8,
    femaleDiameter=11,
    femaleWallThichness=1.1,
    polaritythickness=3,
    boltedgetocontacttop=5,
    cylinderhole=14
);
//translate([-7,0,0])cube([20,40,50]);}


module connectfemalepin(
    recepBodyHeight = 26.1, // height of overall body
    femaleDepth=8,
    femaleDiameter=11,
    femaleWallThichness=1.1,
    polaritythickness=3,
    boltedgetocontacttop=5,
    cylinderhole=14
)
{

    recepBodyXwidth = 13.5;
    recepBodyYwidth = 6.3; 
    recepPin1toEdge = 3.6;
    earZcenterline = 22;
    earFlatZwidth = 1.8;
    earTotalZwidth = 5.6;
    earXwidth = 2.5;
    earYwidth = 7.3;
    contactHoleBackDiam = 5.2;
    contactHoleBackTaperDiam = 4;
    contactHoleBackTaperStartZ = 6;
    contactHoleBackTopZ = 12.3;
    contactHoleMidDiam = 3.3;
    contactHoleFrontDiam = 4;
    contactHoleFrontDepth = 10.7;
    contactCenterToCenter = 5.5;
    
    plugBodyHeight = 25.4; // height of overall body
    plugBodyXwidth = 16.3;
    plugBodyYwidth = 9;
    plugShroudWallWidth = 1.2;
    plugFaceZ = 15.7;
    plugBackXwidth = 6.6;
    recepClearance = 0.3;
    plugXcenterline = plugBodyXwidth/2;
    
    plugPin1toEdge = 5.5;
    
    plugLatchSlotHeight = 21.8;
    plugLatchSlotWidth = 3.4 ;
    boltheight=12;
    ringheight=recepBodyHeight+boltedgetocontacttop-boltheight+2;
    slotheight=5;


    difference()
    {
        union()
        {
         translate([contactCenterToCenter/2,0,recepBodyHeight/2])
           difference(){ 
            cylinder(d=femaleDiameter,h=recepBodyHeight,center=true);
            rotate([0,0,90])translate([-femaleDiameter/2,0,recepBodyHeight/2-slotheight/2]) cube([4,femaleDiameter,slotheight],center=true);
            }
         
         translate([contactCenterToCenter/2,0,recepBodyHeight-boltedgetocontacttop])
            lowvoltagebolt( threadDiameter=17.3,cableHole=14,outsideHeight=boltheight);
         translate([contactCenterToCenter/2,0,ringheight/2])
            ring(din=femaleDiameter, dout=16, height=ringheight);
         
        }  
            
        sockets(recepBodyHeight=recepBodyHeight);
    }
}

module ring(din,dout,height)
{
    difference() {
        cylinder(d=dout,h=height,center=true);
        cylinder(d=din,h=height,center=true);
    }
}

