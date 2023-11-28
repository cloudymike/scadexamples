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




lowvoltrecep(
    recepBodyHeight = 26.1, // height of overall body
    femaleDepth=8,
    femaleDiameter=11,
    femaleWallThichness=1.1,
    ringdiameter=15,
    polaritythickness=3
);




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
}

















module plug()
{
    difference()
    {
        translate([-plugPin1toEdge+plugBodyXwidth/2,0,plugBodyHeight/2]) cube([plugBodyXwidth ,plugBodyYwidth,plugBodyHeight],center=true);
        
        union()  // cutter 
        {
            difference()   // for cavity in shroud
            {
                translate([recepBodyXwidth/2-recepPin1toEdge,0,plugFaceZ+ (plugBodyHeight-plugFaceZ)/2+ delta/2])
                    cube([recepBodyXwidth+recepClearance*2,recepBodyYwidth+recepClearance*2,(plugBodyHeight-plugFaceZ)+delta],center=true);
                // cut out the two 45 degree keying features
                translate([-recepPin1toEdge-recepClearance,-recepBodyYwidth/2-recepClearance,15+20/2]) rotate([0,0,45]) cube([4,8,20],center=true);
                translate([-recepPin1toEdge-recepClearance,recepBodyYwidth/2+recepClearance,15+20/2]) rotate([0,0,-45]) cube([4,8,20],center=true);
    
                // tiny wall between contacts
                translate([contactCenterToCenter/2+0.35,0,plugFaceZ+1/2-delta/2])        cube([0.8,recepBodyYwidth+1,1+delta],center=true); // height  1  width 0.8           
                
            }
            // slots to accomodate the latches on the recep
            translate([contactCenterToCenter/2,plugBodyYwidth/2+4/2-1.3,(plugLatchSlotHeight)/2-delta/2])
                cube([plugLatchSlotWidth,4,plugLatchSlotHeight+delta],center=true);
            translate([contactCenterToCenter/2,-plugBodyYwidth/2-4/2+1.3,(plugLatchSlotHeight)/2-delta/2])
                cube([plugLatchSlotWidth,4,plugLatchSlotHeight+delta],center=true);

        } // union  cutter
        
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
        
        // trim sides
        difference()
            {
         translate([-plugPin1toEdge+plugBodyXwidth/2,0,14.8/2-delta/2]) cube([plugBodyXwidth+2*delta ,plugBodyYwidth+2*delta,14.8+delta],center=true);               
            translate([-recepPin1toEdge,-recepBodyYwidth/2,-delta]) cube([recepBodyXwidth,recepBodyYwidth,14.8+4*delta],center=false);     
            translate([-recepPin1toEdge+recepBodyXwidth/2,0,14.8]) rotate([180,0,0])
                innerRectangleBevelCutter(recepBodyXwidth,recepBodyYwidth,1.4);
    
                difference()
                {
                    union()
                    {
                    // side ribs
                translate([0,0,20/2+6.8]) cube([1.5,20,20],center=true);    
                translate([contactCenterToCenter,0,20/2+6.8]) cube([1.5,20,20],center=true);   
                    } // union
                
                    // trim bottoms of ribs at 45 for printability
                    translate([-recepPin1toEdge+recepBodyXwidth/2,0,6.8-1]) rotate([0,0,0])
                    outerRectangleBevelCutter(recepBodyXwidth,recepBodyYwidth,1.4);
                }  // difference
                
        
            }
        // cut out the two 45 degree keying features
                           translate([-recepPin1toEdge-recepClearance-0.7,-recepBodyYwidth/2-recepClearance-0.7,14.7-1.4+20/2]) rotate([0,0,45]) cube([4,8,20],center=true);
                    translate([-recepPin1toEdge-recepClearance-0.7,recepBodyYwidth/2+recepClearance+0.7,14.7-1.4+20/2]) rotate([0,0,-45]) cube([4,8,20],center=true);    

       // trim point of 45 deg part
             translate([-recepPin1toEdge-3.3,0,14.7+20/2])  cube([4,8,20],center=true);           
            
    }  // difference
    
};



module receptacle()
{
    difference()
    {
        union()
        {
            translate([-recepPin1toEdge,-recepBodyYwidth/2,0]) cube([recepBodyXwidth,recepBodyYwidth,recepBodyHeight],center=false);  // main body
            hull()   // locking ears
            {
                translate([contactCenterToCenter/2,0,earZcenterline]) cube([earXwidth,earYwidth,earFlatZwidth],center=true);
                translate([contactCenterToCenter/2,0,earZcenterline]) cube([earXwidth,earYwidth-(earYwidth-recepBodyYwidth)*1.5,earFlatZwidth+(earTotalZwidth-earFlatZwidth)*1.5],center=true);                    
            }
        } // union 
        // cut out the two 45 degree keying features
        translate([-recepPin1toEdge,-recepBodyYwidth/2,16+20/2]) rotate([0,0,45]) cube([4,8,20],center=true);
        translate([-recepPin1toEdge,recepBodyYwidth/2,16+20/2]) rotate([0,0,-45]) cube([4,8,20],center=true);
        
        // notch between contacts
        translate([contactCenterToCenter/2+0.35,0,recepBodyHeight+4/2-1.3])        cube([1,recepBodyYwidth+1,4],center=true);
        for (i=[[0,0],[0+contactCenterToCenter,0]])
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

