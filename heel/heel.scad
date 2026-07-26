use <traced_plastic_piece.scad>

$fn=64;

linear_extrude(height=5.2, convexity=10, scale=20/28)
    plastic_piece_2d();
    
//translate([0,0,5.2])linear_extrude(height=0.01, convexity=10)
//    scale([20/28,20/28,1])plastic_piece_2d();
