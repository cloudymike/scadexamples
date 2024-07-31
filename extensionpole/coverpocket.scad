

module pocket(coverlength=10)
{
  wall=2;
  bottomwidth=43;
  topwidth=48;
  pocketheight=60;
  
  rotate([90,0,90])
  translate([-bottomwidth/2,wall,-coverlength/2])
  difference()
  {
    linear_extrude(height=coverlength) polygon([[0-wall,0-wall],[bottomwidth+wall,0-wall],[topwidth+wall,pocketheight],[-5-wall,pocketheight]]);
    linear_extrude(height=coverlength) polygon([[0,0],[bottomwidth,0],[topwidth,pocketheight],[-5,pocketheight]]);
  }
}


module strip(earheight=10)
{
  wall=2;
  stripwidth=10;
  coverlength=232;
  translate([-(coverlength+wall)/2,-stripwidth/2,0])
  {  
    cube([coverlength,stripwidth,wall]);
    translate([-wall,0,0])cube([wall,stripwidth,earheight]);
    translate([coverlength,0,0])cube([wall,stripwidth,earheight]);
  }
}

strip(40);

pocket(100);