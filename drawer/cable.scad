
$fn = 40;

module cabletile(x=38,y=38,z=16.5) {
  overextrusion = 0.2;
  pin_thickness = 1.5 + 2 * overextrusion;
  pin_width = 6.5 + 2 * overextrusion;
  pin_length = 16.5;
  newZ=max(z,pin_length);
  difference() {
    cube([x,y,newZ],center=true);
    translate([-10,-10,0])
      cylinder(r=9,h=newZ,center=true);
    translate([10,-10,0])
      cylinder(r=9,h=newZ,center=true);
    translate([0,10,0])
      cube([20,18,newZ],center=true);

    translate([-10,10,0])
      cylinder(r=9,h=newZ,center=true);
    translate([10,10,0])
      cylinder(r=9,h=newZ,center=true);
    translate([0,-10,0])
      cube([20,18,newZ],center=true);

 }
}

cabletile(40,40,0);