use <../Hose_Adaptor/hose_adaptor_module.scad>
$fn = 100*1;


Hose_Adaptor(
    // Outer Diameter (bottom)
    outer_diameter_1 = 9.6,
    // Wall Thickness (bottom)
    wall_thickness_1 = 2,
    // Rib Thickness (bottom), set to Zero to remove
    barb_size_1 = 0,
    // Length (bottom)
    length_1 = 10,
    // Outer Diameter (top), should be smaller than or equal to Outer Diameter (bottom)
    outer_diameter_2 = 9.525,  //3/8 inch
    // Wall Thickness (top)
    wall_thickness_2 = 2,
    // Rib Thickness (top), set to Zero to remove
    barb_size_2 = 0.75,
    // Length (top)
    length_2 = 11,
    // Middle Diameter
    mid_diameter = 14,
    // Middle Length
    mid_length = 3
);