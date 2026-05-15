
use <../extensionpole/extension_pole_thread.scad>

twineDiameter=2;


module right_angle_prism(l, w, h) {
    linear_extrude(height = h) {
        polygon(points=[[0,0],[l,0],[0,w]], paths=[[0,1,2]]);
    }
}

module finger(fingerLength=10,fingerWidth=5,fingerSupport=5)
{
    
    difference()
    {
        cube([fingerLength,fingerWidth,fingerWidth],center=true);
        translate([fingerLength/2-twineDiameter*1.4,fingerWidth/2-twineDiameter*0.4,0])cylinder(d=twineDiameter,h=fingerWidth*2,center=true,$fn=64);
    }
    
    translate([-fingerLength/2,-fingerWidth/2,-fingerWidth/2])rotate([0,0,-90])right_angle_prism(fingerSupport,fingerLength,fingerWidth);
}

module twineHanger()
{
    fingerLength=60;
    fingerWidth=4;
    nutWidth=25;
    nutHeight=27;
    extension_pole_nut(0);

    translate([fingerLength/2-nutWidth*0.3,nutWidth/2+fingerWidth/2,fingerWidth/2+0.5])
        rotate([-90,0,0])
            finger(fingerLength,fingerWidth,nutHeight-fingerWidth-1);
    translate([fingerLength/2-nutWidth*0.3,-(nutWidth/2+fingerWidth/2),fingerWidth/2+0.5])
        rotate([-90,0,0])
            finger(fingerLength,fingerWidth,nutHeight-fingerWidth-1);

}

//rotate([-90,0,0])finger(60,4,22);

//extension_pole_nut();

twineHanger();