//Draw a prism based on a 
//right angled triangle
//l - length of prism
//w - width of triangle
//h - height of triangle
//From https://github.com/orionrobots/openscad_parts_library/blob/master/prism.scad
module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

prism(1,2,3);