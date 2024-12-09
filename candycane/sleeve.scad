// model the candy cane tube
module tube(height=5)
{
  difference()
  {
    inner_d=22;
    
    cylinder(h=height, d=25.4, center=true, $fn=64);
    difference () {
      cylinder(h=height, d=inner_d, center=true, $fn=64);
      translate([-inner_d/2,-inner_d/2,-height])
        translate([-inner_d/4,0,0])slant(inner_d,inner_d,height*2);
    }
  }
}

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
module slant(d,d,h)
{
  prism(d,d,h);
}


module sleeve(depth=5, sleeve_d=29)
{
  floor_thickness = 2;
  difference()
  {
    cylinder(d=sleeve_d,h=depth+floor_thickness, center=true, $fn=64);
    translate([0,0,floor_thickness])rotate([180,0,0])tube(depth);
    //translate([0,0,floor_thickness+5])cylinder(h=depth,d=25,center=true);
  }
}

difference() 
{
  sleeve(29);
  translate([-14.5,0,-16]) cube([29,29,32]);
}



//slant(25,5);
//tube(15);