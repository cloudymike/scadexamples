use <ACS180.scad>
use <funnel.scad>
use <fanring.scad>

boxL=50;
ACS180L=100;
fanringL=10;

acsXoffset=19;
acsYoffset=35;
fanXoffset=0;
fanYoffset=-15;
Zadjust=8; //ctrlNotch

thickness=1;


difference()
{
    translate([fanXoffset,fanYoffset,0])fanball(fanringL);
    translate([acsXoffset,acsYoffset,0])ACS180cutout(ACS180L);
}
difference()
{
    translate([acsXoffset,acsYoffset,0])ACS180(ACS180L);
    translate([fanXoffset,fanYoffset,0])fanballcutout(fanringL);
}

