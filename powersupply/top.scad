use <../usbc2power/usbcslot.scad>
plateThickness=2;
printmargin=0.2;

module topPlate()
{
  cube([83,83,plateThickness],center=true);
}


difference ()
{
  topPlate();
  translate([0,15,0])cube([76,39,plateThickness+printmargin],center=true);
  translate([-25,-25,0]) cube([boardBoxX(),boardBoxZ(),plateThickness],center=true); // USB connector
}

translate([-25,-25-boardBoxZ()/2,-boardBoxY()/2+plateThickness/2-0.5])rotate([-90,0,0]) boardBox();