//Module to create a knurl pocket suitable for Heat-set inserts

// Articles about knurl insert
//https://hackaday.com/2019/02/28/threading-3d-printed-parts-how-to-use-heat-set-inserts/
//https://clevercreations.org/brass-threaded-inserts-plastic-3d-printing/

//Global vars
$fa = 1;
$fs = 0.2;
knurl_radius = 2.5;
knurl_m2_radius = 1.5;
knurl_wall = 2.5;


module m3knurl_ring(knurl_depth = 5)
{

    difference() {   
        cylinder(h=knurl_depth, r=knurl_radius+knurl_wall,center=true);
        m3knurl_pocket(knurl_depth = 5);
    }   
}

module m3knurl_pocket(knurl_depth = 5)
{
 union() {
    cylinder(h=knurl_depth+0.001, r=knurl_radius, center=true);
    translate([0,0,0.4*knurl_depth])
        cylinder(h=0.25 * knurl_depth, r1=knurl_radius, r2=1.2*knurl_radius, center=true);
 }
}





module m2knurl_ring(knurl_depth = 5)
{

    difference() {   
        cylinder(h=knurl_depth, r=knurl_m2_radius+knurl_wall,center=true);
        m2knurl_pocket(knurl_depth);
    }   
}


module m2knurl_pocket(knurl_depth = 5)
{
 set_depth=1;
 union() {
    cylinder(h=knurl_depth+0.001, r=knurl_m2_radius, center=true);
    translate([0,0,(knurl_depth-set_depth)/2])
        cylinder(h=set_depth, r1=knurl_m2_radius, r2=1.2*knurl_m2_radius, center=true);
 }
}

module standoff_m2(height=11)
{
  translate([0,0,height/4])m2knurl_ring(height/2);
  translate([0,0,-height/4])mirror([0,0,1])m2knurl_ring(height/2);
}

//m3knurl_ring();
//translate([10,0,0]) m3knurl_pocket();
//translate([0,10,0]) m2knurl_ring(11);
//translate([10,10,0]) m2knurl_pocket();

standoff_m2(11);