use <microGearMotorMount.scad>


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

plate_thickness=5;
screw_radius=2.5;
corner_radius=20;

sqr2=1.4142;

rotate([0,0,0])BackPlate(plate_thickness=plate_thickness, tab=false, screw_radius=screw_radius);

cube_side = plate_width/sqr2;
difference() 
{
translate([0,0,plate_thickness/2])rotate([45,0,0])cube([plate_length,cube_side,cube_side],center=true);
translate([0,0,-cube_side/2]) cube([plate_length,plate_width,cube_side],center=true);
translate([0,0,plate_thickness])rotate([0,0,0])mount_holes();
translate([0,0,20])cube([plate_length, plate_width,20],center=true);
}
//difference() {
Corner(plate_length,plate_width,corner_radius,plate_thickness);
//translate([0,0,plate_thickness])rotate([0,0,0])mount_holes();
//}
module Corner(length,width,corner_radius, plate_thickness)
{
translate([0,0,-(corner_radius*sqr2/2)+plate_thickness/2])
rotate([0,90,0])
{
difference () {
  cylinder(r=corner_radius,h=length, center=true, $fn=128);
  translate([corner_radius-(corner_radius*sqr2/2),0,0])cube([2*corner_radius,2*corner_radius,length],center=true);
}
}
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
