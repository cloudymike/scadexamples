use <onecorner.scad>


module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [-w,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [-w,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}


module twocorner(angle=0)
{

    offset=2;
    rotate([0,0,-angle/2])onecorner(offset);
    rotate([0,0,angle/2])mirror([1,0,0])onecorner(offset);

    if (angle > 0)
    {       
        translate([0,cos(angle/2)*fanwidth(),0])rotate([90,0,0])prism(tablength(),sin(angle/2)*fanwidth()+0.1,cos(angle/2)*fanwidth()+0.1);
    }
}


twocorner(30);

 