//Module to create a knurl pocket suitable for Heat-set inserts

// Articles about knurl insert
//https://hackaday.com/2019/02/28/threading-3d-printed-parts-how-to-use-heat-set-inserts/
//https://clevercreations.org/brass-threaded-inserts-plastic-3d-printing/

//Global vars
$fa = 1;
$fs = 0.2;
function knurl_radius(M=5) = 
    (M==5) ? 3.3 : 
    (M==4) ? 2.8 : 
    (M==3) ? 2.5 : 
    (M==2) ? 1.5 : 
    0;
function knurl_wall(M=5) = 
    (M==5) ? 3.5 : 
    (M==4) ? 3.0 : 
    (M==3) ? 2.5 :
    (M==2) ? 2.5 :
    0;


module Mknurl_ring(knurl_depth = 5, Msize=5)
{

    difference() {   
        cylinder(h=knurl_depth, r=knurl_radius(Msize)+knurl_wall(Msize),center=true);
        Mknurl_pocket(knurl_depth, Msize);
    }
    
}

module Mknurl_pocket(knurl_depth = 5,Msize=5)
{
 union() {
    cylinder(h=knurl_depth+0.001, r=knurl_radius(Msize), center=true);
    translate([0,0,0.4*knurl_depth])
        cylinder(h=0.25 * knurl_depth, r1=knurl_radius(Msize), r2=1.2*knurl_radius(Msize), center=true);
 }
}

Mknurl_ring(5,4);
