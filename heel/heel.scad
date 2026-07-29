//use <traced_plastic_piece.scad>
use <mod_traced_plastic_piece.scad>
//use <trace_sharp.scad>

$fn=64;
sf=28/26;
cutF=16/26;
difference()
{
linear_extrude(height=5.2, convexity=10, scale=20/28)
    scale([sf,sf])plastic_piece_2d();

translate([0,0,5.2-2.4])linear_extrude(height=2.4, convexity=10)
    scale([cutF,cutF])plastic_piece_2d();


}




//translate([0,0,5.2])linear_extrude(height=0.01, convexity=10)
//    scale([20/28,20/28,1])plastic_piece_2d();
