use <ACS180.scad>
use <fanring.scad>
use <basemount.scad>

thickness=1;

ACS180L=109;
fanringL=10;

acsXoffset=19;
acsYoffset=35;
fanXoffset=0;
fanYoffset=-15;
Zadjust=8; //ctrlNotch

fanHeight=fanHeight();
baseHeight=baseHeight();

module fanAssembly()
{
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
    
    translate([acsXoffset,acsYoffset+fanHeight/2+baseHeight/2+thickness,ACS180L/2])basemount(ACS180L);
}


// Some test cutouts
difference()
{
   fanAssembly();
    
   //X offset
   //translate([0,-96,0])cube([200,200,400],center=true);  
   //translate([0,107.0,0])cube([200,200,400],center=true);  
    
    
   //translate([0,0,101])cube([200,200,200],center=true);  //ringheight
   //translate([0,0,5])cube([200,200,200],center=true);  //ACS180 height
    
   //translate([0,-34,0])cube([200,200,400],center=true);  //distance
}