
// Global variables
printmargin=0.2;

wall=2;

boardwidth=10.62+printmargin;
USBCwidth=8.83;
boardlength=16.3;
boardthickness=1.68+printmargin/2;
boardheight=4.85+printmargin;
slotdepth=(boardwidth-USBCwidth)/2;
wallheight = wall+slotdepth+boardheight+wall+2;



module boardslot()
{
  
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
}

module usbc_hole(wall=1)
{
  height=3.14+2*printmargin;
  width=8.84+2*printmargin;
  cube([width-height,height,wall],center=true);
  translate([-(width-height)/2,0,0])cylinder(d=height,h=wall,center=true, $fn=64);
  translate([(width-height)/2,0,0])cylinder(d=height,h=wall,center=true, $fn=64);
}


//boardslot();
difference()
{
  cube([12,6,1],center=true);
  usbc_hole();
}
