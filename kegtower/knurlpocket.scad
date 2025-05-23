//Module to create a knurl pocket suitable for Heat-set inserts

// Articles about knurl insert
//https://hackaday.com/2019/02/28/threading-3d-printed-parts-how-to-use-heat-set-inserts/
//https://clevercreations.org/brass-threaded-inserts-plastic-3d-printing/

//Global vars
$fa = 1;
$fs = 0.2;
knurl_radius = 3.3;
knurl_wall = 3.5;


module m5knurl_ring(knurl_depth = 5)
{

    difference() {   
        cylinder(h=knurl_depth, r=knurl_radius+knurl_wall,center=true);
        m5knurl_pocket(knurl_depth);
    }
    
}

module m5knurl_pocket(knurl_depth = 5)
{
 union() {
    cylinder(h=knurl_depth+0.001, r=knurl_radius, center=true);
    translate([0,0,0.4*knurl_depth])
        cylinder(h=0.25 * knurl_depth, r1=knurl_radius, r2=1.2*knurl_radius, center=true);
 }
}

m5knurl_ring(8);
translate([15,0,0]) m5knurl_pocket();
