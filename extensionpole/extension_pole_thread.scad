
// Based on Nut_Job.scad, but simplified for this purpose, see comments below
// Original design from https://www.thingiverse.com/thing:1622576 for gopro mount


/* 'Nut Job' nut, bolt, washer and threaded rod factory by Mike Thompson 1/12/2013, Thingiverse: mike_linus
 *
 * Licensing: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License.
 * Further information is available here - http://creativecommons.org/licenses/by-nc-sa/3.0/au/deed.en_GB
 *
 * v2 8/12/2013 - added socket head types
 * v3 2/11/2014 - adjusted wing nut algorithm for better behaviour with unusual nut sizes and added ISO262 metric references
 * v4 31/12/2014 - added optional texture to socket heads, added ability to change the number of facets for a hex head
 * and adjusted wingnut base level on certain nut sizes
 * v5 11/1/2015 - added phillips and slot drive types and improved texture handling 
 * v6 21/2/2015 - added wing ratio to wingnuts 
 * v7 6/3/2016 - added extended options to control number of facets on nuts, square sockets (or any number of facets) and socket depth control
 * 
 * This script generates nuts, bolts, washers and threaded rod using the library 
 * script: polyScrewThead.scad (modified/updated version polyScrewThread_r1.scad)
 * http://www.thingiverse.com/thing:8796, CC Public Domain
 *
 * Defaults are for a 8mm diameter bolts, rod, matching nuts and wing nuts that work well together
 * without cleanup or modification. Some default parameters such as the nut outer diameter are deliberately
 * altered to produce a snug fit that can still be hand tightened. This may need to be altered
 * depending on individual printer variances, slicing tools, filament etc. Suggest printing a matching
 * bolt and nut and adjusting as necessary.  Note: slow print speeds, low temperatures and solid
 * fill are recommended for best results.
 */

/* [Component Type] */
type						= "nut";//[nut,bolt,rod,washer]

/* [Bolt and Rod Options] */

//Head type - Hex, Socket Cap, Button Socket Cap or Countersunk Socket Cap (ignored for Rod)
head_type              			        = "hex";//[hex,socket,button,countersunk]
//Drive type - Socket, Phillips, Slot (ignored for Hex head type and Rod)
drive_type              			= "socket";//[socket,phillips,slot]
//Distance between flats for the hex head or diameter for socket or button head (ignored for Rod)
head_diameter    				= 12;	
//Height of the head (ignored for Rod)
head_height  					= 5;	
//Diameter of drive type (ignored for Hex head and Rod)
drive_diameter					= 5;	
//Width of slot aperture for phillips or slot drive types
slot_width					= 1;
//Depth of slot aperture for slot drive type
slot_depth 					= 2;
//Surface texture (socket head only)
texture                                      	= "exclude";//[include,exclude]
//Outer diameter of the thread
thread_outer_diameter             		= 8;		
//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
thread_step    					= 5.5;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
step_shape_degrees 				= 45;	
//Length of the threaded section
thread_length  					= 21;	
//Countersink in both ends
countersink  					= 2;	
//Length of the non-threaded section
non_thread_length				= 0;	
//Diameter for the non-threaded section (-1: Same as inner diameter of the thread, 0: Same as outer diameter of the thread, value: The given value)
non_thread_diameter				= 0;	

/* [Nut Options] */

//Type: Normal or WingNut
nut_type	                      	        = "normal";//[normal,wingnut]
//Distance between flats for the hex nut
nut_diameter    				= 25;	
//Height of the nut
nut_height	  				= 28;	
//Outer diameter of the bolt thread to match (usually set about 1mm larger than bolt diameter to allow easy fit - adjust to personal preferences) 
nut_thread_outer_diameter     	                = 22;		
//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
nut_thread_step    				= 5;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
nut_step_shape_degrees 			        = 45;	
//Wing radius ratio.  The proportional radius of the wing on the wing nut compared to the nut height value (default = 1)
wing_ratio                                      = 1;
wing_radius=wing_ratio * nut_height;

/* [Washer Options] */

//Inner Diameter (suggest making diameter slightly larger than bolt diameter)
inner_diameter					= 8;
//Outer Diameter
outer_diameter					= 14;
//Thickness
thickness					= 2;

/* [Extended Options] */

//Number of facets for hex head type or nut. Default is 6 for standard hex head and nut
facets                                          = 6;
//Number of facets for hole in socket head. Default is 6 for standard hex socket
socket_facets                                   = 6;
//Depth of hole in socket head. Default is 3.5
socket_depth                                   = 3.5;
//Resolution (lower values for higher resolution, but may slow rendering)
resolution    					= 0.5;	
nut_resolution    				= resolution;

module extension_pole_nut(mountplate_r=nut_diameter/sqrt(3))
{
  hex_nut(nut_diameter,nut_height,nut_thread_step,nut_step_shape_degrees,nut_thread_outer_diameter,nut_resolution);
  //mountplate
  ;
  cylinder(r=mountplate_r,h=2,center=true, $fn=64);
}

/* Library included below to allow customizer functionality    
 *
 *    polyScrewThread_r1.scad    by aubenc @ Thingiverse
 *
 * This script contains the library modules that can be used to generate
 * threaded rods, screws and nuts.
 *
 * http://www.thingiverse.com/thing:8796
 *
 * CC Public Domain
 */

module screw_thread(od,st,lf0,lt,rs,cs)
{
    or=od/2;
    ir=or-st/2*cos(lf0)/sin(lf0);
    pf=2*PI*or;
    sn=floor(pf/rs);
    lfxy=360/sn;
    ttn=round(lt/st+1);
    zt=st/sn;

    intersection()
    {
        if (cs >= -1)
        {
           thread_shape(cs,lt,or,ir,sn,st);
        }

        full_thread(ttn,st,sn,zt,lfxy,or,ir);
    }
}

module hex_nut(df,hg,sth,clf,cod,crs)
{

    difference()
    {
        hex_head(hg,df);

        hex_countersink_ends(sth/2,cod,clf,crs,hg);

        screw_thread(cod,sth,clf,hg,crs,-2);
    }
}



module thread_shape(cs,lt,or,ir,sn,st)
{
    if ( cs == 0 )
    {
        cylinder(h=lt, r=or, $fn=sn, center=false);
    }
    else
    {
        union()
        {
            translate([0,0,st/2])
              cylinder(h=lt-st+0.005, r=or, $fn=sn, center=false);

            if ( cs == -1 || cs == 2 )
            {
                cylinder(h=st/2, r1=ir, r2=or, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }

            translate([0,0,lt-st/2])
            if ( cs == 1 || cs == 2 )
            {
                  cylinder(h=st/2, r1=or, r2=ir, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }
        }
    }
}

module full_thread(ttn,st,sn,zt,lfxy,or,ir)
{
  if(ir >= 0.2)
  {
    for(i=[0:ttn-1])
    {
        for(j=[0:sn-1])
			let( pt = [	[0,                  0,                  i*st-st            ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
								[0,0,i*st],
                        [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                        [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                        [0,                  0,                  i*st+st            ]	])
        {
            polyhedron(points=pt,
              		  faces=[	[1,0,3],[1,3,6],[6,3,8],[1,6,4], //changed triangles to faces (to be deprecated)
											[0,1,2],[1,4,2],[2,4,5],[5,4,6],[5,6,7],[7,6,8],
											[7,8,3],[0,2,3],[3,2,7],[7,2,5]	]);
        }
    }
  }
  else
  {
    echo("Step Degrees too agresive, the thread will not be made!!");
    echo("Try to increase de value for the degrees and/or...");
    echo(" decrease the pitch value and/or...");
    echo(" increase the outer diameter value.");
  }
}

module hex_head(hg,df)
{
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   cylinder(h=hg, r=rd0, $fn=facets, center=false);

		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}
}

module hex_countersink_ends(chg,cod,clf,crs,hg)
{
    translate([0,0,-0.1])
    cylinder(h=chg+0.01, 
             r1=cod/2, 
             r2=cod/2-(chg+0.1)*cos(clf)/sin(clf),
             $fn=floor(cod*PI/crs), center=false);

    translate([0,0,hg-chg+0.1])
    cylinder(h=chg+0.01, 
             r1=cod/2-(chg+0.1)*cos(clf)/sin(clf),
             r2=cod/2, 
             $fn=floor(cod*PI/crs), center=false);

}


extension_pole_nut(0);