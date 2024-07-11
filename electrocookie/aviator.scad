
platethickness=1;
aviatorD=15.5;
difference() 
{
  cube([20,20,platethickness],center=true);
    cylinder(d=aviatorD,h=platethickness,center=true);
}
translate([aviatorD/2,0,0]) cube([2,aviatorD,platethickness],center=true);




