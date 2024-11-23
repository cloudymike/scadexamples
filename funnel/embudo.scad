//Simple funnel
//embudo sencillo
//define 3 radius dimensions
//define 3 heigths 
//define thickness

R1=20;
R2=5;
R3=4;

H0=5;
H1desired=25;
H1=max(H1desired,R1-R2);//to prevent overhangs <45º, H1>R1-R2
H2=20;



thick=0.8;//you might want to take into account your nozzle size

Sides=3.15*R1;//feel free to replace the formula by any number



difference() {

cylinder (h=H0, r=R1, $fn=Sides);
cylinder (h=H0, r=R1-2*thick,  $fn=Sides);
} // end difference


translate ( [0,0,H0])
difference() {

cylinder (h=H1, r1=R1, r2=R2,  $fn=Sides);
cylinder (h=H1, r1=R1-2*thick, r2=R2-2*thick,  $fn=Sides);
} // end difference

translate ( [0,0,H0+H1])
difference() {

cylinder (h=H2, r1=R2, r2=R3,  $fn=Sides);
cylinder (h=H2, r1=R2-2*thick, r2=R3-2*thick,  $fn=Sides);
} // end difference