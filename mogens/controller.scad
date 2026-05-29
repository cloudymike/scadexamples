use <outlet.scad>
use <../kegtower/knurlpocket.scad>

function wallThickness()=1;
function controllerHeight()=27;


thickness=wallThickness();
height=controllerHeight();
 
module right_angle_prism(l, w, h) {
    linear_extrude(height = h) {
        polygon(points=[[0,0],[l,0],[0,w]], paths=[[0,1,2]]);
    }
}


module controller(
    depth=65

)
{
    
    width=70;
    tabWidth=15;
    tabThick=3;
    lip=5;
    

    difference() 
    {
        union()
        {
            cube([depth,width,height],center=true);
        }
        translate([-thickness,0,thickness])cube([depth,width-2*thickness,height],center=true);
        translate([-depth/2+tabWidth/2,-width/2,0])cube([tabWidth,tabThick,height+lip*2],center=true);

        // outlet
        //translate([0,-width/2,0])cube([depth,width,height-2*thickness],center=true);

        inX=depth/2;
        inZ=height;
        translate([inX/2-2*thickness,-width/2,-height/2+inZ/2+thickness])cube([inX,width,inZ],center=true);

        translate([-2*thickness,-width/2,-height/2+inZ/2+thickness])rotate([0,45,0])cube([inZ*sqrt(2)/2,width,inZ*sqrt(2)/2],center=true);
        
    }


    //back wall at 45 angle
    angleRight=(height-thickness/2);
    angleSide=angleRight*sqrt(2);

    knurlDepth=10;
    
    difference() {
    // Hacks to provide space for the tab
        union() {
    translate([-depth/2,-width/2+tabThick+thickness,-height/2])rotate([90,0,0])right_angle_prism(height,height, thickness);
    translate([-depth/2+tabWidth/2+thickness,-width/2+tabThick+thickness/2,0])cube([tabWidth+2*thickness,thickness,height],center=true);
    translate([-depth/2+tabWidth+tabThick/2,-width/2+tabThick,0])cube([tabThick,tabThick,height],center=true);
        }
    translate([-depth/2+7,-width/2+knurlDepth/2+tabThick,height/2-15])rotate([90,0,0])m5knurl_pocket(knurlDepth);
    }
    // tab screw
    translate([-depth/2+7,-width/2+knurlDepth/2+tabThick,height/2-15])rotate([90,0,0])m5knurl_ring(knurlDepth);
    //hack to make it test printable
    translate([-depth/2+tabWidth/2,-width/2+knurlDepth/2+tabThick,-height/2+4])cube([tabWidth,knurlDepth,8],center=true);
    
    // Sloping plane at top
    difference()
    {
        translate([(height)/2-depth/2,0,0])rotate([0,-45,0])cube([thickness,width,angleSide],center=true);
        translate([-depth/2+tabWidth/2,-width/2+tabThick/2,0])cube([tabWidth+thickness,tabThick,height+lip*2],center=true);       
    }

    

    //lips
    translate([tabWidth/2,-width/2+thickness/2,height/2+lip/2])cube([depth-tabWidth,thickness+0.01,lip],center=true);
    translate([0,width/2-thickness/2,height/2+lip/2])cube([depth,thickness,lip],center=true);
}

difference()
{
controller();
    translate([0,30,0])cube([100,100,100],center=true);
    translate([50,0,0])cube([100,100,100],center=true);
    translate([34,0,50])cube([100,100,100],center=true);
}



