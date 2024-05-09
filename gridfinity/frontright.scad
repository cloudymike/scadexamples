use <baseplatemodule.scad>
mirror([1,0,0])
difference () {
  sizeX=178;
  sizeY=136;
  
  rowX=4;
  rowY=3;

  myBaseplate(4,3,178,136);
  deltaX=sizeX-rowX*42;
  deltaY=sizeY-rowY*42;
  notchX=1;
  notchY=7;
  translate([-((4*42))/2-deltaX,-(3*42)/2-deltaY/2,0])cube([notchX,notchY,20],center=true);
  
}
  
  
  