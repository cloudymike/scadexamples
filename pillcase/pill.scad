/*  makes 3 screw top containers
    and two tops for the containers
    containers are
    large
    small
    vial
    the same top fits the vial and small container
    i.e. small top
    the large top fits the large container

    mark = 1 makes large container
    mark = 2 makes large top
    mark = 3 makes vial
    mark = 4 makes small top
    mark = 5 makes small container



  uses threads.scad
  available at http://dkprojects.net/openscad-threads/

  pcm  September 2014

*/

use <../threads/isothreads.scad>





// mstk = 1;
// mark = 2;
// mark = 3;
// mark = 4;
// mark = 5;


mark = 3;



if (mark==1)

// makes large container bottom

difference()
{

union()
{


english_thread(2, 4, .5);
translate([0,0,-4.95])
cylinder(r=30,h=10,center=true);

}
translate([0,0,7])
cylinder(r=20,h=30,center=true);
 translate([-2,0,-9])
linear_extrude(height=2)
 scale (0.065)
shorebird();
}

else

if (mark==2)


// makes top for large container
difference()
{

translate([0,0,7.5])
cylinder(r=30,h=15,center=true);
//  1.02,1.02,1   - too tight
//   1.1,1.1,1   -  too loose ok for half size
//  1.05,1.05,1  -  not bad for full scale too tight for half scale
scale([1.05,1.05,1])
english_thread(2, 4, .5,internal=true);
//translate([-2,0,14])        //top
 translate([-2,0,12.25])       // bottom
linear_extrude(height=2)
// scale (0.1)      //top
 scale (0.075)    //  bottom
shorebird();

}

else

if (mark==3)

//  makes vial bottom - uses small top

scale(0.5)
difference()
{

union()
{


english_thread(2, 4, .5);
translate([0,0,-49.95])
cylinder(r=30,h=100,center=true);

}
translate([0,0,7])
cylinder(r=20,h=30,center=true);
translate([0,0,-49])
cylinder(r=27,h=94,center=true);

}

else

if (mark==4)
// makes top for vial and small container

scale(0.5)
difference()
{

translate([0,0,7.5])
cylinder(r=30,h=15,center=true);
//  1.02,1.02,1   - too tight
//   1.1,1.1,1   -  too loose ok for half size
//  1.05,1.05,1  -  not bad for full scale too tight for half scale
scale([1.1,1.1,1])
english_thread(2, 4, .5,internal=true);
//translate([0,0,14])     // top
 translate([0,0,12.25])       // bottom
evolute_of_elipse(16,16,2);
serrate(30,15,2,2,40);



}


if (mark==5)

// makes bottom for small container

scale(0.5)
difference()
{

union()
{


english_thread(2, 4, .5);
translate([0,0,-4.95])
cylinder(r=30,h=10,center=true);

}
translate([0,0,7])
cylinder(r=20,h=30,center=true);
 translate([-2,0,-9])
linear_extrude(height=2)
 scale (0.065)
shorebird();
}





       module serrate(tr,tnum,cx,cy,cz)
{

tx = tnum + 1;
for ( i = [0 : tnum] )
{
translate ([tr*cos(i*(360/tx)),tr*sin(i*(360/tx)),0])
rotate(  [0,0,i*(360/tx)])


cube([cx,cy,cz],center=true);
}

}




module evolute_of_elipse(a,b,ht)
{

/* evolute of elipse

   equation in rectangular coordinates is

   x = a * cos(theta) * cos(theta) * cos (theta)
   y = b * sin(theta) * sin(theta) * sin(theta)

 if a and b are equal the curve is also known
  as the astroid or hypocycloid of four cusps

  a and b are passed to the module - ht is the
  height of the extrusion

  note the small translation in z

*/

x=10;


translate([0,0,-0.5])
linear_extrude(height=ht)

polygon ([
            [pow(cos(-18*x),3)*a,pow(sin(-18*x),3)*b],
            [pow(cos(-17*x),3)*a,pow(sin(-17*x),3)*b],
            [pow(cos(-16*x),3)*a,pow(sin(-16*x),3)*b],
            [pow(cos(-15*x),3)*a,pow(sin(-15*x),3)*b],
            [pow(cos(-14*x),3)*a,pow(sin(-14*x),3)*b],
            [pow(cos(-13*x),3)*a,pow(sin(-13*x),3)*b],
            [pow(cos(-12*x),3)*a,pow(sin(-12*x),3)*b],
            [pow(cos(-11*x),3)*a,pow(sin(-11*x),3)*b],
            [pow(cos(-10*x),3)*a,pow(sin(-10*x),3)*b],
            [pow(cos(-9*x),3)*a,pow(sin(-9*x),3)*b],
            [pow(cos(-8*x),3)*a,pow(sin(-8*x),3)*b],
            [pow(cos(-7*x),3)*a,pow(sin(-7*x),3)*b],
            [pow(cos(-6*x),3)*a,pow(sin(-6*x),3)*b],
            [pow(cos(-5*x),3)*a,pow(sin(-5*x),3)*b],
            [pow(cos(-4*x),3)*a,pow(sin(-4*x),3)*b],
            [pow(cos(-3*x),3)*a,pow(sin(-3*x),3)*b],
            [pow(cos(-2*x),3)*a,pow(sin(-2*x),3)*b],
            [pow(cos(-1*x),3)*a,pow(sin(-1*x),3)*b],
            [pow(cos(0*x),3)*a,pow(sin(0*x),3)*b],
            [pow(cos(1*x),3)*a,pow(sin(1*x),3)*b],
            [pow(cos(2*x),3)*a,pow(sin(2*x),3)*b],
            [pow(cos(3*x),3)*a,pow(sin(3*x),3)*b],
            [pow(cos(4*x),3)*a,pow(sin(4*x),3)*b],
            [pow(cos(5*x),3)*a,pow(sin(5*x),3)*b],
            [pow(cos(6*x),3)*a,pow(sin(6*x),3)*b],
            [pow(cos(7*x),3)*a,pow(sin(7*x),3)*b],
            [pow(cos(8*x),3)*a,pow(sin(8*x),3)*b],
            [pow(cos(9*x),3)*a,pow(sin(9*x),3)*b],
            [pow(cos(10*x),3)*a,pow(sin(10*x),3)*b],
            [pow(cos(11*x),3)*a,pow(sin(11*x),3)*b],
            [pow(cos(12*x),3)*a,pow(sin(12*x),3)*b],
            [pow(cos(13*x),3)*a,pow(sin(13*x),3)*b],
            [pow(cos(14*x),3)*a,pow(sin(14*x),3)*b],
            [pow(cos(15*x),3)*a,pow(sin(15*x),3)*b],
            [pow(cos(16*x),3)*a,pow(sin(16*x),3)*b],
            [pow(cos(17*x),3)*a,pow(sin(17*x),3)*b],
 //           [pow(cos(18*x),3)*a,pow(sin(18*x),3)*b],
         ]);

  }






module shorebird()
{
 polygon
  (points = [
[    139.79,   -185.11],[    135.37,   -183.18],[    121.92,   -167.32],[    117.68,   -159.04],
[    115.71,   -155.19],[    113.91,   -152.58],[    113.68,   -153.23],[    113.46,   -153.89],
[    113.75,   -155.32],[    114.34,   -156.42],[    115.68,   -158.93],[    115.72,   -163.54],
[    114.40,   -163.54],[    113.85,   -163.54],[    113.40,   -164.21],[    113.40,   -165.04],
[    113.40,   -165.86],[    112.55,   -166.54],[    111.51,   -166.54],[    109.47,   -166.54],
[    109.09,   -165.30],[    107.33,   -153.18],[    105.72,   -142.01],[    104.13,   -139.92],
[     89.50,   -129.75],[     77.38,   -121.31],[     53.18,   -105.26],[     49.90,   -103.48],
[     44.10,   -100.32],[     26.88,    -89.53],[     24.80,    -87.75],[     20.19,    -83.81],
[     19.93,    -82.28],[     19.86,    -58.04],[     19.81,    -43.91],[     19.31,    -32.72],
[     18.55,    -29.04],[     17.33,    -23.16],[     14.56,    -15.54],[     13.63,    -15.54],
[     13.37,    -15.54],[     11.58,    -16.92],[      9.65,    -18.62],[      7.48,    -20.53],
[      5.43,    -21.52],[      4.28,    -21.22],[      3.26,    -20.95],[      1.28,    -21.63],
[     -0.12,    -22.73],[     -1.51,    -23.83],[     -3.23,    -24.51],[     -3.93,    -24.24],
[     -4.63,    -23.97],[     -6.30,    -24.36],[     -7.65,    -25.11],[    -11.11,    -27.02],
[    -12.60,    -26.85],[    -12.60,    -24.54],[    -12.60,    -23.34],[    -13.27,    -22.54],
[    -14.27,    -22.54],[    -15.19,    -22.54],[    -16.77,    -21.78],[    -17.79,    -20.86],
[    -19.52,    -19.30],[    -19.85,    -19.30],[    -22.87,    -20.86],[    -31.54,    -25.36],
[    -37.49,    -30.73],[    -43.05,    -39.09],[    -46.17,    -43.78],[    -49.83,    -49.83],
[    -51.19,    -52.54],[    -52.55,    -55.25],[    -54.13,    -57.75],[    -54.70,    -58.10],
[    -55.35,    -58.50],[    -55.49,    -61.03],[    -55.07,    -64.92],[    -54.52,    -70.06],
[    -54.75,    -71.69],[    -56.40,    -74.57],[    -59.23,    -79.53],[    -59.41,    -81.58],
[    -60.17,   -116.73],[    -61.03,   -156.88],[    -59.64,   -166.58],[    -52.59,   -169.70],
[    -47.74,   -171.85],[    -48.84,   -173.54],[    -55.10,   -173.54],[    -58.12,   -173.54],
[    -60.60,   -173.09],[    -60.60,   -172.54],[    -60.60,   -171.99],[    -61.27,   -171.54],
[    -62.10,   -171.54],[    -62.92,   -171.54],[    -63.60,   -171.99],[    -63.60,   -172.54],
[    -63.60,   -173.10],[    -66.30,   -173.54],[    -69.71,   -173.54],[    -75.76,   -173.54],
[    -75.81,   -173.51],[    -75.18,   -170.99],[    -74.59,   -168.66],[    -74.72,   -168.53],
[    -76.57,   -169.52],[    -77.69,   -170.12],[    -78.60,   -171.27],[    -78.60,   -172.07],
[    -78.60,   -173.05],[    -79.65,   -173.54],[    -81.72,   -173.54],[    -84.70,   -173.54],
[    -84.82,   -173.39],[    -84.21,   -170.36],[    -83.80,   -168.29],[    -81.81,   -165.57],
[    -78.56,   -162.61],[    -73.60,   -158.08],[    -73.54,   -157.95],[    -72.46,   -149.68],
[    -70.90,   -137.68],[    -71.73,    -72.86],[    -73.48,    -69.68],[    -75.67,    -65.71],
[    -73.34,    -59.29],[    -66.73,    -51.15],[    -53.47,    -34.79],[    -44.53,    -21.27],
[    -42.65,    -14.72],[    -41.34,    -10.15],[    -44.53,     -7.75],[    -54.23,     -6.00],
[    -58.56,     -5.22],[    -64.57,     -3.88],[    -67.60,     -3.03],[    -77.45,     -0.26],
[    -99.86,      4.49],[   -110.60,      6.08],[   -112.52,      6.36],[   -115.45,      7.22],
[   -117.10,      7.99],[   -118.75,      8.76],[   -126.17,     10.10],[   -133.60,     10.97],
[   -141.02,     11.85],[   -148.67,     12.94],[   -150.60,     13.40],[   -152.52,     13.86],
[   -160.85,     14.78],[   -169.10,     15.43],[   -177.35,     16.08],[   -185.00,     16.69],
[   -186.10,     16.79],[   -189.14,     17.05],[   -189.36,     21.77],[   -186.40,     23.30],
[   -184.47,     24.29],[   -185.05,     24.39],[   -189.96,     23.89],[   -198.68,     23.00],
[   -207.30,     24.22],[   -207.88,     26.42],[   -208.20,     27.64],[   -209.87,     28.48],
[   -213.22,     29.09],[   -217.51,     29.86],[   -218.14,     30.30],[   -218.41,     32.67],
[   -218.71,     35.24],[   -219.02,     35.38],[   -224.91,     35.67],[   -230.40,     35.93],
[   -231.13,     36.21],[   -231.41,     38.14],[   -231.60,     39.51],[   -230.99,     40.72],
[   -229.78,     41.37],[   -228.71,     41.94],[   -227.55,     43.53],[   -227.20,     44.90],
[   -226.58,     47.41],[   -225.86,     47.72],[   -214.60,     50.47],[   -212.67,     50.93],
[   -207.50,     51.85],[   -203.10,     52.49],[   -198.70,     53.14],[   -192.70,     54.52],
[   -189.76,     55.57],[   -186.82,     56.61],[   -183.67,     57.46],[   -182.76,     57.47],
[   -181.85,     57.47],[   -179.07,     58.50],[   -176.60,     59.75],[   -174.12,     61.00],
[   -168.95,     63.09],[   -165.10,     64.38],[   -161.25,     65.67],[   -157.21,     67.34],
[   -156.13,     68.10],[   -155.04,     68.85],[   -152.79,     69.48],[   -151.13,     69.50],
[   -149.46,     69.52],[   -146.97,     70.18],[   -145.60,     70.96],[   -144.22,     71.75],
[   -141.52,     72.42],[   -139.60,     72.46],[   -137.67,     72.50],[   -135.23,     73.19],
[   -134.16,     73.99],[   -133.05,     74.83],[   -130.07,     75.46],[   -127.22,     75.46],
[   -122.39,     75.46],[   -105.45,     80.18],[   -104.77,     81.71],[   -104.58,     82.12],
[   -103.37,     82.46],[   -102.06,     82.46],[   -100.76,     82.46],[    -98.47,     83.02],
[    -96.98,     83.70],[    -94.80,     84.69],[    -94.17,     84.69],[    -93.84,     83.68],
[    -93.57,     82.86],[    -92.73,     83.30],[    -91.47,     84.90],[    -90.39,     86.27],
[    -86.82,     88.37],[    -83.53,     89.57],[    -80.23,     90.77],[    -77.30,     92.14],
[    -77.01,     92.61],[    -76.72,     93.08],[    -75.60,     93.46],[    -74.53,     93.46],
[    -73.46,     93.46],[    -71.81,     94.36],[    -70.87,     95.46],[    -69.83,     96.67],
[    -67.92,     97.46],[    -66.03,     97.46],[    -64.18,     97.46],[    -62.17,     98.28],
[    -61.10,     99.46],[    -59.99,    100.69],[    -58.02,    101.46],[    -56.02,    101.46],
[    -53.71,    101.46],[    -51.86,    102.36],[    -49.70,    104.51],[    -47.06,    107.15],
[    -46.18,    107.47],[    -43.13,    106.90],[    -40.37,    106.38],[    -39.60,    106.57],
[    -39.60,    107.74],[    -39.60,    108.80],[    -38.01,    109.43],[    -34.10,    109.92],
[    -30.32,    110.39],[    -28.60,    111.05],[    -28.60,    112.03],[    -28.60,    112.88],
[    -27.61,    113.46],[    -26.18,    113.46],[    -24.85,    113.46],[    -23.62,    113.88],
[    -23.43,    114.39],[    -23.25,    114.90],[    -20.85,    115.47],[    -18.10,    115.64],
[    -15.35,    115.82],[    -12.85,    116.30],[    -12.54,    116.71],[    -12.24,    117.12],
[     -9.20,    117.74],[     -5.79,    118.10],[     -0.86,    118.62],[      0.41,    118.46],
[      0.43,    117.35],[      0.45,    116.39],[      0.77,    116.49],[      1.48,    117.71],
[      2.04,    118.67],[      3.29,    119.46],[      4.25,    119.46],[      5.21,    119.46],
[      6.43,    119.89],[      6.95,    120.40],[      8.08,    121.53],[     16.40,    120.58],
[     16.40,    119.33],[     16.40,    118.85],[     17.30,    118.46],[     18.40,    118.46],
[     19.50,    118.46],[     20.40,    118.91],[     20.40,    119.46],[     20.40,    120.03],
[     23.23,    120.46],[     26.90,    120.46],[     31.06,    120.46],[     33.40,    120.06],
[     33.40,    119.34],[     33.40,    117.65],[     42.91,    118.83],[     44.83,    120.75],
[     46.02,    121.94],[     47.93,    122.27],[     52.17,    122.04],[     55.32,    121.86],
[     58.35,    122.08],[     58.90,    122.51],[     59.45,    122.94],[     63.18,    123.45],
[     67.18,    123.63],[     74.45,    123.96],[     73.67,    126.96],[     73.25,    128.61],
[     72.94,    132.32],[     72.98,    135.21],[     73.03,    138.10],[     72.69,    140.46],
[     72.23,    140.46],[     70.30,    140.46],[     72.89,    155.62],[     75.39,    158.96],
[     75.80,    159.51],[     76.94,    162.44],[     77.93,    165.46],[     80.28,    172.67],
[     89.48,    182.54],[     95.66,    184.48],[     97.99,    185.22],[    100.73,    186.53],
[    101.75,    187.39],[    104.58,    189.79],[    118.90,    190.12],[    125.80,    187.95],
[    135.95,    184.76],[    147.36,    171.77],[    147.39,    163.37],[    147.40,    161.95],
[    148.76,    158.06],[    150.42,    154.74],[    155.85,    143.87],[    171.98,    130.24],
[    203.66,    109.74],[    228.77,     93.50],[    243.29,     84.24],[    245.72,     82.91],
[    261.71,     74.17],[    266.93,     70.69],[    267.24,     68.54],[    267.56,     66.29],
[    267.38,     66.22],[    261.74,     66.65],[    256.86,     67.01],[    253.07,     68.51],
[    238.76,     75.71],[    229.33,     80.45],[    216.73,     87.13],[    210.76,     90.55],
[    204.79,     93.98],[    198.10,     97.76],[    195.90,     98.97],[    193.70,    100.17],
[    187.18,    103.98],[    181.40,    107.42],[    175.63,    110.87],[    165.00,    116.79],
[    157.79,    120.58],[    146.08,    126.73],[    144.07,    127.46],[    139.04,    127.46],
[    133.03,    127.46],[    132.88,    127.38],[    134.36,    124.70],[    135.36,    122.91],
[    139.45,    112.99],[    142.10,    105.96],[    146.63,     93.96],[    138.40,     67.12],
[    124.73,     49.26],[    115.98,     37.84],[     99.42,     24.08],[     72.58,      5.93],
[     62.38,     -0.97],[     48.40,     -7.54],[     43.93,     -7.54],[     43.16,     -7.54],
[     40.53,     -8.78],[     38.09,    -10.29],[     33.68,    -13.02],[     33.65,    -13.08],
[     32.37,    -21.26],[     31.49,    -26.91],[     31.29,    -34.24],[     31.73,    -44.76],
[     32.48,    -62.44],[     34.15,    -71.58],[     37.23,    -74.86],[     38.42,    -76.13],
[     39.40,    -77.65],[     39.40,    -78.23],[     39.40,    -80.28],[     47.15,    -87.26],
[     56.23,    -93.37],[     61.27,    -96.76],[     65.80,    -99.54],[     66.31,    -99.54],
[     66.82,    -99.54],[     67.38,    -99.92],[     67.57,   -100.38],[     67.86,   -101.11],
[     82.78,   -111.53],[     99.40,   -122.61],[    102.43,   -124.63],[    109.40,   -128.63],
[    114.90,   -131.51],[    121.24,   -134.83],[    125.99,   -138.08],[    127.88,   -140.39],
[    129.52,   -142.40],[    133.17,   -146.51],[    136.00,   -149.54],[    138.83,   -152.56],
[    144.14,   -158.24],[    147.80,   -162.14],[    151.46,   -166.05],[    156.03,   -170.10],
[    157.97,   -171.14],[    159.90,   -172.19],[    161.73,   -174.00],[    162.02,   -175.17],
[    162.32,   -176.35],[    164.12,   -178.15],[    166.02,   -179.17],[    168.75,   -180.64],
[    169.42,   -181.57],[    169.19,   -183.54],[    168.95,   -185.63],[    168.33,   -186.07],
[    165.44,   -186.21],[    160.58,   -186.45],[    159.22,   -185.65],[    150.62,   -177.54],
[    144.18,   -171.46],[    137.29,   -165.99],[    135.10,   -165.20],[    132.91,   -164.42],
[    133.05,   -164.68],[    140.10,   -174.23],[    143.24,   -178.50],[    145.40,   -182.47],
[    145.40,   -183.98],[    145.40,   -186.85],[    144.30,   -187.07],
   ]);
}