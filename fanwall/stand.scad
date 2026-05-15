
use <onecorner.scad>
use <twocorner.scad>
use <cableslot.scad>

module oneleg(height)
{
    difference()
    {
        cube([tablength(),fanwidth(),height],center=false);
        translate([tablength(),fanwidth()/2,height/2])rotate([0,0,-90])slot(height);
    }
}
module leg(angle=0,height=10)
{
   translate([0,0,-height])rotate([0,0,-angle/2]) oneleg(height);
   translate([0,0,-height])rotate([0,0,angle/2])mirror([1,0,0])oneleg(height);
    
    
   if (angle > 0)
    {       
        translate([0,cos(angle/2)*fanwidth(),-height])rotate([90,0,0])prism(height,sin(angle/2)*fanwidth()+0.1,cos(angle/2)*fanwidth()+0.1);
    }
}

module foot(height)
{
    footY=100;
    footZ=2;
    ribX=2;
    ribZ=5;
    translate([0,0,-height-footZ/2]) cube([tablength()*2+fanwidth()/2,footY,footZ],center=true);
    
    //Strengthening ribs and cable tie holder
    difference()
    {
        translate([0,0,-height+ribZ/2]) cube([ribX,footY,ribZ],center=true);
        translate([0,footY/4,-height+ribZ/2]) cube([ribX,3,1.4],center=true);
        translate([0,3*footY/8,-height+ribZ/2]) cube([ribX,3,1.4],center=true);
        translate([0,-footY/4,-height+ribZ/2]) cube([ribX,3,1.4],center=true);
        translate([0,-3*footY/8,-height+ribZ/2]) cube([ribX,3,1.4],center=true);
    }
}


module stand(angle=0,height=100)
{
    twocorner(angle);
    foot(height);    
    leg(angle,height);
}

stand(30,100);

