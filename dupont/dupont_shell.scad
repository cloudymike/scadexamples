// remixed the model from Jaap_aap
//
// connector pins are numbered this way
// row 1:   1 - 2 - 3 - 4 - 5 .... n
// row 2:   n+1 - n+2, n+3 .... 2n
// change the 4 settings below to customize your connector]

//number of connector rows
rows = 1;  // [1, 2]
pins = 3;  // number of pins per row
show_pin1 = true; // show the triangle indicator for pin 1
triangle_height = 1.0;
pin1_triangle = show_pin1?triangle_height:0;
keys = []; // slots to be filled solid for keying the connector

spacing = 2.54; // pin to pin spacing 2.54mm
wall = 0.54;    // shell wall thickness
length = 14;  // connector length
function cavity(s,w) = s-w; // shell cavity to hold the connector pin;

// each pin shell will consist of the cavity and a wall on each side
// the walls on adjacent shells will overlap
function shell(c,w) = c+(2*w);

// for inverting offset values between row 1 and 2
pos_neg = [1,1,-1];

module triangle(p1_triangle_height,sh){
  linear_extrude(p1_triangle_height)
    polygon(points = [[-sh/2,0],[0,sh*0.85],[sh/2,0]], paths = [[0,1,2,0]]);
}

module add_shell(pin, row, filled_position, p1_triangle_height, sp, w, l, c, sh) {
    tab_cavity_length = 5;
    tab_length = 4.5;
    tab_hole_pos = (l - tab_cavity_length)/2 -3.9;// 3.9mm from the end
    tab_pos = tab_hole_pos - tab_cavity_length -0.8 + tab_length; 
    translate([sh/2, l/2, sh/2])
    union(){
        difference(){
            // draw the basic block
            translate([0,0,0])cube([sh,l,sh], center = true);

            if (filled_position != true){
                // hollow out space for the pin body, but leave an end
                // in place to prevent the pin from going all the way through
                translate([0,-1,0])cube([c,l,c],center = true);

                // put a smaller hole in the opposite end for receiving the mating pin
                // make a square rod for the hole using the cylinder command with
                // only 4 facets for the perimeter surface
                rotate([90, 45, 0])
                cylinder(r = 0.4*c, h = l+6, center = true, $fn = 4);

                // now chamfer that end
                translate([0, l/2, 0])rotate([90, 45, 0])
                cylinder(r1 = 1.25*c, r2 = 0.4*c, h = c/4,
                         center = true, $fn = 4);

                // make the hole for the tab
                translate([0, tab_hole_pos, pos_neg[row]*(c+w)/2])
                cube([0.9*c, tab_cavity_length, w], center = true);
                
            }
        }
        // add the tab
        translate([0, tab_pos,
                   pos_neg[row]*(c+w)/2])
        cube([0.9*c - 1.5*w, tab_length, w], center = true);
        
        // if the top row, make a break-away support for the tab
        if (row == 1){
            
            translate([0, tab_pos+2,
                       pos_neg[row]*((c+w/2)/2-0.1)])
            cube([c, 0.5, 0.15], center = true);
        }    
        
        // if pin 1 add the triangle indicator
        if (pin==1 && row==1 && p1_triangle_height>0){
            translate([0,l/2-sh, c/2+w])
            triangle(p1_triangle_height,sh);
         }
    }
}

module tests(r,p,k,p1_t){
  assert((r==1 || r==2), "rows must be 1 or 2");
  assert(p>=1, "pins must be >=1");
  assert(is_list(k), "keys must be a list");
  assert(p1_t >=0, "triangle_height must be >= 0");
  
}
module dupont_connector(r,p,k,p1_t=1.5,sp=2.54,w=0.54,l=14){
  tests(r,p,k,p1_t);
  c = cavity(sp, w); // cavity
  sh = shell(c,w); // shell
  for(j = [1:r]) {
      for(i = [1:p]) {
          translate([(i - 1) * sp,0,(r - j) * sp])
          render() add_shell(i, j, search(i + (j - 1) * p, k)==[]?false:true,p1_t, sp, w, l, c, sh);
      }
  }
}

function dupont_connector_size(r,p,k,p1_t=1.5,sp=2.54,w=0.54,l=14) = [
  (((sp-w)+(2*w))*p)-w*(p-1),
  l,
  (((sp-w)+(2*w))*r)-w*(r-1)];

module dupont_connector_solid(r,p,k,p1_t=1,sp=2.54,w=0.54,l=14){
  tests(r,p,k,p1_t);
  shell_size = dupont_connector_size(r,p,k,p1_t,sp,w,l);
  c = cavity(sp, w);
  sh = shell(c,w);
  union(){
    cube(shell_size);
    if(p1_t >=0)
      translate([0,0,shell_size[2]])
        translate([sh/2,l-sh, 0])
        triangle(p1_t, sh);
  }
}


//difference() {dupont_connector(rows,pins,keys,pin1_triangle,spacing,wall,length); cube([20,20,2]);}

dupont_connector(rows,pins,keys,pin1_triangle,spacing,wall,length);
