
$fa = 1;
$fs = 0.1;

stemheight=3;
stemdiameter=6;

footheight=5;
footdiameter=10;

bump = 0.5;

cylinder(d=footdiameter,h=footheight);
translate([0,0,footheight])
    cylinder(d=stemdiameter,h=stemheight);
translate([stemdiameter/2,0,footheight+stemheight-bump])
    sphere(r=bump);
translate([-stemdiameter/2,0,footheight+stemheight-bump])
    sphere(r=bump);

