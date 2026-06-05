//Module to create a knurl pocket suitable for Heat-set inserts
use <../mscrew/knurlpocket.scad>

module m5knurl_ring(knurl_depth = 5)
{
    Msize=5;
    Mknurl_ring(knurl_depth, Msize);
}
module m5knurl_pocket(knurl_depth = 5)
{
    Msize=5;
    Mknurl_pocket(knurl_depth, Msize);
}

m5knurl_ring(8);
translate([15,0,0]) m5knurl_pocket();
