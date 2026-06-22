use <screwhang.scad>

thickness=1;
footLength=180;
footWidth=50;
footThick=5;
hangHeight=99;
leanDegree=30;

module right_angle_prism(l, w, h) {
    linear_extrude(height = h) {
        polygon(points=[[0,0],[l,0],[0,w]], paths=[[0,1,2]]);
    }
}

module back(hangHeight=hangHeight, leanDegree=leanDegree)
{
    backLength=hangHeight+20;
    //translate([0,0,60])cube([thickness,30,backLength],center=true);
    
    translate([backLength*sin(leanDegree)/2,-footWidth/2,0])rotate([90,0,180])right_angle_prism(backLength*sin(leanDegree),cos(leanDegree)*backLength,footWidth);}

module foot()
{
    translate([0,0,-footThick/2])cube([footLength,footWidth,footThick],center=true);    
}

module supportWall()
{
    supportThickness=0.3;
    translate([0,supportThickness/2,0])rotate([90,0,0])right_angle_prism(11*cos(leanDegree),11*sin(leanDegree),supportThickness);
    translate([11/2,0,-10])cube([11,supportThickness,20],center=true);
}
module leaningFoot()
{
    back();
    knobAdjust=5;
    translate([hangHeight*sin(leanDegree)/2-knobAdjust,0,cos(leanDegree)*hangHeight])rotate([0,leanDegree-90,0])screwhang();
    translate([hangHeight*sin(leanDegree)/2-15,0,cos(leanDegree)*hangHeight-2])supportWall();
    foot();
    

}

difference()
{
leaningFoot();
//    translate([0,-102,0])cube([200,200,300],center=true);
//    translate([0,100.2,0])cube([200,200,300],center=true);
}
