use <prism.scad>

thickness=1;
height=3.72-thickness;
ctrlWidth=60.5;
screwHole=5;
screwMargin=2*screwHole;
holeDistance=120;
barFromTop=56;
barX=-9;
plateWidth=ctrlWidth+2*thickness;


module basemount(length=70)
{
    cube([plateWidth,length, height],center=true);

    barY=length/2-screwMargin/2-barFromTop;    
    difference()
    {
        translate([barX,barY,0])cube([holeDistance+screwMargin,screwMargin,height],center=true);
        translate([barX+60,barY,0])cylinder(d=screwHole,h=2*height,center=true);
        translate([barX-60,barY,0])cylinder(d=screwHole,h=2*height,center=true);
    }
    rightPrismX=(holeDistance+screwMargin-plateWidth)/2+barX;
    leftPrismX=(holeDistance+screwMargin-plateWidth)/2-barX;
    rightPrismY=length/2+barY-screwMargin/2;
    leftPrismY=length/2+barY-screwMargin/2;
    translate([plateWidth/2,barY-screwMargin/2,-height/2])rotate([90,0,0])prism(height,rightPrismX,rightPrismY);
    translate([-plateWidth/2,barY-screwMargin/2,+height/2])rotate([90,180,0])prism(height,leftPrismX,leftPrismY);
}


basemount(100);