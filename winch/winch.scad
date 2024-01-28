use <microGearMotorMount.scad>
use <slotguide.scad>
use <wheel.scad>


slotsteps=3;
slotheight=3;
wheel_spacer =2;

//this is motor length without the gearbox
motor_length = 15;
//dimension for rounded sides on micro motor
motor_width = 12; 	
//flat sides on micro motor
motor_height = 10;
//length of the gear box not including the output shaft
gearbox_length = 10;

plate_width = 35;
plate_length = motor_length+gearbox_length;
plate_thickness = 5;
plate_top=-motor_height/2;

plate_edge = gearbox_length+motor_length/2;

wheel_radius=motor_height/2+plate_thickness-1;
wheelWidth = 8.86;
slot_y_pos = -(wheel_radius);
slot_width = 8.86/2;
wheel_margin=3;
total_slot_height = slotheight*slotsteps*2+slotheight+motor_height/2+wheel_margin;

MicroGearMotorMount(plate_thickness=plate_thickness);

translate([plate_edge,slot_y_pos,wheel_margin]) wireguide(outer_radius=8.86/2,inner_radius=1,height=slotheight,steps=slotsteps,spacer_column=wheel_spacer);

translate([plate_edge,slot_y_pos,plate_top]) rotate([90,0,180]) slotholder(height=total_slot_height,length=plate_length,width=slot_width);

//For checking positioning
//translate([plate_edge+wheel_spacer,0,0]) rotate([0,90,0]) winch_wheel(flangesRadius=wheel_radius);


module slotholder(
  height=30,length=30,width=3)
{
  translate([0,0,-width/2])
    linear_extrude(height=width)
        {
            polygon(points=[[0,0],[length,0],[0,height]], paths=[[0,1,2]]);
        }
}

