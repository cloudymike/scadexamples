use <../lightstake/stake.scad>
use <sleeve.scad>

sleeve_d=29;
sleeve_h=29;

stake(h=75,b=sleeve_d/2, w=2);
translate([0,0,-sleeve_h/2])rotate([180,0,0])sleeve(sleeve_h, sleeve_d);