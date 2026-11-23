module tubebend(length,odiameter,idiameter,angle)
{
difference()
{
union()
{
cylinder(length,odiameter/2,odiameter/2);
translate([0,0,length])rotate([0,angle,0])cylinder(length,odiameter/2,odiameter/2);
translate([0,0,length])rotate([0,0,0])sphere(odiameter/2);
}
union()
{
translate([0,0,-1])cylinder(length+1,idiameter/2,idiameter/2);
translate([0,0,length])rotate([0,angle,0])cylinder(length+1,idiameter/2,idiameter/2);
translate([0,0,length])rotate([0,0,0])sphere(odiameter/2);
}
}
}

module bendonly(length,odiameter,idiameter,angle)
{
difference()
{
union()
{
//cylinder(length,odiameter/2,odiameter/2);
translate([0,0,length])rotate([0,angle,0])cylinder(length,odiameter/2,odiameter/2);
translate([0,0,length])rotate([0,0,0])sphere(odiameter/2);
}
union()
{
translate([0,0,-1])cylinder(length+1,idiameter/2,idiameter/2);
translate([0,0,length])rotate([0,angle,0])cylinder(length+1,idiameter/2,idiameter/2);
translate([0,0,length])rotate([0,0,0])sphere(odiameter/2);
}
}
}



Length=50;
fanD=94;
thickness=1;
id=fanD;
od=fanD+2*thickness;
angle=60;
rotate([0,90-angle,0])
union()
{
tubebend(Length,od,id,angle);
translate([0,0,Length])rotate([0,180,0])bendonly(Length,od,id,angle);
}


