$fs=0.2;
$fa=0.2;

headNum = 2;

phillipsDrive(headNum);
//phillipsDemo(headNum);

module phillipsDemo(num) {
  difference() {
    cylinder(d=8,h=3);
    translate([0,0,3-1.7]) rotate([180,0]) phillipsDrive(num);
  }

  translate([0,0,3-1.7+3*(1+cos(360*$t))/2]) rotate([180,0]) phillipsDrive(num);
}

module phillipsDrive(S) {
  in = 25.4; // inches to mm
  
  // A Point Diameter
  // B Point Width
  // C Length
  // D Length
  // E Diameter
  // Fmax,Fmin Wing Thickness
  // G Point Width
  // H Milling angle
  // Jmax, Jmin Flat on End
  // K Base Flute Angle
  // L Side Flute Angle
  // M Flute Width at Bottom
  drives = [
    /* No. 0 */ [0.045, 0.0240, 0.656, 0.781, 0.094, 0.012, 0.010, 0.032, 7.00, 0.015, 0.010, 000.01, 92, 0.0151],
    /* No. 1 */ [0.087, 0.0394, 0.688, 0.812, 0.156, 0.020, 0.018, 0.050, 7.00, 0.020, 0.015, 138.00, 92, 0.0202],
    /* No. 2 */ [0.141, 0.0606, 0.750, 0.875, 0.219, 0.025, 0.023, 0.090, 5.75, 0.020, 0.015, 140.00, 92, 0.0434],
    /* No. 3 */ [0.209, 0.0983, 0.781, 0.906, 0.250, 0.031, 0.029, 0.150, 5.75, 0.020, 0.015, 146.00, 92, 0.0826],
    /* No. 4 */ [0.312, 0.1407, 0.844, 0.969, 0.359, 0.044, 0.042, 0.200, 7.00, 0.020, 0.015, 153.00, 92, 0.1078],
    /* No. 5 */ [0.500, 0.2310, 1.031, 1.156, 0.531, 0.063, 0.061, 0.311, 7.00, 0.025, 0.020, 162.77, 92, 0.1730],
  ];
  l = drives[S];
  _phillipsDrive(l[0]*in, l[1]*in, l[2]*in, l[3]*in, l[4]*in, (l[5]+l[6])/2*in, l[7]*in, l[8], (l[9]+l[10])/2*in, l[11], l[12], l[13]*in);
}

module _phillipsDrive(A_unused,B,C,D,E,F,G,H,J,K,L,M) {
  A=6.35;
  y1 = ((A-G)/2) / tan(26.5);
  y2 = ((G-J)/2) * tan(18);
  translate([0,0]) difference() {
    translate([0,0,0]) rotate_extrude() {
      polygon([
        [A/2,-y1-y2],
        [G/2,-y2],
        [J/2,0],
        [0,0],
        [0,-D],[E/2,-D],[E/2,-C],[A/2,-C]
      ]);
    }
    
  // not spec'd, eyeballing these values
  grindingRadius = 15; 
  grindLength = 1.5*(y1+y2);
  echo(grindLength);
  for (i = [0:3]) rotate(45+i*90)
    translate([B/2,0]) rotate([0,-H]) translate([0,0,-grindLength]) {
      linear_extrude(grindLength) phillipsFluteProfile(A,K,L,M);
      translate([grindingRadius,0]) rotate([90,0]) rotate_extrude() translate([grindingRadius,0]) rotate(180) phillipsFluteProfile(A,K,L,M);
    }
  }
}

module phillipsFluteProfile(A,K,L,M) {
  x1 = K < 1 ? K-K*cos((180-L)/2) : tan((180-K)/2)*M/2;
  x2 = x1 + tan((180-L)/2)*A/2;
  y1 = K < 1 ? K*sin((180-L)/2) : M/2;
  y2 = y1 + A/2;
  if (K < 1) { // PH 0 specifies radius instead of angle
    scale(1/100) union() {
      translate([100*K,0]) circle(r=K*100,$fn=30);
      polygon([
        [100*x1, 100*y1],[100*x2, 100*y2],[100*x2,100*-y2],[100*x1,100*-y1]  
      ]);
    }
  } else {
    polygon([
      [0,0],[x1, y1],[x2, y2],[x2,-y2],[x1,-y1]  
    ]);
  }
}

