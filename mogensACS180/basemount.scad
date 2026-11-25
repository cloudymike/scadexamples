use <prism.scad>
use <ACS180.scad>

$fn=64;

function baseHeight()=3.72+0.5+0.8;

thickness=1;
height=baseHeight();
ctrlWidth=60.5;
screwHole=5;
screwMargin=2*screwHole;
holeDistance=101;
barFromTop=56;
barX=-5;
plateWidth=ctrlWidth+2*thickness;


module bmx(length=70)
{
    cube([plateWidth,length, height],center=true);

    barY=length/2-barFromTop;    
    difference()
    {
        translate([barX,barY,0])cube([holeDistance+screwMargin,screwMargin,height],center=true);
        translate([barX+50.5,barY,0])cylinder(d=screwHole,h=2*height,center=true);
        translate([barX-50.5,barY,0])cylinder(d=screwHole,h=2*height,center=true);
    }
    rightPrismX=(holeDistance+screwMargin-plateWidth)/2+barX;
    leftPrismX=(holeDistance+screwMargin-plateWidth)/2-barX;
    rightPrismY=length/2+barY-screwMargin/2;
    leftPrismY=length/2+barY-screwMargin/2;
    translate([plateWidth/2,barY-screwMargin/2,-height/2])rotate([90,0,0])prism(height,rightPrismX,rightPrismY);
    translate([-plateWidth/2,barY-screwMargin/2,+height/2])rotate([90,180,0])prism(height,leftPrismX,leftPrismY);
}

module bmx2(length=70)
{
    barY=length/2-barFromTop;  
    antiwarpHeight=baseHeight()+fanHeight();  

    difference()
    {
        translate([barX,0,0])cube([holeDistance+screwMargin,length, height],center=true);
        translate([barX+50.5,barY,0])cylinder(d=screwHole,h=2*height,center=true);
        translate([barX-50.5,barY,0])cylinder(d=screwHole,h=2*height,center=true);
    }
    translate([barX,-length/2+thickness,antiwarpHeight/2-thickness/2])cube([holeDistance+screwMargin,2*thickness,antiwarpHeight],center=true);
}


module basemount(length=70)
{
    rotate([90,0,0])bmx2(length);
}

difference()
{
    bmx2(80);
    //translate([0,0,10])cube([100,100,62],center=true);
}


