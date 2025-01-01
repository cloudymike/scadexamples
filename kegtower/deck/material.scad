

function foot(x=1) = 304.8*x;
function inch(x=1) = 25.4*x;
function nominal(inch) = 
  (inch==1) ? 19 : 
  (inch==2) ? 38 : 
  (inch==4) ? 90 : 
  (inch==6) ? 140 : 
  0;

function deckThick() = inch(0.94); 
metThick = 1;

module lumber6feet2x4()
{
  color("burlywood")cube([foot(6),38,90],center=true);
  echo("2x4 6 feet");
}

module lumber8feet2x4()
{
  color("tan")cube([foot(8),38,90],center=true);
  echo("2x4 8 feet");
}

module joistHanger2x4()
{
  color("steelblue")
  translate([0,-inch(3.13)/2,-nominal(4)/2+inch(1)])
  {
    translate([(nominal(2)/2),0,0])cube([metThick,inch(3.13),inch(2)],center=true);
    translate([-(nominal(2)/2),0,0])cube([metThick,inch(3.13),inch(2)],center=true);
    translate([0,0,-inch(1)])cube([nominal(2),inch(3.13),metThick],center=true);
    translate([(nominal(2)-metThick+(inch(3.56)-nominal(2))/2)/2,(inch(3.13)-metThick)/2,0])cube([(inch(3.56)-nominal(2))/2,metThick,inch(2)],center=true);
    translate([-(nominal(2)-metThick+(inch(3.56)-nominal(2))/2)/2,(inch(3.13)-metThick)/2,0])cube([(inch(3.56)-nominal(2))/2,metThick,inch(2)],center=true);
  }
  echo("joisthanger 2x4");
}

module framingAngle()
{
  height=inch(2.5);
  width=inch(1.4375);
  color("steelblue")
  {
    translate([0,width/2,0])cube([metThick,width,height],center=true);
    rotate([0,0,-90])translate([0,width/2,0])cube([metThick,width,height],center=true);
  }
  echo("Framing angle");
}

module deckBoard()
{
  color("LightGray")
  {
    cube([foot(8),inch(5.5),deckThick()],center=true);
  }
  echo("deckBoard");
}

module faciaFront()
{
  color("Gray")
  {
    cube([foot(8),deckThick(),inch(5.5)],center=true);
  }
  echo("faciaFront");
}

module faciaSide()
{
  color("DarkGray")
  rotate([0,0,90])
  {
    cube([foot(6)+2*nominal(2)+deckThick(),deckThick(),inch(5.5)],center=true);
  }
  echo("faciaSide");
}

module deckFastener()
{
  color("black") cube([inch(0.5),inch(0.5),deckThick()],center=true);
  echo("deck fasterner");
}

module camoBlock()
{
  side=inch(15.75);
  height=inch(5.5)-nominal(4);
  totalheight=inch(3.5);
  slot=inch(1.625);
  
  translate([0,0,-height/2])
  color("DarkSlateGray")
  {
    cube([side,side,height],center=true);
    translate([0,0,(totalheight-height)/2+height/2])difference()
    {
      cube([side, side, totalheight-height],center=true);
      cube([slot,1000,100],center=true);
      cube([1000,slot,100,],center=true);
    }
  }
  echo("Footing Camo block");
}

camoBlock();