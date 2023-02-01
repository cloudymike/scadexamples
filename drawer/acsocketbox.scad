
module acsocket(x=38,y=38,z=16.5) {
  overextrusion = 0.2;
  pin_thickness = 1.5 + 2 * overextrusion;
  pin_width = 6.5 + 2 * overextrusion;
  pin_length = 16.5;
  newZ=max(z,pin_length);
  difference() {
    cube([x,y,newZ],center=true);
    translate([-6.5,0,newZ-pin_length])
      cube([pin_thickness,pin_width,pin_length],center=true);
    translate([6.5,0,newZ-pin_length])
      cube([pin_thickness,pin_width,pin_length],center=true);
  }
}

acsocket(20,10,0);