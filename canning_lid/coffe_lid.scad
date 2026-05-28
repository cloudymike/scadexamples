use <canning_jar_lids.scad>

module intext(text="")
{
    linear_extrude(height = 1.001)
    {
        mirror([0,1,0])
        text(text, 
            // font = "Liberation Sans:style=Regular",
            font = "Liberation Sans:style=Bold",
            //font  = "Liberation Serif:style=Regular",
            // font="Arial:style=Normal", 
            //font="Liberation Mono:style=Bold",
            size=8, spacing=1.1,
            halign="center", 
            valign="baseline");
    }
}

module coffee_lid(top="Coffee", middle="Coffee", bottom="Coffee")
{
    difference()
    {
        canning_jar_lid(jar_size="narrow", top_thickness=2);
        //translate([0,0,1])cylinder(h=2,d=67.2,center=true);
    
        translate([0,0,0]) intext(middle); 
        translate([0,10,0]) intext(bottom); 
        translate([0,-10,0]) intext(top); 
    }
}

//coffee_lid("New","Classic", "Espresso");
coffee_lid("","Robusta", "");