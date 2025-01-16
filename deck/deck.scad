use <material.scad>
use <dimlines.scad>

// Use modules for major components to easily work and see each component


module framing()
{
  //center
  rotate([0,0,90])lumber6feet2x4();
  //center joists
  translate([0,foot(3),0])joistHanger2x4();
  translate([0,-foot(3),0])rotate([0,0,180])joistHanger2x4();
  
  //ends
  translate([foot(4)-nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
  translate([-foot(4)+nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
  
  //framing angles
  translate([foot(4)-nominal(2),foot(3),0])rotate([0,0,180])framingAngle();
  translate([foot(4)-nominal(2),-foot(3),0])rotate([0,0,90])framingAngle();
  translate([-foot(4)+nominal(2),foot(3),0])rotate([0,0,-90])framingAngle();
  translate([-foot(4)+nominal(2),-foot(3),0])rotate([0,0,0])framingAngle();
  
  //rafters
  translate([inch(16)-nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
  translate([inch(32)-nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
  translate([-inch(16)+nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
  translate([-inch(32)+nominal(2)/2,0,0])rotate([0,0,90])lumber6feet2x4();
  
  //rafter joists
  translate([inch(16)-nominal(2)/2,foot(3),0])joistHanger2x4();
  translate([inch(16)-nominal(2)/2,-foot(3),0])rotate([0,0,180])joistHanger2x4();
  translate([inch(32)-nominal(2)/2,foot(3),0])joistHanger2x4();
  translate([inch(32)-nominal(2)/2,-foot(3),0])rotate([0,0,180])joistHanger2x4();
  translate([-inch(16)+nominal(2)/2,foot(3),0])joistHanger2x4();
  translate([-inch(16)+nominal(2)/2,-foot(3),0])rotate([0,0,180])joistHanger2x4();
  translate([-inch(32)+nominal(2)/2,foot(3),0])joistHanger2x4();
  translate([-inch(32)+nominal(2)/2,-foot(3),0])rotate([0,0,180])joistHanger2x4();
  
  //rafter measure
  rafterD=inch(16)-nominal(2)/2;
  rafterDinch=round(rafterD/2.54)/10;
  translate([0,810,nominal(4)])dimensions(length=rafterD,mytext=str(rafterD));
  translate([0,655,nominal(4)])dimensions(length=rafterD,mytext=str(rafterDinch));
  
  translate([0,foot(3)+nominal(2)/2,0])lumber8feet2x4();
  translate([0,-foot(3)-nominal(2)/2,0])lumber8feet2x4();
  
  myl=round(foot(8)+2*deckThick());
  mylinch=round(myl/2.54)/10;
  translate([-foot(4),1000,0])dimensions(length=myl,mytext=str(myl));
  translate([-foot(4),1100,0])dimensions(length=myl,mytext=str(mylinch));

  myFY=round(foot(6)+2*nominal(2)+deckThick());
  myFYinch=round(myFY/2.54)/10;
  translate([-1300,-myFY/2+deckThick()/2,0])rotate([0,0,90]) dimensions(length=myFY,mytext=str(myFY));
  translate([-1400,-myFY/2+deckThick()/2,0])rotate([0,0,90]) dimensions(length=myFY,mytext=str(myFYinch));
}

module decking()
{
  //start from front (4 foot) and work backwards to end (-4 foot)
  //Step 6 inches at a time. There should be 0.5 inch gap between boards
  for (boardY = [foot(3):-inch(6):-foot(3)]) 
  {
    if (boardY > -foot(3)+1)
      translate([0,boardY-inch(5.5)/2+nominal(2),(nominal(4)+deckThick())/2])deckBoard();
    else
      translate([0,boardY-inch(5.5)/2+nominal(2),(nominal(4)+deckThick())/2])deckStripped();
    for(raft= [foot(4):-inch(16):-foot(4)])
    {
      adjust = (raft < 0) ? nominal(2)/2 : (raft>1) ? -nominal(2)/2 : 0;
      if (boardY > -foot(3)+1)
        translate([raft+adjust,boardY+nominal(2)-inch(5.75),(nominal(4)+deckThick())/2])deckFastener();
    }
  }
  
  translate([0,foot(3)+nominal(2)+deckThick()/2,0])faciaFront();
  translate([foot(4)+deckThick()/2,deckThick()/2,0])faciaSide();
  translate([-foot(4)-deckThick()/2,deckThick()/2,0])faciaSide();


}

module footing()
{
  concreteFooting();
  
}
module camoFooting()
{
  
  translate([0,foot(3)-inch(16),-nominal(2)/2])camoBlock();
  translate([0,-foot(3)+inch(16),-nominal(2)/2])camoBlock();
  translate([inch(32)-nominal(2)/2,foot(3)-inch(16),-nominal(2)/2])camoBlock();
  translate([inch(32)-nominal(2)/2,-foot(3)+inch(16),-nominal(2)/2])camoBlock();
  translate([-inch(32)+nominal(2)/2,foot(3)-inch(16),-nominal(2)/2])camoBlock();
  translate([-inch(32)+nominal(2)/2,-foot(3)+inch(16),-nominal(2)/2])camoBlock();
  
  myh=round(inch(2)+nominal(4)+deckThick());
  myhinch=round(myh/2.54)/10;
  translate([1500,100,nominal(4)/2])rotate([0,90,0]) dimensions(length=myh,mytext=str(myh));
  translate([1500,200,nominal(4)/2])rotate([0,90,0]) dimensions(length=myh,mytext=str(myhinch));

}
module concreteFooting()
{
  
  translate([0,foot(3)-inch(16),-inch(2)])concreteBlock();
  translate([0,-foot(3)+inch(16),-inch(2)])concreteBlock();
  translate([inch(32)-nominal(2)/2,foot(3)-inch(16),-inch(2)])concreteBlock();
  translate([inch(32)-nominal(2)/2,-foot(3)+inch(16),-inch(2)])concreteBlock();
  translate([-inch(32)+nominal(2)/2,foot(3)-inch(16),-inch(2)])concreteBlock();
  translate([-inch(32)+nominal(2)/2,-foot(3)+inch(16),-inch(2)])concreteBlock();
  
  myh=round(inch(5.5)+deckThick());
  myhinch=round(myh/2.54)/10;
  translate([1500,100,nominal(4)/2])rotate([0,90,0]) dimensions(length=myh,mytext=str(myh));
  translate([1500,200,nominal(4)/2])rotate([0,90,0]) dimensions(length=myh,mytext=str(myhinch));

  myFX=round(inch(32)-nominal(2)/2);
  myFXinch=round(myFX/2.54)/10;
  translate([0,-1100,nominal(4)/2])rotate([0,0,0]) dimensions(length=myFX,mytext=str(myFX));
  translate([0,-1200,nominal(4)/2])rotate([0,0,0]) dimensions(length=myFX,mytext=str(myFXinch));

  myFY2=round(nominal(2)+inch(16));
  myFY2inch=round(myFY2/2.54)/10;
  translate([-1500,-foot(3)+inch(16)-myFY2,0])rotate([0,0,90]) dimensions(length=myFY2,mytext=str(myFY2));
  translate([-1600,-foot(3)+inch(16)-myFY2,0])rotate([0,0,90]) dimensions(length=myFY2,mytext=str(myFY2inch));
}


module adjustFooting()
{

    for(raft= [foot(4)-inch(16):-inch(16):-foot(4)+inch(16)])
    {
      adjust = (raft < 0) ? nominal(2)/2 : (raft>1) ? -nominal(2)/2 : 0;
      translate([raft+adjust,foot(3)-inch(16),-nominal(4)/2])adjustFoot();
      translate([raft+adjust,-foot(3)+inch(16),-nominal(4)/2])adjustFoot();
      if (raft<-10 || raft > 10)
      translate([raft+adjust,0,-nominal(4)/2])adjustFoot();
      echo(raft);
    }
  

  myh=round(inch(2)+nominal(4)+deckThick());
  myhinch=round(myh/2.54)/10;
  translate([1500,100,nominal(4)/2])rotate([0,90,0]) dimensions(length=myh,mytext=str(myh));
  translate([1500,200,nominal(4)/2])rotate([0,90,0]) dimensions(length=myh,mytext=str(myhinch));
}

footing();
framing();
decking();
translate([0,-foot(3)-nominal(2)-nominal(2)/2,0])lumber10feet2x4();

