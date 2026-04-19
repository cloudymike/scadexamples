
use <../threads/isothreads.scad>


$fn=0;

fullwidth=16.4;
narrolength=23;

// Functions to pass variables up to user of this module
function fanwidth()=fullwidth;
function tablength()=narrolength;

function segments (diameter) = min (($fn < 0.01) ? 50 : 2, ceil (diameter*6));

module frame(padding)
{
    fullthick=6.0;
    fulllength=14;
    narrothick=3;
    narrowidth=10;
    
    cube([fulllength,fullwidth,fullthick],center=false);
    cube([fullthick+padding,fullwidth,fulllength],center=false);
    
    translate([0,3,0])cube([narrolength,narrowidth,narrothick],center=false);
    translate([0,3,0])cube([narrothick+padding,narrowidth,narrolength],center=false);
}

module onecorner(padding=0,thread=false)
{
    holecenter=4.2;
    
    difference()
    {
        frame(padding);
        translate([holecenter+padding,0,holecenter])rotate([-90,0,0])
            if (thread)           
                {m4thread();}
            else
                {m4hole();}
    }
}


module m4hole()
{
    $fn=64;
    height=20;
    translate([0,0,height/2])cylinder(d=5,h=height,center=true);
}

module m4thread()
{
    height=20;
    translate([0,0,0])metric_thread (diameter=8, pitch=1, length=height);   
}

onecorner(3);
//m4thread();
//m4hole();