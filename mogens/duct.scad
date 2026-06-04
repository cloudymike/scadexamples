use <outlet.scad>
use <controller.scad>


thickness=wallThickness();
height=controllerHeight();


module ductNoholes(length=20,ductHeight=27,ductDepth=65)
{
    angleRight=(ductHeight-thickness/2);
    angleSide=angleRight*sqrt(2);

    difference() 
    {
        
        cube([ductDepth,length,ductHeight],center=true);  
        cube([ductDepth-2*thickness,length-2*thickness,ductHeight-2*thickness],center=true);

        //back wall at 45 angle
      translate([-ductDepth/2-ductHeight/2,length/2,-ductHeight/2])rotate([90,0,0])right_angle_prism(ductHeight,ductHeight, length);
    translate([-ductDepth/2-ductHeight/2,length/2,ductHeight/2])rotate([90,90,0])right_angle_prism(ductHeight,ductHeight, length);
 
  }
   
        


   difference()
   {
        union()
        {
            translate([-ductDepth/2,0,0])rotate([0,-45,0])cube([thickness,length,angleSide],center=true);
            translate([-ductDepth/2,0,0])rotate([0,45,0])cube([thickness,length,angleSide],center=true);
        }
        
   translate([-ductDepth/2-angleRight/4+thickness/2,0,0])cube([angleRight/2,length,ductHeight+thickness],center=true);
   translate([-ductDepth/2-angleRight/4-thickness,0,0])cube([angleRight/2,length,ductHeight+thickness],center=true);
   }
    
}

module duct(
    length=20,
    ductHeight=27,
    outX=30,
    outZ=0,
    ductDepth=65,
    )
{
    difference()
    {
        ductNoholes(length,ductHeight,ductDepth);
        inX=ductDepth/2;
        inZ=height;
        translate([inX/2-2*thickness,length/2,-ductHeight/2+inZ/2+thickness])cube([inX,length,inZ],center=true);
        
        translate([-2*thickness,length/2,-ductHeight/2+inZ/2+thickness])rotate([0,45,0])cube([inZ*sqrt(2)/2,length,inZ*sqrt(2)/2],center=true);
        
        //outlet
        translate([outX,-length/2,outZ])rotate([90,0,0])cylinder(h=length,d=outletD(),center=true, $fn=128);
    }
    

}

duct(length=50,ductHeight=80,ductDepth=110,outX=55-outletD()/2-2);
