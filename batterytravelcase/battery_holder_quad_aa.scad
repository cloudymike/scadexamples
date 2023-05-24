top_bottom = [-1, 1];
pad = 0.01; // Padding to maintain mainfold
wall_thickness = 2;
bottom_thickness = 1;
battery_r = 14.75 / 2;

// Actual sizes
//
battery_h = 51;
heights = [ (battery_h * (1/3)) + wall_thickness,
            (battery_h * (2/3)) + wall_thickness ];

// bottom_h = (battery_h * (2/3)) + wall_thickness;
// top_h = (battery_h * (1/3)) + wall_thickness;

// Test sizes
// battery_h = 8;
//
// bottom_h = (battery_h * (1/2)) + wall_thickness;
// top_h = (battery_h * (1/2)) + wall_thickness;

inter_battery_offset = wall_thickness - 0.8;
lip_height = 4;
lip_thickness = 0.8;
circle_offset = battery_r + inter_battery_offset;

two_by_two = [[ circle_offset, circle_offset],
              [-circle_offset, circle_offset],
              [-circle_offset,-circle_offset],
              [ circle_offset,-circle_offset]];

two_by_one =  [[ circle_offset, 0],
               [-circle_offset, 0]];

four_by_one = [[ 0, 3*circle_offset],
               [ 0,   circle_offset],
               [ 0,  -circle_offset],
               [ 0,-(3*circle_offset)]];

three_by_one = [[ 0, 3*circle_offset],
                [ 0,   circle_offset],
                [ 0,  -circle_offset]];
           


module battery_box(height, circle_centers, lip) {
  difference() {
    union() {
      linear_extrude(height = height, center = false, convexity = 10, twist = 0) {
        hull() {
          union() {
            for( i = circle_centers ) {
              translate(i) {
                circle(battery_r + wall_thickness);
              }
            }
          }
        }
      }

      // If the lip is positive then it is unioned with our outer hull
      //
      if ( lip > 0 ) {
        for( i = circle_centers ) {
          translate(i) {
            translate(v = [0, 0, height-pad]) {
              cylinder(h = lip - 0.2, r = battery_r + (lip_thickness-0.1));
            }
          }
        }
      }
    }

    // If the lip is negative then it is differenced out of our hull (so
    // positive is the male edge, and negative female is the edge of a
    // top/bottom pair, male on the bottom.)
    //
    if (lip < 0) {
      for( i = circle_centers ) {
        translate(i) {
          translate(v = [0, 0, height + lip + 0.1]) {
            cylinder(h = abs(lip), r = battery_r + (lip_thickness));
          }
        }
      }
    }

    // Four cylinders for batteries
    //
    union() {
      translate(v=[0,0,wall_thickness]) {
        for( i = circle_centers ) {
          translate(i) {
            cylinder(h = battery_h, r = battery_r );
          }
        }
      }
    }
  }
}

// In the following for-loop substitute "two_by_one" "two_by_two" etc, as
// defined at the top of the file, for the second argument to pick which
// formation of battery holder you want.
//
for (i = [0:1] ) {
  translate(v = [top_bottom[i] * (2*circle_offset + 5), 0, 0]) {
    battery_box(heights[i], two_by_one, top_bottom[i] * lip_height);
  }
}

