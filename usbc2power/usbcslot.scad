
printmargin=0.2;

wall=2;
boardwidth=10.62;
USBCwidth=8.83;
boardlength=16.3;
boardthickness=1.68;
boardheight=4.85;
slotdepth=(boardwidth-USBCwidth)/2;
wallheight = wall+slotdepth+boardheight+wall+1;


//bottom
translate([0,0,wall/2])cube([boardwidth,boardlength,wall],center=true);
//top
translate([0,0,wallheight-wall/2])cube([boardwidth,boardlength,wall],center=true);

//walls
translate([(boardwidth+wall)/2,0,wallheight/2]) cube([wall,boardlength,wallheight],center=true);
translate([-(boardwidth+wall)/2,0,wallheight/2]) cube([wall,boardlength,wallheight],center=true);

//bottom rails
translate([(boardwidth-slotdepth)/2, 0,wall+boardthickness/2])cube([slotdepth,boardlength,boardthickness],center=true);
translate([-(boardwidth-slotdepth)/2, 0,wall+boardthickness/2])cube([slotdepth,boardlength,boardthickness],center=true);

//top rails
toprailheight=wallheight-(wall+2*boardthickness);
translate([(boardwidth-slotdepth)/2, 0,wall+2*boardthickness+toprailheight/2])cube([slotdepth,boardlength,toprailheight],center=true);
translate([-(boardwidth-slotdepth)/2, 0,wall+2*boardthickness+toprailheight/2])cube([slotdepth,boardlength,toprailheight],center=true);

