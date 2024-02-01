use <divider.scad>
difference()
{
screwstrip(15);
  translate([0,-15,0])cube([500,69,10],center=true);
}
translate([-3.5,24,-3.3])linear_extrude(3) text("1 2 3 4 5 6 7 8 9 A B C D E F G I");