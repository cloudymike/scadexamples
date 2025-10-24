
$fn=64;
tolerance=0;

module winch_wheel(
  wheelWidth=8.86,
  coreRadius=3,
  flangesRadius=7,
  axelLength=8.86
)
{
  
  axelRadius=1.65+tolerance;
  axelCutout=0.56;
  tieHoleRadius=0.6;
  
  difference (
    wheelWidth=8.86,
    coreRadius=3,
    flangesRadius=7,
    axelLength=8.86
  )
  {
      rotate_extrude($fn=200) 
      polygon([[0,0],[flangesRadius,0],[coreRadius,wheelWidth/3],[coreRadius,2*wheelWidth/3],[flangesRadius,wheelWidth],[0,wheelWidth]]);
  
      // Axel
      difference()
      {
          translate([0,0,wheelWidth/2])cylinder(r=axelRadius,h=wheelWidth,center=true);
          translate([axelRadius,0,wheelWidth/2])cube([axelCutout*2,axelRadius*2,wheelWidth],center=true);
      }
      
      // Tie hole
      translate([coreRadius+tieHoleRadius,0,wheelWidth/2])cylinder(r=tieHoleRadius,h=wheelWidth,center=true);
  }
  // Handle
  handleHeight=7;
  handleWidth=2*axelRadius;
  
  // A 3.3mm gap should be fine to bridge. If not add difference
  difference()
  {
    translate([0,0,handleHeight/2+wheelWidth])
      cube([handleWidth,2*flangesRadius,handleHeight],center=true);
    //translate([0,0,handleHeight/2+wheelWidth])
    //  cube([handleWidth,axelRadius*2,handleHeight],center=true);
  }
}


winch_wheel();