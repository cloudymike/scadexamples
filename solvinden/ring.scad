
// Ring to fasten the shade to lamp
// outsidediameter should be matching the lampshade to make it look nice, but must be 87mm or larger


$fa = 1;
$fs = 0.4;

module ringattachment(outsidediameter=87) {
  difference() {
    cylinder(d=outsidediameter,h=2,center=true);
    cylinder(d=82,h=2,center=true);
  }
}

ringattachment(90);