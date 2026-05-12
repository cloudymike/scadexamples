$fn = 180*1;

// Base Outer diameter
OD = 74;
// OD = 74;  //Gaggia 58mm

// Base Inner diameter
ID = 60.5;
// ID = 60.5; //Gaggia 58mm

// Funnel Diameter
FD = 90;
// FD = 85;  //Gaggia 58mm

// Funnel Height
FH = 24;
// FH = 18; //Gaggia 58mm 

// Overhang
OH = 2;
// OH = 2; //Gaggia 58mm

// thickness of walls
WALL = 2.8;
// WALL = 2.8; //Gaggia 58mm

// thickness of lip
LIP = 1;
// LIP = 1; //Gaggia 58mm

// LUG length
LUGL = 24; 
// LUGL = 24; //Gaggia 58mm

// LUG height
LUGH = 7;
// LUGH = 7; //Gaggia 58mm

// LUG TYPE: 1 == Normal, 2 == Inverted, 3 == Single inverted
LUGT = 1;
// LUGT = 1; //Gaggia 58mm

module body () {
    cylinder(d=OD, h=FH+LUGH);
//    translate([0,0,LUGH]) cylinder(d1=FD*.75, d2=FD, h=FH);        
    translate([0,0,LUGH+OH+LIP]) cylinder(d1=OD, d2=FD, h=FH-0.01);        
}

module lugholes () {
    if (LUGT == 1) { // Normal LUGs
        cube([LUGL, OD*1.1, LUGH*2], center=true);
    } else if (LUGT == 2) { // Inverted LUG
        translate([-OD/2-LUGL/2, 0, 0])
            cube([OD, OD*1.1, LUGH*2], center=true);
        translate([OD/2+LUGL/2, 0, 0])
            cube([OD, OD*1.1, LUGH*2], center=true);
    } else if (LUGT == 3) { // Single Inverted LUG
        translate([-OD/2-LUGL/2, 0, 0])
            cube([OD, OD*1.1, LUGH*2], center=true);
        translate([OD/2+LUGL/2, 0, 0])
            cube([OD, OD*1.1, LUGH*2], center=true);
        translate([0,OD/2,0])
            cube([OD, OD, LUGH*2], center=true);
    }
}



difference () {
    
    // main body of dosing funnel
    body();
    
    // cone hole
    //translate([0,0,LUGH+OH+LIP]) cylinder(d1=ID, d2=FD-WALL/2, h=FH);
    translate([0,0,LUGH+OH+LIP]) cylinder(d1=ID, d2=FD-WALL, h=FH);

    // inner hole    
    translate([0,0,-FH*0.05]) cylinder(d=ID, h=LUGH+FH*1.1);
    
    // outer lip hole
    translate([0,0,-OH*0.05]) cylinder(d=OD-2*WALL, h=LUGH+OH*1.05);
    
    // LUG holes
    lugholes();
}

