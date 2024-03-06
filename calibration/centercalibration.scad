// Simple layout to check that print is centered
// Add offset as measured to G code. 
// Example X needs to move 3.8mm to left and Y 5.5 to back:
// M206 X3.8 Y-5.5

difference() {
  cylinder(h=1,r=10,center=true);
  cylinder(h=1,r=9,center=true);
}

cube([20,0.5,1],center=true);
cube([0.5,20,1],center=true);
