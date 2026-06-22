
module screwhang()
{
    translate([0,0,-1.5])cylinder(d=11, h=3,center=true, $fn=64);
    translate([0,0,9])cylinder(d=11, h=3,center=true, $fn=64);

    // Trick to make a solid center cylinder
    difference()
    {
        translate([0,0,4.5])cylinder(d=4.5, h=12, center=true, $fn=64);
        translate([0,0,4.5])cylinder(d=2.9, h=12, center=true, $fn=64);
    }
    difference()
    {
        translate([0,0,4.5])cylinder(d=2.8, h=12, center=true, $fn=64);
        translate([0,0,4.5])cylinder(d=1.2, h=12, center=true, $fn=64);
    }
    translate([0,0,4.5])cylinder(d=1.1, h=12, center=true, $fn=64);


}

screwhang();
