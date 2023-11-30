use <../threads/isothreads.scad>

module lowvoltagebolt(
    threadDiameter = 17.7-0.4,
    cableHole = 14,
    outsideHeight = 12
)
{
    ridges = 5;
    thickness = 1;
    top_thickness = 2;
    thread_length = outsideHeight - top_thickness;
    rounding = 1;
    outsideDiameter=threadDiameter+4.9;
    ridge_diameter = 1;
    Diameter = outsideDiameter;
    wallThickness = thickness;
    innerDepth = thread_length + top_thickness - 2 * rounding;
    smoothness = 20;
    
    difference () {
        metric_thread (
            diameter=threadDiameter, 
            pitch=1.8, 
            length=thread_length, 
            internal=false, 
            n_starts=1,
            thread_size=1.5
        );
        
        cylinder(d=cableHole,h=outsideHeight, $fn=100); 
    
    
    }

}

lowvoltagebolt();