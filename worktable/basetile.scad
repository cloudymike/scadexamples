
// Current data: 22h and 240g of PLA

use <../threads/isothreads.scad>
use <phillips.scad>

$fa = 1;
$fs = 0.4;

module dovetile(
    //Box Width in units
    BoxWidthUnits = 2,
    //Box Length in units
    BoxLengthUnits = 2,
    //Box Height in mm
    BoxHeight = 16,
    //Box Floor Thickness in mm
    BoxFloor = 16,
    //North Wall open or closed
    NorthWallOpen = 0, // [0:Closed, 1:Open]
    //South Wall open or closed
    SouthWallOpen = 0, // [0:Closed, 1:Open]
    //Add dove tails to side
    north=true,east=true,south=true,west=true
)
{
echo(version=version(2.0));
//comments: Version 2 adds anti-"elephant foot" scaling at bottom of dovetail sections
/* [Size] */
//Box unit size in mm. This defines the size of 1 'unit' for your box.
BoxUnits = 100;
BoxWidth = BoxWidthUnits * BoxUnits;
BoxLength = BoxLengthUnits * BoxUnits;
//Box Wall Thickness in mm
BoxWall = 1;
//Fit Factor. Greater factor = looser fit
FitFactor = 0.18;  // [0:0.05:0.4]
//RoundedBottom = "EW"; // [EW:East-West, NS:North-South]
RoundedBottom = ""; // [EW:East-West, NS:North-South]

/* [Walls] */

/* [Dovetail] */
//Dovetail inside length in mm
DTInsideLength = 10.5;
//Dovetail angle in degrees
DTAngle = 45;
//Dovetail width in mm
DTWidth = 7.5;

/* [Hidden] */
//This helps calculate the length of the 'long' side of the dovetail
DTx=tan(DTAngle)*DTWidth;
//This polygon defines the dovetail shape
DTShape = [[0,0],[DTInsideLength/2,0],[DTInsideLength/2+DTx,DTWidth],[-DTInsideLength/2-DTx,DTWidth],[-DTInsideLength/2,0]];



union(){

    //Creates main box,without round bottom
    difference(){
        
    union(){
        //main box
    cube([BoxLength,BoxWidth,BoxHeight], center=false);

    //male dovetails
    if (north)
    {
    for (i=[1:BoxLengthUnits])
    translate([(i-1)*BoxUnits+(BoxUnits/2),BoxWidth,0])
        //in 2 sections. first section is slightly scaled down to counter "elephant foot"
        union(){
            linear_extrude(height=1, center=false)
                scale([1-(2*FitFactor),1-(2*FitFactor),1])
                union(){        
                    //this adds a slight offset to the male dovetail for a looser fit
                    translate([-DTInsideLength/2,0,0])
                    square([DTInsideLength,DTWidth]);
                    //main dovetail shape
                    translate([0,DTWidth*FitFactor*2,0])
                    polygon(DTShape);
                };
            translate([0,0,1])
            linear_extrude(height=BoxHeight-1, center=false)
                    union(){
                    //this adds a slight offset to the male dovetail for a looser fit
                    translate([-DTInsideLength/2,0,0])
                    square([DTInsideLength,DTWidth]);
                    //main dovetail shape
                    translate([0,DTWidth*FitFactor*2,0])
                    polygon(DTShape);
                    };
        }        
      }
    if (west)
    {
    for (i=[1:BoxWidthUnits])
    translate([0,(i-1)*BoxUnits+(BoxUnits/2),0])
        //in 2 sections. first section is slightly scaled down to counter "elephant foot"
        rotate([0,0,90])
        union(){
            linear_extrude(height=1, center=false)				//1mm high anti-elephant foot section
                scale([1-(2*FitFactor),1-(2*FitFactor),1])
                union(){        
                    //this adds a slight offset to the male dovetail for a looser fit
                    translate([-DTInsideLength/2,0,0])
                    square([DTInsideLength,DTWidth]);
                    //main dovetail shape
                    translate([0,DTWidth*FitFactor*2,0])
                    polygon(DTShape);
                };
            translate([0,0,1])
            linear_extrude(height=BoxHeight-1, center=false)
                union(){
                    //male dovetail offset
                    translate([-DTInsideLength/2,0,0])
                    square([DTInsideLength,DTWidth]);
                    //main dovetail shape
                    translate([0,DTWidth*FitFactor*2,0])
                    polygon(DTShape);
                };
        }
    }
  }
    //female dovetails
    if (south)
    {
    for (i=[1:BoxLengthUnits])
        union(){
            translate([(i-1)*BoxUnits+(BoxUnits/2),0,0])
                scale([1+FitFactor,1+FitFactor,1])
                linear_extrude(height=BoxHeight, center=false)
                polygon(DTShape);
        
            //added a second dovetail cutout at the bottom, scaled up to counter "elephant foot" when printed
            translate([(i-1)*BoxUnits+(BoxUnits/2),0,0])
                scale([1+(3*FitFactor),1+(3*FitFactor),1])
                linear_extrude(height=1, center=false)
                polygon(DTShape);					
        }
      }
    if (east)
    {
    for (i=[1:BoxWidthUnits])
        union(){
            translate([BoxLength,(i-1)*BoxUnits+(BoxUnits/2),0])
                rotate([0,0,90])
                    scale([1+FitFactor,1+FitFactor,1])
                        linear_extrude(height=BoxHeight, center=false)
                            polygon(DTShape);
            //added a second dovetail cutout at the bottom, scaled up to counter "elephant foot" when printed
            translate([BoxLength,(i-1)*BoxUnits+(BoxUnits/2),0])
                rotate([0,0,90])
                    scale([1+(3*FitFactor),1+(3*FitFactor),1])
                        linear_extrude(height=1, center=false)
                            polygon(DTShape);	
        }
      }
    //carves out main box
    translate([BoxWall,DTWidth+BoxWall,BoxFloor])
        cube([BoxLength-(2*BoxWall)-DTWidth, (BoxWidth-(2*BoxWall)-DTWidth), BoxHeight]);

    if (NorthWallOpen)
        translate([-DTWidth*(1+FitFactor+FitFactor),BoxWall+DTWidth,BoxFloor])
            cube([BoxWall+(DTWidth*(1+FitFactor+FitFactor)), (BoxWidth-(2*BoxWall)-DTWidth), BoxHeight]);    

    if (SouthWallOpen)
        translate([BoxLength-(BoxWall)-DTWidth,BoxWall+DTWidth,BoxFloor])
            cube([BoxWall+DTWidth, (BoxWidth-(2*BoxWall)-DTWidth), BoxHeight]);

    }
  }
}

module basetile(north=true,east=true,south=true,west=true) {
  
  //This needs to be broken out as variables
  tilecountx=2;
  tilecounty=2;
  tilez=16;
  
  tilex = tilecountx * 105;
  tiley = tilecounty * 105;
  
  //Fit the rod
  holediameter=6.7;
  
  //For enough strength, and also matching Cura wall
  //Start with cura wall size
  curawalltopbottom=0.8;
  curainternalwall=0.4;
  wallmin=curawalltopbottom+curainternalwall;
  
  tileheight=tilez;
  
  //Offset holes to match wallmin from top/bottom wall
  holeoffset=tileheight/2-holediameter/2-wallmin;

  thread_size=1;
  pitch = 4;
  screwlength = 16;

  difference () {
    dovetile(tilecountx,tilecounty,tileheight,tileheight,0,0,north,east,south,west);
    translate([tilex/2,tiley/2,tilez/2+holeoffset]) rotate([90,0,0]) cylinder(d=holediameter,h=tilex,center=true);
    translate([tilex/2,tiley/2,tilez/2-holeoffset]) rotate([90,0,90]) cylinder(d=holediameter,h=tiley,center=true);
    if (!south) {
      translate([tilex/2,screwlength*2,tilez/2+holeoffset]) rotate([90,0,0]) metric_thread(diameter=holediameter+thread_size,pitch=pitch,length=tileheight*2,internal=true);
    }
    if (!north) {
      translate([tilex/2,tiley+6-screwlength,tilez/2+holeoffset]) rotate([90,0,0]) metric_thread(diameter=holediameter+thread_size,pitch=pitch,length=tileheight*2,internal=true);
    }
    if (!east) {
      translate([tilex/2,screwlength*2,tilez/2+holeoffset]) rotate([90,0,0]) metric_thread(diameter=holediameter+thread_size,pitch=pitch,length=tileheight*2,internal=true);
    }
    if (!west) {
      translate([tilex/2,tiley+6-screwlength,tilez/2+holeoffset]) rotate([90,0,0]) metric_thread(diameter=holediameter+thread_size,pitch=pitch,length=tileheight*2,internal=true);
    }
  }
}



module screwrod () {
  difference () {
    metric_thread(diameter=holediameter+thread_size,thread_size=thread_size, pitch=4,length=screwlength/2,internal=false);
    translate([0,0,4.5]) phillipsDrive(2);
  }
}

basetile(true,true,true,true);
