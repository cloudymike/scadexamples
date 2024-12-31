

function foot(x=1) = 304.8*x;
function inch(x=1) = 25.4*x;
function nominal(inch) = 
  (inch==1) ? 19 : 
  (inch==2) ? 38 : 
  (inch==4) ? 90 : 
  (inch==6) ? 140 : 
  0;

module lumber6feet2x4()
{
  cube([foot(6),38,90],center=true);
  echo("2x4 6 feet");
}

module lumber8feet2x4()
{
  cube([foot(8),38,90],center=true);
  echo("2x4 8 feet");
}
