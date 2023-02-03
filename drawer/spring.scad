use <interlockingmodule.scad>
use <applesocket.scad>

BoxHeight=10;

BoxUnits=40;
BoxWidthUnits=1;
BoxLengthUnits=1;

interlockingbox(
    //Box Width in units
    BoxWidthUnits = 1,
    //Box Length in units
    BoxLengthUnits = 1,
    //Box Height in mm
    BoxHeight = BoxHeight,
    //Box Floor Thickness in mm
    BoxFloor =0,
    //North Wall open or closed
    NorthWallOpen = 1, // [0:Closed, 1:Open]
    //South Wall open or closed
    SouthWallOpen = 1 // [0:Closed, 1:Open]
);

translate([BoxLengthUnits*BoxUnits/2,0,0])
    rotate([0,0,90]) 
        springSine3D(
            length=BoxLengthUnits*BoxUnits, 
            heigth=BoxHeight, 
            width=BoxWidthUnits*BoxUnits, 
            windings=4, 
            steps=10, 
            wireDiameter=1, 
            fn=40
        );

/**
* An edge (or line) between 2 cylinders
*/
module line3D(start, end,d=1,h=10, fn=4) {
  hull() {
    translate(start) cylinder(h=h, d=d, $fn = fn);    
    translate(end) cylinder(h=h, d=d, $fn = fn);    
  }      
}

/**
* 3d Spring with a sinusoidal shape
*/ 
module springSine3D(length=20, heigth=10, width=10, windings=4, steps=10, wireDiameter=0.7, fn=4){
    dx = length / (360 * windings);
    for(i = [steps : steps : 360 * windings]){
        x0 = (i-steps) * dx;
        y0 = sin(i-steps) * width/2;
        x = i * dx;
        y = sin(i) * width/2;        
        line3D([x0,y0,0],[x,y,0],d=wireDiameter,h=heigth, fn=fn);  
    }
}
