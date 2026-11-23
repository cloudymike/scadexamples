
$fn=64;

thickness=1;
fanD=94;


module fanring(length)
{
    difference()
    {
        cylinder(d=fanD+2*thickness, h=length);
        cylinder(d=fanD, h=length);
    }
}

module fancutout(length)
{
        cylinder(d=fanD, h=length);
}

fanring(5);