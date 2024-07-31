

wall=2;
stripwidth=10;
coverlength=232;
earheight=10;


cube([coverlength,stripwidth,wall]);
translate([-wall,0,0])cube([wall,stripwidth,earheight]);
translate([coverlength,0,0])cube([wall,stripwidth,earheight]);