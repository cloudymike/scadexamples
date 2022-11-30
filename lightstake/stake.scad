use <stakethread.scad>

$fa = 1;
$fs = 0.4;

module blade(h=100,b=10,w=2) {
    rotate(a=[90,-90,0])
    linear_extrude(height = w, center = true, convexity = 10, twist = 0)
    polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);
}

module stake(h=100,b=10,w=2) {
    blade(h,b,w);
    rotate([0,0,90]) blade(h,b,w);
    rotate([0,0,180]) blade(h,b,w);
    rotate([0,0,270]) blade(h,b,w);
}

thread_depth=10;
stakethread(thread_depth);
translate([0,0,thread_depth]) stake(100,8,2);



