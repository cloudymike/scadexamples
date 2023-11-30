// connectors that can use contacts for Molex 093 connectors
// two contact versions

//$fn=24;

$fa = 1;
$fs = 0.1;

delta=1;  // for making surfaces non-coincident

//translate([0,0,0]) receptacle();

//translate([0,20,0]) plug();

// pin 1 at the origin


/*  cross sections for checking clearances*/ 
/*
projection(cut = true)   
rotate([90,0,0]) 
union() { receptacle();  translate([0,0,42]) rotate([180,0,0]) plug();
    
    translate([30,-3,0]) rotate([0,0,90]) 
    union(){ receptacle();  translate([0,0,42]) rotate([180,0,0]) plug(); }
        
            translate([60,0,0]) rotate([0,0,90]) 
    union(){ receptacle();  translate([0,0,42]) rotate([180,0,0]) plug();}
        
    } */



//difference() {
lowvoltrecep(
    recepBodyHeight = 15.7, // height of overall body
    femaleDepth=8,
    femaleDiameter=11,
    femaleWallThichness=1.1,
    ringdiameter=15,
    polaritythickness=3
);


//translate([0,5,0]) cube([100,10,100],center=true); }


module lowvoltrecep(
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





module outerCircularBevelCutter(d,b)  // improved
{
  difference()  {
   translate([0,0,-delta/2]) cylinder(d=d+delta*2,h=b+1*delta);
   translate([0,0,-1*delta]) cylinder(d1=d-2*b-2*delta,d2=d+2*delta, h=b+2*delta);
  }
};

module outerRectangleBevelCutter(l,w,b)
{ // 
  polyhedron(
    points=[ [l/2+b,w/2+b,2*b],[l/2-2*b,w/2-2*b,-b],[l/2+b,w/2+b,-b],
             [-l/2-b,w/2+b,2*b],[-l/2+2*b,w/2-2*b,-b],[-l/2-b,w/2+b,-b],
             [-l/2-b,-w/2-b,2*b],[-l/2+2*b,-w/2+2*b,-b],[-l/2-b,-w/2-b,-b],
            [l/2+b,-w/2-b,2*b],[l/2-2*b,-w/2+2*b,-b],[l/2+b,-w/2-b,-b] ],
    faces = [  [0,3,2],  [3,5,2],  [2,5,4],   [2,4,1],  [1,4, 0], [0,4,3] 
              ,[3,6,5],  [6,8,5],  [5,8,7],   [5,7,4],  [4,7, 3], [3,7,6] 
              ,[6,9,8],  [9,11,8], [8,11,10], [8,10,7], [7,10,6], [6,10,9] 
              ,[9,0,11], [0,2,11], [11,2,1],  [11,1,10], [10,1,9], [9,1,0] ] ); 
};


module innerRectangleBevelCutter(l,w,b)
{ // 
  polyhedron(
    points=[ [l/2-b,w/2-b,2*b],[l/2-b,w/2-b,-b],[l/2+2*b,w/2+2*b,-b],
             [-l/2+b,w/2-b,2*b],[-l/2+b,w/2-b,-b],[-l/2-2*b,w/2+2*b,-b],
             [-l/2+b,-w/2+b,2*b],[-l/2+b,-w/2+b,-b],[-l/2-2*b,-w/2-2*b,-b],
            [l/2-b,-w/2+b,2*b],[l/2-b,-w/2+b,-b],[l/2+2*b,-w/2-2*b,-b] ],
    faces = [  [0,3,2],  [3,5,2],  [2,5,4],   [2,4,1],  [1,4, 0], [0,4,3] 
              ,[3,6,5],  [6,8,5],  [5,8,7],   [5,7,4],  [4,7, 3], [3,7,6] 
              ,[6,9,8],  [9,11,8], [8,11,10], [8,10,7], [7,10,6], [6,10,9] 
              ,[9,0,11], [0,2,11], [11,2,1],  [11,1,10], [10,1,9], [9,1,0] ] ); 
};


module sockets(
  recepBodyHeight=26.1
) {
    contactHoleBackDiam = 5.2;
    contactHoleBackTaperDiam = 4;
    contactHoleBackTaperStartZ = 6;
    contactHoleBackTopZ = 12.3;
    contactHoleMidDiam = 3.3;
    contactHoleFrontDiam = 4;
    contactHoleFrontDepth = 10.7;
    contactCenterToCenter = 5.5;
       for (i=[[0,0],[0+contactCenterToCenter,0.01]])
            union()
            {
                difference()
                {
                    intersection()  //  back part of contact hole is tapered from 5.2 at z=6 to 4 at z=12.3
                    {   // make taper by intersection cylinder with cone
                        translate([i[0],i[1],-delta]) cylinder(d=contactHoleBackDiam,h=contactHoleBackTopZ+delta);
                        translate([i[0],i[1],-delta]) cylinder(d2=contactHoleBackTaperDiam,d1=contactHoleBackTaperDiam+(contactHoleBackDiam-contactHoleBackTaperDiam)*(contactHoleBackTopZ+delta)/(contactHoleBackTopZ-contactHoleBackTaperStartZ),h=contactHoleBackTopZ+delta);
                    } // intersection
                    translate([i[0],i[1],contactHoleBackTopZ]) rotate([180,0,0])
                        outerCircularBevelCutter(contactHoleBackDiam,(contactHoleBackDiam-contactHoleBackTaperDiam)*0.7);  // bevel to help overhang
                }  // difference
                // center part of contact hole, performs locking function
                translate([i[0],i[1],contactHoleBackTopZ-delta]) cylinder(d=contactHoleMidDiam,h=recepBodyHeight-contactHoleBackTopZ-contactHoleFrontDepth+2*delta);
                translate([i[0],i[1],recepBodyHeight-contactHoleFrontDepth]) cylinder(d=contactHoleFrontDiam,h=contactHoleFrontDepth+delta);        
            } // union  (also end of for loop)
        
        
}


module pins(
  recepBodyHeight=26.1
)
{
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
        // holes for contacts
        for (i=[[0,0],[0+contactCenterToCenter,0]])
            union()
            {
                difference()
                {
                    intersection()  //  back part of contact hole is tapered from 5.2 at z=6 to 4 at z=12.3
                    {   // make taper by intersection cylinder with cone
                        translate([i[0],i[1],(plugFaceZ-3.4-contactHoleBackTopZ)-delta]) cylinder(d=contactHoleBackDiam,h=contactHoleBackTopZ+delta);
                        translate([i[0],i[1],(plugFaceZ-3.4-contactHoleBackTopZ)-delta]) cylinder(d2=contactHoleBackTaperDiam,d1=contactHoleBackTaperDiam+(contactHoleBackDiam-contactHoleBackTaperDiam)*(contactHoleBackTopZ+delta)/(contactHoleBackTopZ-contactHoleBackTaperStartZ),h=contactHoleBackTopZ+delta);
                    } // intersection
                    translate([i[0],i[1],plugFaceZ-3.4]) rotate([180,0,0])
                        outerCircularBevelCutter(contactHoleBackDiam,(contactHoleBackDiam-contactHoleBackTaperDiam)*0.7);  // bevel to help overhang
                }  // difference
                // center part of contact hole, performs locking function  axial length 3.4
                
                translate([i[0],i[1],plugFaceZ-3.4/2]) cylinder(d=contactHoleMidDiam,h=3.4+2*delta,center=true);        
            } // union  (also end of for loop)        
    
    
    
}


