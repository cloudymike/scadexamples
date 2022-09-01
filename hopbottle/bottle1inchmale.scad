use <../threads/isothreads.scad>
//Global rendering vars
$fa = 1;
$fs = 0.4;
NOZZLE_WIDTH=0.4;
OVEREXTRUSION = NOZZLE_WIDTH / 2;
OE_inch = OVEREXTRUSION / 25.4;
echo (str ("Overextrusion in inch: ", OE_inch));


//1=rough, 2=test; 3=final
precision=3;
//thickness of the cap
wallThickness=2;
//inner diameter of cap, excluding thread (i.e. outer diameter of neck plus threads)
innerDiameter=28;
//inner depth of cap
innerDepth=9.78;
//thread pitch (inter-thread pitch if multiple)
threadPitch=3;
//thread depth
threadDepth=1.5;
//thread width
threadWidth=1.5;
//number of turns per thread
threadTurns=2;
//number of threads
threads=1;
//start of thread from cap bottom
threadStart=1;
//number of ridges on cap
ridges=25;
//number of facets on thread and ridges
smoothness=(precision==1)?4:((precision==2)?6:20);
//number of thread segments in asingle turn
facets=(precision==1)?6:((precision==10)?20:50);
segments=facets*threadTurns;

//Do not use $fn
//$fn=max(20,facets);
$fn=0;

topThickness = 20;

module capThread()
{
  union()
  {
    for(thread=[0:threads-1])
    {
      rotate([0,0,360*thread/threads])
      translate([innerDiameter/2,0,wallThickness+innerDepth-threadStart-threadTurns*threadPitch*threads-threadWidth/2])
      scale([threadDepth,threadDepth,threadWidth/2])sphere(r=1,$fn=smoothness);
      rotate([0,0,360*thread/threads+threadTurns*360])
      translate([innerDiameter/2,0,wallThickness+innerDepth-threadStart-threadWidth/2])
      scale([threadDepth,threadDepth,threadWidth/2])sphere(r=1,$fn=smoothness);
    }
    for(twist=[0:segments-1])//
    {
      translate([0,0,wallThickness+innerDepth-threadStart-threadPitch*threadTurns*threads-threadWidth/2])
      union()
      {
        for(thread=[0:threads-1])
        {
          translate([0,0,threadPitch*threads*twist/segments*threadTurns])
          rotate([0,0,360*(thread/threads)+twist*360*threadTurns/segments])
          rotate([atan(threadPitch*threads/(innerDiameter*3.1416)),0,0])
          rotate_extrude(convexity = 10,angle=360/facets,$fn=50)
          translate([innerDiameter/2, 0, 0])
          scale([threadDepth,threadWidth/2,0])circle(r=1,$fn=smoothness);
        }
      }
    }
  }
}

module cap () {
union()
{
  capThread();

  difference()
  {
    //cap body
    union()
    {
      //outside
      translate([0,0,innerDepth/2+wallThickness])
      cylinder(h=innerDepth,r=(innerDiameter)/2+wallThickness,center=true);


      //top edge
      //translate([0,0,wallThickness])
      //rotate_extrude(convexity = 10)
      //translate([innerDiameter/2, 0, 0])
      //circle(r = wallThickness, $fn = smoothness);
    }
    //interior
    cylinder(h=innerDepth*4,r=innerDiameter/2,center=true);
  }

  translate([0,0,wallThickness*1.5])
  rotate([180,0,0])
  rotate_extrude(convexity = 10)
  translate([innerDiameter/2-wallThickness/2, 0, 0])
  difference()
  {
    square(wallThickness,center=false);
    circle(r = wallThickness/2, $fn = smoothness);
  }


  //top
  translate([0,0,wallThickness/2])cylinder(h=wallThickness,r=innerDiameter/2,center=true);
  translate([0,0,wallThickness/2])cylinder(h=wallThickness,r=innerDiameter/2+wallThickness,center=true);
  //translate([0,0,-topThickness/2])cylinder(h=topThickness,r=innerDiameter/2,center=true);

  //ridges
  for(ridge=[0:ridges-1])
  {
    hull()
    {
      rotate([0,0,360/ridges*ridge])
      translate([innerDiameter/2+wallThickness,0,wallThickness*5/4])
      sphere(r=wallThickness/4,$fn=smoothness);
      rotate([0,0,360/ridges*ridge])
      translate([innerDiameter/2+wallThickness,0,innerDepth+wallThickness*3/4])
      sphere(r=wallThickness/4,$fn=smoothness);
    }
  }
}
}

difference () {
    union () {
        cap();

        translate([0,0,0]) rotate([180,0,0])
          // Tapered.  Example -- pipe size 1/2" -- per:
          // http://www.engineeringtoolbox.com/npt-national-pipe-taper-threads-d_750.html

          // 1/2 inch
          //english_thread (diameter=0.840-OE_inch, threads_per_inch=14, length=3/4, taper=1/16);

          // 3/4 inch
          //english_thread (diameter=1.050-OE_inch, threads_per_inch=14, length=3/4, taper=1/16);

          // 1 inch
          english_thread (diameter=1.315-OE_inch, threads_per_inch=11.5, length=7/8, taper=1/16);
    }
    translate([0,0,-50]) cylinder(d=22,h=100);
}
