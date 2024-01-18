

use <../electrocookie/knurlpocket.scad>
use <../molex/molex_062_plugs_receptacles.scad>
use <../molex/molex_093_2_contact_connector_bodies.scad>
use <MCAD/boxes.scad>


//================Global=========================

//Global rendering vars
$fa = 1;
$fs = 0.4;
board_buffer = 3;
wall_depth = 2.5;
corner_radius=5;
knurl_depth = 5;
screw_radius = 1.75;
corner_screw_distance = 5;
tilesize = 15;
//================Variables=========================
//=======================================================


module plug062tile()
{
  difference () {
    cube([tilesize,tilesize,wall_depth],center=true);
    translate([0,0,0]) cube([3,7,wall_depth+0.01],center=true);
  }
  // Connectors
  translate([0,-2,-9.35]) rotate([0,0,90]) plug2();
}

module recep062tile()
{
  difference () {
    cube([tilesize,tilesize,wall_depth],center=true);
    translate([0,0,0]) cube([3,7,wall_depth+0.01],center=true);
  }
  // Connectors
  translate([0,-2,-9.5]) rotate([0,0,90]) recep2();
}

module recep093tile()
{
  
  difference () {
    cube([tilesize,tilesize,wall_depth],center=true);
    translate([0,0.2,0]) cube([4,10.4,wall_depth+0.01],center=true);
  }
  // Connectors
  rotate([0,0,180]) translate([0,-3,-14.8]) rotate([0,0,90]) receptacle();
}


module plug093tile()
{
  difference () {
    cube([tilesize,tilesize,wall_depth],center=true);
    translate([0,0,0]) cube([5,10,wall_depth+0.01],center=true);
  }
  // Connectors
  rotate([0,0,180]) translate([0,-3,-14.0]) rotate([0,0,90]) plug();
}


module topbox(
    fancount=3,
    coolercount=1,
    faninput=true,
    coolerinput=true,
    cablehole=true
    )
{
    top_height = 25;
    infancount = (faninput) ? 1:0;
    incoolercount = (coolerinput) ? 1:0;
    top_length = wall_depth*2+fancount*tilesize+coolercount*tilesize+infancount*tilesize+incoolercount*tilesize+tilesize;

    cable_radius=2;
    
    top_width = tilesize+2*wall_depth;
    echo("topbox size:",top_length,top_width,top_height);

    inside_length = top_length-2*wall_depth;
    tile_start = inside_length/2 - tilesize;
    inside_width = top_width-2*wall_depth;
    inside_height = top_height-wall_depth;
    inside_offset = wall_depth/2+0.01;

    difference() {
    union() {
    difference() {
      //top box walls
      roundedBox(size=[top_length,top_width,top_height],radius=corner_radius,sidesonly=true);
      translate([0,0,inside_offset])
        cube([inside_length,inside_width,inside_height],center=true);
      
      //Connector Holes
      //translate([0,2,0])cube([4,8,2*top_height],center=true);
      cube([top_length-4*corner_radius,top_width-2*wall_depth,top_height*10], center=true);
    }

    // Connector tiles
    input_start = tile_start;
    if (faninput)
    {
      translate([-input_start,0,-(top_height-wall_depth)/2])
        rotate([180,0,0]) 
          plug062tile();
    }
    if (coolerinput)
    {
      translate([-input_start+infancount*tilesize,0,-(top_height-wall_depth)/2])
        rotate([180,0,0]) 
          plug093tile();
    }
    fan_start = input_start-(infancount+incoolercount)*tilesize;
    if (fancount>0)
    {
        for (tile=[0:fancount-1]) {
          translate([tile*tilesize-fan_start,0,-(top_height-wall_depth)/2])
            rotate([180,0,0]) 
              recep062tile();
        }
    }

    cooler_start = fan_start-fancount*tilesize;
    if (coolercount>0)
    {
       for (tile=[0:coolercount-1]) {
          translate([tile*tilesize-cooler_start,0,-(top_height-wall_depth)/2]) rotate([180,0,0]) recep093tile();
       }
    }

    // screw columns
      translate([(top_length/2-corner_screw_distance),
        (top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius + wall_depth,h=top_height, center=true);
      translate([(top_length/2-corner_screw_distance),
        -(top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius + wall_depth,h=top_height, center=true);
      translate([-(top_length/2-corner_screw_distance),
        (top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius + wall_depth,h=top_height, center=true);
      translate([-(top_length/2-corner_screw_distance),
        -(top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius + wall_depth,h=top_height, center=true);
    }

    

    //screw holes
      translate([top_length/2-corner_screw_distance,
        top_width/2-corner_screw_distance,
        0])
        cylinder(r=screw_radius,h=top_height+0.01, center=true);
      translate([- (top_length/2-corner_screw_distance),
        top_width/2-corner_screw_distance,
        0])
        cylinder(r=screw_radius,h=2*top_height+0.01, center=true);
      translate([(top_length/2-corner_screw_distance),
        -(top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius,h=top_height+0.01, center=true);
      translate([-(top_length/2-corner_screw_distance),
        -(top_width/2-corner_screw_distance),
        0])
        cylinder(r=screw_radius,h=top_height+0.01, center=true);

    // cable holes
    if (cablehole)
    {
      translate([cable_radius-0.5,top_width/2,top_height/2-cable_radius-1])rotate([90,0,0]) cylinder(r=cable_radius,h=10,center=true);
      translate([-cable_radius+0.5,top_width/2,top_height/2-cable_radius-1])rotate([90,0,0]) cylinder(r=cable_radius,h=10,center=true);
    }

    }
}

topbox(
    fancount=0,
    coolercount=2,
    faninput=false,
    coolerinput=false,
    cablehole=true
    );