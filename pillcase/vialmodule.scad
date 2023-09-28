/*  makes 3 screw top containers
    and two tops for the containers
    containers are
    large
    small
    vial
    the same top fits the vial and small container
    i.e. small top
    the large top fits the large container

    mark = 1 makes large container
    mark = 2 makes large top
    mark = 3 makes vial
    mark = 4 makes small top
    mark = 5 makes small container



  uses threads.scad
  available at http://dkprojects.net/openscad-threads/

  pcm  September 2014

*/

use <../threads/isothreads.scad>


$fa=0.1;


//smalltop(15,7.5,4);
//vial();
smalltop();

//  makes vial bottom - uses small top
module vial(outside_radius=15, vial_height=50, lid_height=7.5, wall_thickness=6)
{

  inside_radius = outside_radius - wall_thickness;
  thread_diameter = (inside_radius + outside_radius) / 25.4; //english threads, inches 
  bottom_thickness = wall_thickness;
  thread_length = wall_thickness / 16; 
  scaling=1;
  threads_per_inch = 8 * scaling;
  
  echo (str ("outside_radius: ", outside_radius));
  echo (str ("inside_radius: ", inside_radius));
  echo (str ("Scale: ", scaling));

  scale(scaling)

  difference()
  {
    union()
    {
      english_thread(thread_diameter, threads_per_inch, thread_length);
      translate([0,0,-(vial_height/2)])
      cylinder(r=outside_radius,h=vial_height,center=true); 
    }
    translate([0,0,lid_height/2])
    cylinder(r=inside_radius,h=lid_height*2,center=true);
    translate([0,0,-((vial_height-bottom_thickness)/2)])
    cylinder(r=inside_radius,h=vial_height-1*bottom_thickness,center=true);
    
    // debug cut. Uncomment to see the interior
    //translate([0,0,-vial_height-1]) cube([outside_radius,outside_radius,2*vial_height]);
  }
}


// makes top for vial and small container
module smalltop(outside_radius=15,lid_height = 7.5, wall_thickness=6)
{
  inside_radius = outside_radius - wall_thickness;
  thread_diameter = (inside_radius + outside_radius) / 25.4; //english threads, inches 
  thread_length = wall_thickness / 16; 
  scaling=1;
  threads_per_inch = 8 * scaling;
  

  scale(scaling)
  difference()
  {
    
    translate([0,0,lid_height/2])
      cylinder(r=outside_radius,h=lid_height,center=true);
    //  1.02,1.02,1   - too tight
    //   1.1,1.1,1   -  too loose ok for half size
    //  1.05,1.05,1  -  not bad for full scale too tight for half scale
    translate([0,0,wall_thickness/4])
      scale([1.05,1.05,1])
        english_thread(thread_diameter, threads_per_inch, thread_length,internal=true);
    serrate(outside_radius,15,1,1,lid_height);

    // debug cut. Uncomment to see the interior
    //translate([0,0,-lid_height+1]) cube([outside_radius,outside_radius,2*lid_height]);
    
    
  }
}



module serrate(tr,tnum,cx,cy,cz)
{
  tx = tnum + 1;
  for ( i = [0 : tnum] )
  {
    translate ([tr*cos(i*(360/tx)),tr*sin(i*(360/tx)),0])
      rotate(  [0,0,i*(360/tx)])
        cube([cx,cy,cz*2],center=true);
  }
}


