//===============================
//
//  No-tools micro motor mounts
//
//  Designed by Andrew Moore, May 2016
//      http://www.thingiverse.com/TacPar
//
//      For questions, suggestions, or whatever, 
//      please PM me through thingiverse.
//
//      This work is licensed under a Creative Commons 
//      Attribution-ShareAlike 4.0 International License.
//      http://creativecommons.org/licenses/by-sa/4.0/
//
//  This can be used with a variety of 12mm micro gear motors
//  Length dimensions may need to change to accomodate 
//  different gear ratios (particularly the Pololu 
//  1000:1 motors)
//
//  This design allows for a little slop in motor 
//  position.  You can always tighten that up with 
//  some shim stock after you insert the motor.
//
//  The mounting holes are arbitrarily set based on the plate dimensions
//  This could be improved.
//
//  If you use an encoder, you may have to solder it to the back of the 
//  motor after inserting the motor into the holder.
//===============================



//this is motor length without the gearbox
motor_length = 15;
//dimension for rounded sides on micro motor
motor_width = 12; 	
//flat sides on micro motor
motor_height = 10;
//length of the gear box not including the output shaft
gearbox_length = 10;

//wall thickness for the motor holder before tolerance losses
housing_thickness = 3;

//this defines how oversized the hole is for the motor
//this will reduce the effective housing thickness above
tolerance = 0.25;

plate_width = 40;

plate_length = motor_length+gearbox_length;

module MicroGearMotorMount(
  plate_thickness = 3
)
{
	//backplate()
	difference()
	{
		positives();
		negatives();
	}
	//add ons in areas that were erased...
	
	//back plate
	translate([plate_length/2-motor_length/2,0,-(motor_height/2+plate_thickness/2)]) BackPlate(plate_thickness);

	module positives()
	{
		//motor holding ring
		rotate([0,90,0]) 
            translate([0,0,0]) 
            cylinder(r=motor_width/2+housing_thickness, h=motor_length, center=true, $fn=40);

		translate([0,0,-motor_height/2+plate_thickness]) 
            cube([motor_length,motor_width+2*housing_thickness,motor_height-plate_thickness], center=true);

	}

	module negatives()
	{
		//cut off cylinder below the mounting plate
		translate([0,0,-(motor_height/2+plate_thickness-0.01)]) 
            cube([100,100,2*plate_thickness], center=true);

		//keyed shaft
		rotate([0,90,0]) 
        translate([0,0,-motor_length/2-0.1]) keyshaft(); 
        //translate([0,0,-motor_height/4]) cube([motor_length+.1,motor_width+1,motor_height/2], center=true);
		
	}
    module keyshaft()
    {
        difference()
		{
			positives();
            negatives();
            
			
		}
        module positives()
        {
            cylinder(r=motor_width/2+tolerance, h=motor_length+1, $fn=50);
        }
        
        module negatives()
        {
            translate([-motor_height-tolerance,0,motor_length/2+tolerance]) cube([motor_height,motor_width,motor_length+2],center=true);
            translate([motor_height+tolerance,0,motor_length/2+tolerance]) cube([motor_height,motor_width,motor_length+2],center=true);
        }
    }
  }


module BackPlate(plate_thickness=3,tab=true,screw_radius=1.75)
	{
      tongue_thickness=2;
      tab_height = tongue_thickness+2;
      tab_width = 5;
      tab_thickness = 1.5;

      difference()
      {
        positives();
        negatives();
      }
        
      module positives()
      {
          cube([plate_length,plate_width,plate_thickness],center=true);
      }
      module negatives()
      {
          mount_holes();
        if (tab) {tab_slots();}
      }
        
      module mount_holes()
      {
        rotate([0,0,0]) 
                  translate([plate_length/2-4,plate_width/2-4,0]) 
                  cylinder(r=screw_radius, h=plate_thickness+1, $fn=40, center=true);
        rotate([0,0,0])
                  translate([plate_length/2-4,-(plate_width/2-4),0]) 
                  cylinder(r=screw_radius, h=plate_thickness+1, $fn=40, center=true);
        rotate([0,0,0])
                  translate([-(plate_length/2-4),plate_width/2-4,0]) 
                  cylinder(r=screw_radius, h=plate_thickness+1, $fn=40, center=true);
        rotate([0,0,0])
                  translate([-(plate_length/2-4),-(plate_width/2-4),0]) 
                  cylinder(r=screw_radius, h=plate_thickness+1, $fn=40, center=true);
        
      }
      
      module tab_slots()
      {
        translate([0.4*plate_length,tab_width/2, 0]) cube([plate_length,1,plate_thickness+1], center=true);
        translate([0.4*plate_length,-tab_width/2, 0]) cube([plate_length,1,plate_thickness+1], center=true);
        
        // If the tongue needs to be thinner
        translate([0.4*plate_length,0, -tongue_thickness]) cube([plate_length,tab_width,plate_thickness], center=true);
      }
	

	   //gearbox tab ... stops motor from sliding forward
      if (tab)
      {
        translate([plate_length/2+tab_thickness/2,0,plate_thickness/2]) cube([tab_thickness,tab_width-1,tab_height], center=true);
        
        //Print a very thin support that will break, so tab can be printed in upright rotation
        support_thickness=0.1;
        translate([plate_length/2,(tab_width-1)/2,plate_thickness/2])rotate([0,0,180])prism(support_thickness,tab_height-tongue_thickness,tab_height-tongue_thickness);
        translate([plate_length/2,-(tab_width-1)/2+support_thickness,plate_thickness/2])rotate([0,0,180])prism(support_thickness,tab_height-tongue_thickness,tab_height-tongue_thickness);
      }
}

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

MicroGearMotorMount();
