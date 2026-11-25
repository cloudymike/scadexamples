
$fn=64;

thickness=1.6;
fanD=94;
extraWall=6.8;


module fanring(length)
{
    difference()
    {
        union()
        {
            cylinder(d=fanD+2*thickness, h=length);
            cylinder(d=fanD+2*thickness+2*extraWall,h=thickness*2);
        }
        cylinder(d=fanD, h=length);
    }
}

module fancutout(length)
{
        cylinder(d=fanD, h=length);
}

module halfball()
{
    ballD=fanD;
    difference()
    {
        sphere(d=ballD+2*thickness);
        sphere(d=ballD);
        translate([0,0,-100])cube([200,200,200],center=true);
    }
   
}

module fanball(length)
{
    fanring(length);
    translate([0,0,length])halfball();
}

module fanballcutout(length)
{
    fancutout(length);
    translate([0,0,length])sphere(d=fanD);
}

fanring(10);