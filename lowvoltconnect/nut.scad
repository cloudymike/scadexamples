use <../threads/isothreads.scad>


ridges = 5;
thickness = 1;
outsideHeight = 10;
top_thickness = 2;
cableHole = 14;
thread_length = outsideHeight - top_thickness;
rounding = 1;
outsideDiameter=24;
threadDiameter = 20;
ridge_diameter = 1;
Diameter = outsideDiameter;
wallThickness = thickness;
innerDepth = thread_length + top_thickness - 2 * rounding;
smoothness = 20;

difference () {
    rounded_cylinder (r=outsideDiameter/2, h=outsideHeight, n=rounding);
    
    metric_thread (
        diameter=threadDiameter, 
        pitch=2.5, 
        length=thread_length, 
        internal=true, 
        n_starts=1
    );
    
    cylinder(d=cableHole,h=outsideHeight, $fn=100); 


}
for(ridge=[0:ridges-1])
{
    hull()
    {
      rotate([0,0,360/ridges*ridge])
      translate([Diameter/2,0,rounding+ridge_diameter/2])
      sphere(r=ridge_diameter,$fn=smoothness);
      rotate([0,0,360/ridges*ridge])
      translate([Diameter/2,0,innerDepth+rounding-ridge_diameter/2])
      sphere(r=ridge_diameter,$fn=smoothness);
    }
}

module rounded_cylinder(r,h,n) {
  
  rotate_extrude(convexity=1,$fn=100) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}
