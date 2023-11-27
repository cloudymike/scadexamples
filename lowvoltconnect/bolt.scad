use <../threads/isothreads.scad>


ridges = 5;
thickness = 1;
outsideHeight = 11;
top_thickness = 2;
cableHole = 14;
thread_length = outsideHeight - top_thickness;
rounding = 1;
outsideDiameter=24;
threadDiameter = 19.1;
ridge_diameter = 1;
Diameter = outsideDiameter;
wallThickness = thickness;
innerDepth = thread_length + top_thickness - 2 * rounding;
smoothness = 20;

difference () {
    metric_thread (
        diameter=threadDiameter, 
        pitch=2.5, 
        length=thread_length, 
        internal=false, 
        n_starts=1
    );
    
    cylinder(d=cableHole,h=outsideHeight, $fn=100); 


}
