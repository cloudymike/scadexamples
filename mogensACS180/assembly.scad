use <ACS180.scad>
use <funnel.scad>
use <fanring.scad>

boxL=50;
ACS180L=50;

acsXoffset=19;
acsYoffset=35;
fanXoffset=0;
fanYoffset=-15;
Zadjust=8; //ctrlNotch

thickness=1;

module connectorbox(length=50)
{
    Xsize=110;
    Ysize=130;
    translate([0,0,length/2])
    difference()
    {
        cube([Xsize,Ysize,length],center=true);
        cube([Xsize-thickness*2,Ysize-thickness*2,length-thickness*2],center=true);
    }
}


difference()
{
    connectorbox(boxL);
    translate([fanXoffset,fanYoffset,0])fancutout();
    translate([acsXoffset,acsYoffset,boxL])boxcutout();
}

translate([fanXoffset,fanYoffset,0])fanring(10);
translate([acsXoffset,acsYoffset,boxL+ACS180L/2])ACS180(ACS180L);
