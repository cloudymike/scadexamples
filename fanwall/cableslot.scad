


module slot(length)
{
    $fn=64;
    difference()
    {
        translate([0,-1.25,0])cube([5,2.5,length],center=true);
        translate([-3,0,0])rotate([90,90,0])cylinder(d=6,h=1,center=true);
        if (length>40)
        {
            translate([-3,0,length/2-10])rotate([90,90,0])cylinder(d=6,h=1,center=true);
            translate([-3,0,-length/2+10])rotate([90,90,0])cylinder(d=6,h=1,center=true);
        }
            
    }
}

z=10;
x=10;
y=5;
difference()
{
    cube([x,y,z],center=true);
    translate([0,y/2,0])slot(z);
}