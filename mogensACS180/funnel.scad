
$fn=128;

fanD=94;
thickness=1;


module funnel(length=50)
{
    difference()
    {
        cylinder(d1=fanD+thickness*2,d2=thickness*2,h=length);
        cylinder(d1=fanD,d2=0,h=length-thickness);
    }
}

module funnelcutout(length=50)
{
    cylinder(d1=fanD,d2=0,h=length-thickness);
}

funnel();