//Make this as functions so accessable outside of file
function frontplate_thickness()=2;



module frontplate(height=40,width=80)
{
    minheight=34;
    minwidth=75;
    thickness=frontplate_thickness();
    
    cutout_height=29;
    cutout_width=71;
    
    height=max(minheight,height);
    width=max(minwidth,width);
    
    echo("Frontplate Height:",height);
    echo("Frontplate Width:",width);
    
    difference()
    {
        cube([width,height,thickness],center=true);
        cube([cutout_width,cutout_height,thickness],center=true);
    }
}


frontplate();