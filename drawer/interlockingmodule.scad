

//this section defines a module for creating a "rounded" bottom to the box, useful when storing small parts
module RoundBottom(width, length, height){    
    translate([0,length,0])rotate([90,0,0])
    linear_extrude(length, center=false)
    
    difference() {
        translate([-width/2,0,0])square([width,height/2],center=false);
        translate([0,height/2,0])resize([width,height]) circle(d=width*10);
    }
}


module interlockingbox(
    //Box Width in units
    BoxWidthUnits = 3,
    //Box Length in units
    BoxLengthUnits = 3,
    //Box Height in mm
    BoxHeight = 120,
    //Box Floor Thickness in mm
    BoxFloor = 2,
    //North Wall open or closed
    NorthWallOpen = 0, // [0:Closed, 1:Open]
    //South Wall open or closed
    SouthWallOpen = 0 // [0:Closed, 1:Open]
)
{
echo(version=version(2.0));
//comments: Version 2 adds anti-"elephant foot" scaling at bottom of dovetail sections
/* [Size] */
//Box unit size in mm. This defines the size of 1 'unit' for your box.
BoxUnits = 40;
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
DTInsideLength = 1.1;
//Dovetail angle in degrees
DTAngle = 45;
//Dovetail width in mm
DTWidth = 1.5;

/* [Hidden] */
//This helps calculate the length of the 'long' side of the dovetail
DTx=tan(DTAngle)*DTWidth;
//This polygon defines the dovetail shape
DTShape = [[0,0],[DTInsideLength/2,0],[DTInsideLength/2+DTx,DTWidth],[-DTInsideLength/2-DTx,DTWidth],[-DTInsideLength/2,0]];



union(){
    //creates and transforms rounded bottom
    if (RoundedBottom=="EW") {
    translate([0,(BoxWidth/2)+BoxWall,BoxFloor])
    rotate([0,0,-90])
    RoundBottom(BoxWidth-DTWidth-(BoxWall),BoxLength-DTWidth-BoxWall,2*(BoxHeight-BoxFloor));
    }

    //creates rounded bottom oriented North-South
    if (RoundedBottom=="NS") {
    translate([(BoxLength/2)-BoxWall,DTWidth+BoxWall/2,BoxFloor])
    rotate([0,0,0])
    RoundBottom(BoxLength-DTWidth-(BoxWall),BoxWidth-DTWidth-BoxWall,2*(BoxHeight-BoxFloor));
    }

    //Creates main box,without round bottom
    difference(){
        
    union(){
        //main box
    cube([BoxLength,BoxWidth,BoxHeight], center=false);

        //male dovetails
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
    //female dovetails
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

// Cutout to make sure the actual box with groves is properly printed
// Use this with difference() to remove trim internal to fit the box.
module negativeBox(
    //Box Width in units
    BoxWidthUnits = 3,
    //Box Length in units
    BoxLengthUnits = 3,
    //Box Height in mm
    BoxHeight = 120,
    //Box unit size in mm. This defines the size of 1 'unit' for your box.
    BoxUnits = 40,
)
{
    difference () {
        translate([-5,-3,0])
        cube([BoxLengthUnits*BoxUnits+8,BoxWidthUnits*BoxUnits+8,BoxHeight]);

    translate([0.5,2,0])
        cube([BoxLengthUnits*BoxUnits-2.5,BoxWidthUnits*BoxUnits-2.5,BoxHeight]);
    }
}

interlockingbox(2,3,40);

// This will create a sliver of a wall if working properly
//difference() {
//    interlockingbox(2,3,40);
//    negativeBox(2,3,40);
//}