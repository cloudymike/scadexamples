module coverplate(
    width=168,
    height=140,
    thickness=1,    
    wallheight=20
)
{
    cutback=wallheight;
    
    cube([width,height,thickness],center=true);
    
    translate([-width/2+(wallheight/2)*sin(30)+thickness*0.4,0,wallheight*0.44])rotate([0,30,0])cube([thickness,height-cutback,wallheight],center=true); 
    
    translate([width/2-(wallheight/2)*sin(30)-thickness*0.4,0,wallheight*0.44])rotate([0,-30,0])cube([thickness,height-cutback,wallheight],center=true); 
    
    translate([0,-height/2+(wallheight/2)*sin(30)+thickness*0.4,wallheight*0.44])rotate([-30,0,0])cube([width-cutback,thickness,wallheight],center=true); 
    
    translate([0,height/2-(wallheight/2)*sin(30)-thickness*0.4,wallheight*0.44])rotate([30,0,0])cube([width-cutback,thickness,wallheight],center=true); 
}

difference()
{
    coverplate(width=168);
    //translate([10,0,0])cube([168,200,10],center=true);
}