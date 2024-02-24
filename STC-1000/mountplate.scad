
//Make this as functions so accessable outside of file
function mountplate_depth()=78.5;
function mountplate_width()=143.7;
function mountplate_thickness()=2;


module mountplate()
{
    hole_diameter=5;
    hole_frontback=12+hole_diameter/2;
    hole_side=7.8+hole_diameter/2;
    
    
    thickness=mountplate_thickness();
    width=mountplate_width();
    depth=mountplate_depth();
    
    hole_x=width/2-hole_side;
    hole_y=depth/2-hole_frontback;
    
    echo("Hole distance X",hole_x*2);
    
    difference()
    {
        cube([width,depth,thickness],center=true);
        translate([hole_x,hole_y,0])cylinder(d=hole_diameter,h=thickness,center=true,$fn=64);
        translate([-hole_x,hole_y,0])cylinder(d=hole_diameter,h=thickness,center=true,$fn=64);
        translate([hole_x,-hole_y,0])cylinder(d=hole_diameter,h=thickness,center=true,$fn=64);
        translate([-hole_x,-hole_y,0])cylinder(d=hole_diameter,h=thickness,center=true,$fn=64);
        
        //cube([110,60,2],center=true);
    }
    
    
    
}

mountplate();