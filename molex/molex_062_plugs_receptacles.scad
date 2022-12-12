// F. Davies  2018
//
// connectors that can use contacts for Molex 062 connectors
//
//  These are designed to use the following contacts:
//  female contact Molex P/N 02-06-1103
//  male contact   Molex P/N 02-06-2103
//
//  These are similar to and designed to mate with the following:
//  3 position plug Crimp Housing        Molex P/N 03-06-2031
//  3 position Receptacle Crimp Housing  Molex P/N 03-06-1032
//  4 position plug Crimp Housing        Molex P/N 03-06-2041
//  4 position Receptacle Crimp Housing  Molex P/N 03-06-1042
//  6 position plug Crimp Housing        Molex P/N 03-06-2061  
//  6 position Receptacle Crimp Housing  Molex P/N 03-06-1062
//
// For best results, print the hole size test block first and
//  see which hole setting works best with your printer


holeAdj = 2;  // set this to best value determined with holeTester (hole_test_block.stl)

$fn=24;
delta=0.1;  // for making surfaces non-coincident

//holeTester();

//  uncomment the connector that you want 
//recep2();
// recep6();
// recep4();
// recep3();

plug2();
//plug3();
// plug4();
// plug6();


module holeTester()
{
    union()
    {
        difference()
        {
            translate([-6,0,0]) cube([5+6,30,11-5],center=false);
            translate([-11,-1,0.5]) cube([11,32,6],center=false);
            for (i=[0,1,2,3,4,5])
                translate([2.5,3+i*4.5,-5]) plugHoleCutter(0.1*i);
        }  
        translate([-1,1,0.2])
            scale([0.4,0.4,1]) rotate([0,0,90])
                linear_extrude(height = 0.5) {
                    text("0 1 2 3 4 5", font = "Liberation Sans:style=Bold"); }
    }
};

i2mm = 25.4; // for converting inches to millimeters.

p = 3.68;  //hole pitch, distance between centers of holes


/*
translate([0,60,0]) recep6();
translate([0,40,0]) recep4();
translate([0,20,0]) recep3();

translate([40,20,0]) plug3();
translate([40,40,0]) plug4();
translate([40,60,0]) plug6();
*/

module recep6()
{
    recep(3,2,19.8,12.6,8.8,8.4,1,5,0.6,4,2.3,2,1,1.5,2.4);
}

module recep3()
{
    recep(1,3,19.8,4.9,12.3,9.1,1.8,5.5,0.6,3.5,2.3,2,1,2.2,0);
}

module recep4()
{
    recep(1,4,19.8,4.9,16.0,9.1,1.8,5.5,0.6,3.5,2.3,2,1,2.2,0);
}
module recep2()
{
    recep(1,2,19.8,4.9,8.8,9.1,1.8,5.5,0.6,3.5,2.3,2,1,2.2,0);
}

module recep(n,m,d,e,f,g,th1,th2,ta,tf,tw,rw,ra,cw,kw)
{
    /*
    d = 19.8;  // height of receptacle (front face to back face)
    e = 12.6;  // Width of face of receptacle (along axis through tabs, y axis)
    f = 8.8;  // Length of face of receptacle (x axis)
    g = 8.4;  // distance from front face to plane of front-to-back transition
    th1 = 1;  // z direction thickness of flat part of tab
    th2 = 5;  // z axis thickness of tab where it intersects body
    ta = 0.6;  // distance tab sticks out from body of receptacle
    tf = 4; // z axis distance from face plane to mid point of tab
    tw = 2.3;  // width of tab in x axis direction
    rw = 2; // x axis width of rib
    ra = 1; // distance rib sticks out from body of receptacle
    cw = 1.5; // width of face of corner cuts (measured on diagonal)
    kw = 2.4; // width of triangule key slot, measured in y direction
    */

    clx = p*(m-1)/2; // x coordinate of centerline parallel to y axis
    cly = p*(n-1)/2; // y coordinate of centerline parallel to x axis
    
    difference()
    {
        union() // main part of body
        {
            translate([clx,cly,d/2-delta/2])
                cube([f,e,d+delta],center=true);
            // tabs
            translate([clx,cly,d-tf])
                hull()
                {
                    cube([tw,2*ta+e,th1],center=true);
                    cube([tw,e-delta,th2+ta*delta/(th2-th1)],center=true);
                } // hull
            // ribs
            for (i=[-1,1])
                translate([clx+i*f/4,cly-e/2,(d-g)/2-2*delta])
                    cube([rw,2*ra,d-g+2*delta],center=true);
        } // union
        // holes for contacts
        for (i=[1:n])
            for (j=[1:m])
                translate([(j-1)*p,(i-1)*p,0]) recepHoleCutter(0.1*holeAdj);
        
        // corner trim
        for (i=[-1,1])
            translate([clx+f/2+delta,cly+i*(e/2+delta),delta/2-g/2+d])
                rotate([0,0,45])
                    cube([cw+2*1.414*delta,cw+2*1.414*delta,g+delta],center=true);
        
        // key ways
        for (i=[1:n-1])
            translate([clx-f/2-delta,p/2+p*(i-1),(g+delta)/2+d-g])
                rotate([0,0,45])
                    cube([0.707*(kw+2*delta),0.707*(kw+2*delta),g+delta],center=true);
       
        // bottom trim
        translate([clx,cly,-10*delta/2])
            cube([2*f,2*e,10*delta],center=true);
    } // difference


}




/*  cross sections for checking clearances*/ 
/*
//projection(cut = true)   
//rotate([90,0,0]) 
union() { 
    //recep();  
    translate([0,(n-1)*p,31]) rotate([180,0,0]) plug();
    
    translate([30,-p/2,0]) rotate([0,0,90]) 
    union(){ recep();  translate([0,(n-1)*p,31]) rotate([180,0,0]) plug(); }
        
            translate([60,0,0]) rotate([0,0,90]) 
    union(){ recep();  translate([0,(n-1)*p,31]) rotate([180,0,0]) plug();}
        
    } 
*/

module recepHoleCutter(extra)
{
    backSegmentLength = 7.7;
    backSegmentDiam = 3.2;  // back
    middleSegmentLength = 2.7;
    middleSegmentDiam = 2.15+extra;
    frontSegmentLength = 9.4;
    FrontSegmentDiam = 2.75+extra;
union()
    {
        // bottom part
        difference()
        {
            translate([0,0,-delta])
                cylinder(d=backSegmentDiam,h=backSegmentLength+delta,center=false);
            translate([0,0,backSegmentLength]) rotate([0,180,0])
                outerCircularBevelCutter(backSegmentDiam,(backSegmentDiam-middleSegmentDiam)/2);
        } 
        translate([0,0,backSegmentLength-delta])
            cylinder(d=middleSegmentDiam,h=middleSegmentLength+2*delta,center=false); 
        translate([0,0,backSegmentLength+middleSegmentLength])
            cylinder(d=FrontSegmentDiam,h=frontSegmentLength+delta*4,center=false);

    }
}

module plugHoleCutter(extra)
{
    backSegmentLength = (10.8-3.2);
    backSegmentDiam = 3.2;  // back
    middleSegmentLength = 2.7;
    middleSegmentDiam = 2.15+extra;
    frontSegmentLength = 0.5;
    FrontSegmentDiam = 2.75+extra;
union()
    {
        // botton part
        difference()
        {
            translate([0,0,-delta])
                cylinder(d=backSegmentDiam,h=backSegmentLength+delta,center=false);
            translate([0,0,backSegmentLength]) rotate([0,180,0])
                outerCircularBevelCutter(backSegmentDiam,(backSegmentDiam-middleSegmentDiam)/2);
        } 
        translate([0,0,backSegmentLength-delta])
            cylinder(d=middleSegmentDiam,h=middleSegmentLength+2*delta,center=false); 
        translate([0,0,backSegmentLength+middleSegmentLength])
            cylinder(d=FrontSegmentDiam,h=frontSegmentLength+delta*4,center=false);

    }    
}

module plug2()
{
    genPlug(1,2,19.0,7.55,11.4,8.4,3.1,2.5,0,0,2.6,3.4,0,5.2,8.8,0.5,1.0); 
}
module plug3()
{
    genPlug(1,3,19.0,7.55,15.0,8.4,3.1,2.5,0,0,2.6,3.4,0,5.2,12.4,0.5,1.0); 
}

module plug6()
{
    genPlug(3,2,19.2,15.1,11.4,8.4,3.1,2.6,0,0,1.5,1.5,2.4,12.6,8.8,0.5,1.0);
}

module plug4()
{
    genPlug(1,4,18.5,7.55,18.7,7.8,3.1,2.1,2,1,2.6,3.4,0,5.2,16.1,0.5,1.0); 
}

module genPlug(n,m,d,e,f,g,tsw,tsb,rw,ra,cw1,cw2,kw,er,fr,ge,w)
{
 /*   d = 19.2;  // height of receptacle (front face to back face)
    e = 15.1;  // Width of face of receptacle (along axis through tabs, y axis)
    f = 11.4;  // Length of face of receptacle (x axis)
    g = 10;  //  distance from front face to plane of front-to-back transition

    tsw = 3.1;  // width of slot for tab
    tsb = 2.6;  // bridge over slot for tab
    rw = 2; // x axis width of rib
    ra = 1; // distance rib sticks out from body of receptacle
    
    cw1 = 1.5; // width of face of corner cuts (measured on diagonal)
    cw2 = 1.5;  // cuts on outside
    kw = 2.4; // width of triangule key slot, measured in y direction    
    
    er = 12.6;  // Width of face of receptacle (along axis through tabs, y axis)
    fr = 8.8;  // Length of face of receptacle (x axis)
    
    ge = 0.5;  
    w = 1.0;  // thickness of walls of shroud */
    
    clx = p*(m-1)/2; // x coordinate of centerline parallel to y axis
    cly = p*(n-1)/2; // y coordinate of centerline parallel to x axis
    
    difference()
    {
        // main body
        translate([clx,cly,d/2]) cube([f,e,d],center=true);

        // holes for contacts
        for (i=[1:n])
            for (j=[1:m])
                translate([(j-1)*p,(i-1)*p,0]) plugHoleCutter(0.1*holeAdj);    
        
        // back cutter    
        difference()
        {
            difference()
            {
                translate([clx,cly,d/2])
                    cube([f+2*delta,e+2*delta,d+2*delta],center=true);
                translate([clx,cly,d/2])  // take out center of cutter
                    cube([fr,er,d+4*delta],center=true);
            }  // difference
            
            difference()
            {
                translate([clx,cly,d/2+(d-(g+ge)-(e-er)/2-delta)])
                    cube([f+4*delta,e+4*delta,d],center=true);
                translate([clx,cly,d/2-tsb])
                    cube([tsw,e+6*delta,d],center=true);  // for tab
                translate([clx,cly,d/2+(d/2-(g+ge)-(e-er)/2-delta)])
                    outerRectangleBevelCutter(f+4*delta,e+4*delta,(e-er)/2+3*delta);
            }  // difference
            
            difference()
            {
                
            }  // difference            
        } // difference  back cutter

        // trim
                for (i=[-1,1])
                    translate([clx+f/2+delta,cly+i*(e/2+delta),delta/2-g/2+d])
                        rotate([0,0,45])
                            cube([cw2+2.828*delta,cw2+2.828*delta,g+2*ge+(e-er)+delta],center=true);

        difference()  // front cutter
        {
            union()
            {
                translate([clx,cly,d/2+d-g])
                    cube([f-2*w,e-2*w,d],center=true);

            }
            for (i=[-1,1]) // make inner keying diagonal corners
                translate([clx+(f-2*w)/2+delta,cly+i*((e-2*w)/2+delta),delta/2-g/2+d])
                    rotate([0,0,45])
                        cube([cw1+2.828*delta,cw1+2.828*delta,g+delta],center=true);
            for (i=[1:n-1])
                translate([clx-(f-2*w)/2-delta,p/2+p*(i-1),-g/2+d])
                    rotate([0,0,45])
                        cube([0.707*(kw+2*delta),0.707*(kw+2*delta),g+2*delta],center=true);
            
        } // difference  front cutter
    }  // difference
};

module outerCircularBevelCutter(d,b)  // improved
{
  difference()  {
   translate([0,0,-delta/2]) cylinder(d=d+delta*2,h=b+1*delta);
   translate([0,0,-1*delta]) cylinder(d1=d-2*b-2*delta,d2=d+2*delta, h=b+2*delta);
  }
};

module outerRectangleBevelCutter(l,w,b)
{ // 
  polyhedron(
    points=[ [l/2+b,w/2+b,2*b],[l/2-2*b,w/2-2*b,-b],[l/2+b,w/2+b,-b],
             [-l/2-b,w/2+b,2*b],[-l/2+2*b,w/2-2*b,-b],[-l/2-b,w/2+b,-b],
             [-l/2-b,-w/2-b,2*b],[-l/2+2*b,-w/2+2*b,-b],[-l/2-b,-w/2-b,-b],
            [l/2+b,-w/2-b,2*b],[l/2-2*b,-w/2+2*b,-b],[l/2+b,-w/2-b,-b] ],
    faces = [  [0,3,2],  [3,5,2],  [2,5,4],   [2,4,1],  [1,4, 0], [0,4,3] 
              ,[3,6,5],  [6,8,5],  [5,8,7],   [5,7,4],  [4,7, 3], [3,7,6] 
              ,[6,9,8],  [9,11,8], [8,11,10], [8,10,7], [7,10,6], [6,10,9] 
              ,[9,0,11], [0,2,11], [11,2,1],  [11,1,10], [10,1,9], [9,1,0] ] ); 
};

module innerRectangleBevelCutter(l,w,b)
{ // 
  polyhedron(
    points=[ [l/2-b,w/2-b,2*b],[l/2-b,w/2-b,-b],[l/2+2*b,w/2+2*b,-b],
             [-l/2+b,w/2-b,2*b],[-l/2+b,w/2-b,-b],[-l/2-2*b,w/2+2*b,-b],
             [-l/2+b,-w/2+b,2*b],[-l/2+b,-w/2+b,-b],[-l/2-2*b,-w/2-2*b,-b],
            [l/2-b,-w/2+b,2*b],[l/2-b,-w/2+b,-b],[l/2+2*b,-w/2-2*b,-b] ],
    faces = [  [0,3,2],  [3,5,2],  [2,5,4],   [2,4,1],  [1,4, 0], [0,4,3] 
              ,[3,6,5],  [6,8,5],  [5,8,7],   [5,7,4],  [4,7, 3], [3,7,6] 
              ,[6,9,8],  [9,11,8], [8,11,10], [8,10,7], [7,10,6], [6,10,9] 
              ,[9,0,11], [0,2,11], [11,2,1],  [11,1,10], [10,1,9], [9,1,0] ] ); 
};

