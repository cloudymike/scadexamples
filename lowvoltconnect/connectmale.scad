// connectors that can use contacts for Molex 093 connectors
// two contact versions

use <molex.scad>

$fa = 1;
$fs = 0.1;

delta=1;  // for making surfaces non-coincident


//difference() {
connectmalepin(
    recepBodyHeight = 15.7, // height of overall body
    femaleDepth=8,
    femaleDiameter=11,
    femaleWallThichness=1.1,
    ringdiameter=15,
    polaritythickness=3
);


//translate([0,5,0]) cube([100,10,100],center=true); }


module connectmalepin(
    recepBodyHeight = 26.1, // height of overall body
    femaleDepth=5.25,
    femaleDiameter=12,
    femaleWallThichness=1.5,
    ringdiameter=16,
    polaritythickness=1
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
    
    femaleOuterDiameter = femaleDiameter+2*femaleWallThichness;
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
    





    difference()
    {
       union () {
         //translate([-recepPin1toEdge,-recepBodyYwidth/2,0]) cube([recepBodyXwidth,recepBodyYwidth,recepBodyHeight],center=false);  
        translate([contactCenterToCenter/2,0,recepBodyHeight])
            cylinder(d=ringdiameter, h=2, center=true);
        translate([contactCenterToCenter/2,0,recepBodyHeight/2]) 
            cylinder(d=femaleOuterDiameter,h=recepBodyHeight,center=true);
        translate([contactCenterToCenter/2,0,recepBodyHeight+femaleDepth/2]) 
           difference () {
               cylinder(d=femaleOuterDiameter,h=femaleDepth,center=true);
               cylinder(d=femaleDiameter,h=femaleDepth+0.01,center=true);
           }

        //polarity marker
        translate([contactCenterToCenter/2,femaleDiameter/2-polaritythickness/4,recepBodyHeight+femaleDepth/2])
            cube([femaleDiameter*0.6,polaritythickness-femaleWallThichness,femaleDepth],center=true);
       }
       
       // Contact pins
       pins(recepBodyHeight=recepBodyHeight);

   }

}


