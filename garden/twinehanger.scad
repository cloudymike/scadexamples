
use <../extensionpole/extension_pole_thread.scad>

twineDiameter=2;

module finger(fingerLength=10,fingerWidth=5)
{
    difference()
    {
        fingerWidth=5;
        
    
        cube([fingerLength,fingerWidth,fingerWidth],center=true);
        translate([fingerLength/2-twineDiameter*0.8,fingerWidth/2-twineDiameter*0.4,0])cylinder(d=twineDiameter,h=fingerWidth*2,center=true,$fn=64);
    }
    
}

module twineHanger()
{
    fingerLength=50;
    fingerWidth=5;
    nutWidth=25;
    extension_pole_nut();

    translate([fingerLength/2,nutWidth/2-fingerWidth/2,fingerWidth/2])
        rotate([90,0,0])
            finger(fingerLength);
    translate([fingerLength/2,-(nutWidth/2-fingerWidth/2),fingerWidth/2])
        rotate([90,0,0])
            finger(fingerLength);

}

//finger();

//extension_pole_nut();

twineHanger();