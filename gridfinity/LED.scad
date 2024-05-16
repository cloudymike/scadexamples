use <../gridfinity-rebuilt-openscad/gridfinity-rebuilt-bins.scad>

// AA battery holder
// Tries to pack as many as possible based on tile size
// Does not try to make it symmetric

$fn=120;
OverExtrusion = 0.2;
theanswer=42;
height7=4;
height = height7*7;
interval = 7;
diameter=5.5+2*OverExtrusion;
leadDiameter=0.7+2*OverExtrusion;
LEDdepth=2;

BoxUnits=42;
BoxLengthUnits=1;
BoxWidthUnits=1;
StyleHole=4; // [0:no holes, 1:magnet holes only, 2: magnet and screw holes - no printable slit, 3: magnet and screw holes - printable slit, 4: Gridfinity Refined hole - no glue needed]
WallAdjust = 1.5;
difference () {
  union () {
    gridfinityInit(BoxLengthUnits, BoxWidthUnits, height(height7), 0, theanswer) {}
    gridfinityBase(
      gx=BoxLengthUnits, 
      gy=BoxWidthUnits, 
      l=theanswer, 
      dx=0, 
      dy=0, 
      style_hole=4 
    );
  }
  translate([-BoxLengthUnits*BoxUnits/2,-BoxWidthUnits*BoxUnits/2,5])
    for (x=[interval/2+2*WallAdjust:interval:BoxUnits*BoxLengthUnits-diameter/2-WallAdjust])
      for (y=[interval/2+2*WallAdjust:interval:BoxUnits*BoxWidthUnits-diameter/2])
      {
          translate([x,y,height-LEDdepth/2-4.5]) cylinder(d=diameter,h=LEDdepth,center=true, $fn=64);
          translate([x+1.25,y,height/2]) cylinder(d=leadDiameter,h=height,center=true, $fn=64);
          translate([x-1.25,y,height/2]) cylinder(d=leadDiameter,h=height,center=true, $fn=64);
      }
}
