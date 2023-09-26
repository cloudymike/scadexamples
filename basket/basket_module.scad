/**
 * Created by Michał Dziekoński
 *
 * License: Creative Commons (4.0 International License)
Attribution-NonCommercial
 * http://creativecommons.org/licenses/by-nc/4.0/
 *
 **/

// --- Config variables ---

/* [Bin variables] */

// Bin outer dimensions [width, depth, height]
binDimensions = [ 100, 60, 150 ];
// Bin wall size (width)
binWallSize = 7;
// Bin wall thickness
binWallThickness = 5;
// Maximum gap size between two wall pillars (set to 0 to create solid walls)
binMaxGapSize = 15;

/* [(Optional) Screw slots] */
/**
 * If not needed, leave the list empty:
 * screwSlotPositions = []
 *
 * Otherwise, each slot should be defined as X & Y coordinate
 * on the lattice of the wall, 0-indexed.
 * The coordinate represents a "gap" between lattice walls,
 * eg. [ 0, 0 ] means a slot placed at the left-bottom corner of the lattice.
 *
 * Since the lattice divisions are computed based on the dimension parameters, it is necessary to visually determine the X & Y coordinates on the lattice.
 *
 * Defining slot outside of bin's bounding box will return a warning in the console.
 **/
// Screw slots positions (list of [ x, y ] coordinates on the wall)
screwSlotPositions = [
    [ 0, 6 ],
    [ 4, 6 ]
];
// Screw head diameter
screwHeadDiameter = 6;
// Screw thread diameter
screwThreadDiameter = 3;
// Screw tolerance, applied to both head & thread diameters
screwDiametersTolerance = 0.2;

// -- end of "Config variables" --

// -- Helpers --

function calculateDivisionsAndGapWidth(
    latticeDimensions,
    wallSize,
    gapMaxSize
) =
    let (
        width = latticeDimensions.x,
        widthWithoutOneWall = width - wallSize,
        divisionsNo = widthWithoutOneWall / (wallSize + gapMaxSize),
        divisionsNoFinal = ceil(divisionsNo),
        gapCompensation = gapMaxSize - ((width - (wallSize * (1 + divisionsNoFinal))) / divisionsNoFinal),
        gapSizeFinal = gapMaxSize - gapCompensation
    )
    [ divisionsNoFinal, gapSizeFinal ];


module lattice1d(
    dimensions,
    wallSize,
    gapMaxSize
) {    
    computations = calculateDivisionsAndGapWidth(
        dimensions,
        wallSize,
        gapMaxSize
    );
    divisionsNoFinal = computations[0];
    gapSizeFinal = computations[1];
    divisionFinalWidth = wallSize + gapSizeFinal;

    // Rendering
    square([ wallSize, dimensions.y ]);
    for(i = [1:divisionsNoFinal]) {
        translate([ divisionFinalWidth * i, 0 ]) {
            square([ wallSize, dimensions.y ]);
        }
    }
}

module lattice2d(
    dimensions,
    wallSize,
    gapMaxSize
) {
    lattice1d(
        [ dimensions.x, dimensions.y ],
        wallSize,
        gapMaxSize
    );
    
    translate([ dimensions.x, 0, 0 ]) {
        rotate(a = 90) {
            lattice1d(
                [ dimensions.y, dimensions.x ],
                wallSize,
                gapMaxSize
            );
        }
    }
}

module binWall(dimensions, wallSize, gapMaxSize, wallThickness) {
    linear_extrude(height = wallThickness, convexity = 2) {
        lattice2d(dimensions, wallSize, gapMaxSize);
    }
}

module bin(
    dimensions,
    wallSize,
    gapMaxSize,
    wallThickness
) {
    union() {
        binWall([ dimensions.x, dimensions.y ], wallSize, gapMaxSize, wallThickness);

        translate([ 0, wallThickness, 0 ]) {
            rotate([ 90, 0, 0 ]) {
                binWall([ dimensions.x, dimensions.z ], wallSize, gapMaxSize, wallThickness);
            }
        }
        
        translate([ 0, dimensions.y, 0 ]) {
            rotate([ 90, 0, 0 ]) {
                binWall([ dimensions.x, dimensions.z ], wallSize, gapMaxSize, wallThickness);
            }
        }
        
        translate([ wallThickness, 0, 0 ]) {
            rotate([ 0, -90, 0 ]) {
                binWall([ dimensions.z, dimensions.y ], wallSize, gapMaxSize, wallThickness);
            }
        }
        
        translate([ dimensions.x, 0, 0 ]) {
            rotate([ 0, -90, 0 ]) {
                binWall([ dimensions.z, dimensions.y ], wallSize, gapMaxSize, wallThickness);
            }
        }
    }
}

module screwSlot(bodyDimensions, headDiameter, threadDiameter) {
    epsilon = 0.02;
     
    translate([
        bodyDimensions.x / 2,
        bodyDimensions.y + (epsilon / 2),
        bodyDimensions.z / 2
    ]) {
        rotate([ 90, 0, 0 ]) {
            cylinder(
                h = bodyDimensions.y + epsilon,
                d1 = headDiameter,
                d2 = threadDiameter,
                $fn = 360
            ); 
        }
    }
}


module basket (
  // Bin outer dimensions [width, depth, height]
  binDimensions = [ 100, 60, 150 ],
  // Bin wall size (width)
  binWallSize = 7,
  // Bin wall thickness
  binWallThickness = 5,
  // Maximum gap size between two wall pillars (set to 0 to create solid walls)
  binMaxGapSize = 15,
  screwSlotPositions = [
      [ 0, 6 ],
      [ 4, 6 ]
  ],
  // Screw head diameter
  screwHeadDiameter = 6,
  // Screw thread diameter
  screwThreadDiameter = 3,
  // Screw tolerance, applied to both head & thread diameters
  screwDiametersTolerance = 0.2,
)
{
  // -- Rendering --
  
  // Compute offsets
  xOffsetComputations = calculateDivisionsAndGapWidth(
      [ binDimensions.x ],
      binWallSize,
      binMaxGapSize
  );
  xDivisionsNoFinal = xOffsetComputations[0];
  xGapSizeFinal = xOffsetComputations[1];
  xDivisionFinalWidth = binWallSize + xGapSizeFinal;
  
  zOffsetComputations = calculateDivisionsAndGapWidth(
      [ binDimensions.z ],
      binWallSize,
      binMaxGapSize
  );
  zDivisionsNoFinal = zOffsetComputations[0];
  zGapSizeFinal = zOffsetComputations[1];
  zDivisionFinalWidth = binWallSize + zGapSizeFinal;
  
  if (len(screwSlotPositions) > 0) {
      for (screwSlotPosition = screwSlotPositions) {
          if (
              screwSlotPosition.x >= xDivisionsNoFinal ||
              screwSlotPosition.y >= zDivisionsNoFinal
          ) {
              echo(str("[WARN] Detected screw slot outside of bin's dimensions [", screwSlotPosition.x, ", ", screwSlotPosition.y, "]"));
          }
      }
  }
  
  difference() {
      union() {
          bin(
              binDimensions,
              binWallSize,
              binMaxGapSize,
              binWallThickness
          );
          
          for (screwSlotPosition = screwSlotPositions) {                
              translate([
                  (screwSlotPosition.x * xDivisionFinalWidth) + binWallSize,
                  0,
                  (screwSlotPosition.y * zDivisionFinalWidth) + binWallSize,
              ]) {
                  cube([
                      xGapSizeFinal,
                      binWallThickness,
                      zGapSizeFinal
                  ]); 
              }
          }
      }
  
      union() {
          for (screwSlotPosition = screwSlotPositions) {        
              translate([
                  (screwSlotPosition.x * xDivisionFinalWidth) + binWallSize,
                  0,
                  (screwSlotPosition.y * zDivisionFinalWidth) + binWallSize,
              ]) {
                  screwSlot(
                      [
                          xGapSizeFinal,
                          binWallThickness,
                          zGapSizeFinal
                      ],
                      screwHeadDiameter + screwDiametersTolerance,
                      screwThreadDiameter + screwDiametersTolerance
                  );
              }
          }
      }
  }
}

basket(
  binDimensions = [ 200, 65, 80],
  binWallThickness = 2,
  screwSlotPositions = []
);