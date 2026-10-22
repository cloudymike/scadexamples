

depth=40;
height=80;
length=100;
wall=2;
earheight=30;

difference()
{
    cube([length,depth+wall,height+2*wall],center=true);
    translate([0,wall,0])cube([length,depth,height],center=true);
}
translate([0,depth/2,height/2+earheight/2])cube([length,wall,earheight],center=true);

translate([0,depth/2,-height/2+-earheight/2])cube([length,wall,earheight],center=true);


