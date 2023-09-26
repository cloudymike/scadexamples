use <interlockingmodule.scad>

// Using the battery travel case simplified model
// Adding 0.4 mm
// Creating a diff with a standard tile 


$fn=120;

height=20;

BoxUnits=40;
BoxWidthUnits=1;
BoxLengthUnits=1;

top_bottom = [-1, 1];
pad = 0.01; // Padding to maintain mainfold
wall_thickness = 2;
bottom_thickness = 1;
battery_r = 14.75 / 2;
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
                circle(battery_r + wall_thickness+0.4);
              }
            }
          }
        }
      }
    }
  }
}
    
difference() {
  interlockingbox(BoxWidthUnits,BoxLengthUnits,height,height);
  translate([19,21,2]) battery_box(height,two_by_two,0);
}   
