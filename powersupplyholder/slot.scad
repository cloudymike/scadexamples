
module powersupplybracket()
{
    depth=40;
    height=67.5;
    length=10;
    wall=2;
    earheight=15;
    screwholeD=4;
    
    difference()
    {
        cube([length,depth+wall,height+2*wall],center=true);
        translate([0,wall,0])cube([length,depth,height],center=true);
    }
    
    difference()
    {
        translate([0,depth/2,height/2+earheight/2])cube([length,wall,earheight],center=true);
        translate([0,depth/2,height/2+earheight/2])rotate([90,0,0])cylinder(d=screwholeD,h=2*wall,center=true);
    }
    
    difference()
    {
        translate([0,depth/2,-height/2-earheight/2])cube([length,wall,earheight],center=true);
        translate([0,depth/2,-height/2-earheight/2])rotate([90,0,0])cylinder(d=screwholeD,h=2*wall,center=true);
    }

}

rotate([0,90,0])powersupplybracket();