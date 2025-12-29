
largeD=75;
smallD=60;
height=50;

wallwidth=2;


module flat_heart() {
  square(20);

  translate([10, 20, 0])
  circle(10);

  translate([20, 10, 0])
  circle(10);
}
module sizeHeart(size) {
  square(size);

  translate([size/2, size, 0])
  circle(size/2);

  translate([size, size/2, 0])
  circle(size/2);
}
module horizontalHeart(depth,size)
{
    heartCenter=-size*15.6/20;
    translate([0,0,heartCenter])
    rotate([90,-45,0])
    linear_extrude(height = depth) 
    sizeHeart(size);
}
module onebottle(bottleD)
{
   difference()
   {
       cylinder(d=bottleD+2*wallwidth,h=height,center=true,$fn=128);
       translate([0,0,wallwidth])cylinder(d=bottleD,center=true,h=height,$fn=128);
   }
}
difference()
{
    translate([-largeD/2-wallwidth/2,0,0])onebottle(largeD);
    translate([-largeD/2+wallwidth/2,0,0])horizontalHeart(largeD,18);
}
difference()
{
    translate([smallD/2+wallwidth/2,0,0])onebottle(smallD);
    translate([smallD/2+wallwidth/2,0,0])horizontalHeart(smallD,14);
}