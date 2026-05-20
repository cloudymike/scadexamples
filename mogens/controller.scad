

    width=70;
    height=27;
    depth=65;
    lip=5;
    
module right_angle_prism(l, w, h) {
    linear_extrude(height = h) {
        polygon(points=[[0,0],[l,0],[0,w]], paths=[[0,1,2]]);
    }
}




module controller(thickness=1)
{
    
    tabWidth=15;
    tabThick=2;
    
    difference() 
    {
        union()
        {
            cube([depth,width,height],center=true);
        }
        translate([-thickness,-thickness,thickness])cube([depth,width,height],center=true);
        translate([-depth/2+tabWidth/2,-width/2,0])cube([tabWidth,tabThick,height+lip*2],center=true);
    }


    //back wall at 45 angle
    angleRight=(height-thickness/2);
    angleSide=angleRight*sqrt(2);
    
    translate([-depth/2,-width/2+tabThick,-height/2])rotate([90,0,0])right_angle_prism(height,height, thickness);
    translate([-depth/2,-width/2+tabThick,height/2])rotate([90,90,0])right_angle_prism(height,height, thickness);
    
    difference()
    {
        translate([(height)/2-depth/2,0,0])rotate([0,-45,0])cube([thickness,width,angleSide],center=true);
        translate([-depth/2+tabWidth/2,-width/2,0])cube([tabWidth+thickness,tabThick,height+lip*2],center=true);       
    }


            //lips
    translate([tabWidth/2,-width/2+thickness/2,height/2+lip/2])cube([depth-tabWidth,thickness+0.01,lip],center=true);
    translate([0,width/2-thickness/2,height/2+lip/2])cube([depth,thickness,lip],center=true);

//translate([-depth/2+tabWidth/2,-width/2+tabThick-thickness/2,0])cube([tabWidth,thickness,height],center=true);
    
    
}


difference()
{
    controller();
    translate([27,0,0])cube([depth,width+10, height+10],center=true);
    //translate([0,0,5])cube([depth,width,height],center=true);
}