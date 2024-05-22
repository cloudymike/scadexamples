
function selector(item, dict) = dict[search([item], dict)[0]][1];


//Thread=Clearance hole;
ClearanceD = [
  ["M1", 1.2],
  ["M1.2", 1.4],
  ["M1.4", 1.6],
  ["M1.6", 1.8],
  ["M1.8", 2],
  ["M2", 2.4],
  ["M2.2", 2.8],
  ["M2.5", 2.9],
  ["M3", 3.4],
  ["M3.5", 3.9],
  ["M4", 4.5],
  ["M5", 5.5],
  ["M6", 6.6],
  ["M8", 9],
  ["M10", 11],
  ["M12", 13.5],
  ["M14", 15.5],
  ["M16", 17.5],
  ["M18", 20],
  ["M20", 22],
  ["M22", 24],
  ["M24", 26],
  ["M27", 30],
  ["M30", 33]
];

wall=1;

//Create a test hole with a wall of "wall" size
// Make the hole 0.5 mm shorter than actual screw to make scre just bottom out.
module oldTestHole(Msize, length, height)
{
  HoleD=selector(Msize, ClearanceD);
  difference() {
    translate([0,0,height/2])cylinder(h=height,d=HoleD+2*wall,center=true, $fn=64);
    translate([0,0,TopLevel(length, height)+0.5]) cylinder(h=length,d=HoleD,center=true, $fn=64);
  }
}

//Create a test hole with a wall of "wall" size
// Make the hole 0.5 mm shorter than actual screw to make scre just bottom out.
module TestHole(Msize, length, height)
{
  HoleD=selector(Msize, ClearanceD);
  h=height-5;
  difference() {
    translate([0,0,TopLevel(h,height)])cylinder(h=h,d=HoleD+2*wall,center=true, $fn=64);
    translate([0,0,TopLevel(length, height)+0.5]) cylinder(h=length,d=HoleD,center=true, $fn=64);
  }
}

//Create a test hole with a wall of "wall" size
// Make the hole 0.5 mm shorter than actual screw to make scre just bottom out.
module clearanceCylinder(Msize, length, height)
{
  HoleD=selector(Msize, ClearanceD);
  translate([0,0,TopLevel(length, height)+0.5]) cylinder(h=length,d=HoleD,center=true, $fn=64);
}

module wallCylinder(Msize, length, height)
{
  HoleD=selector(Msize, ClearanceD);
  h=height-5;
  translate([0,0,TopLevel(h,height)])cylinder(h=h,d=HoleD+2*wall,center=true, $fn=64);
}

//Create a cylinder slightly smaller than test hole to allow a cutout in existing module
module TestHoleCutout(Msize, length, height)
{
  HoleD=selector(Msize, ClearanceD);
  translate([0,0,TopLevel(length, height)])cylinder(h=length,d=HoleD+2*wall-0.1,center=true, $fn=64);
}

//Calculate Z position based on top of existing module and length of test screw
function TopLevel(length, currentTop) = currentTop-length/2;
function sideOffset(Msize) = (selector(Msize, ClearanceD)+2*wall)/2;

// Test and example of usage. The test cube is assumed to be an existing module.
testType="M3";
testLength=12;
testCubeSize=20;
xPos=testCubeSize/2;
yPos=testCubeSize/2;

//difference () {
//  cube([testCubeSize,testCubeSize,testCubeSize]);
//  translate([xPos,yPos,0])TestHoleCutout(testType,testLength, testCubeSize);
//}
translate([xPos,yPos,0])TestHole(testType,testLength,testCubeSize);
