use <interlockingmodule.scad>
use <TOUL.scad>

// Coin battery holder
// Tried to extract size from name so it is just one module
// Tested for CR2032,CR2020,CR1632


module CoinBatteryTile(BatteryName="CR2032")
{
    $fn=120;
    OverExtrusion = 0.2;
    height=14;
    interval = 16.5;
    diameter=14.2+2*OverExtrusion;
    
    BoxUnits=40;
    BoxWidthUnits=1;
    BoxLengthUnits=1;
    
    WallAdjust = 1;
    
    assert((substr(BatteryName,0,2)=="CR"),"Name must start with CR, for coin battery");
    BatteryDiameter = atoi(substr(BatteryName,2,2));
    BatteryHeight = atoi(substr(BatteryName,4,2))/10;
    echo("Battery Diameter",BatteryDiameter);
    echo("Battery Height",BatteryHeight);
    
    HoleDiameter = BatteryDiameter+2*OverExtrusion;
    HoleHeight = BatteryHeight+2*OverExtrusion;
    
    difference () {
      interlockingbox(
        //Box Width in units
        BoxWidthUnits = BoxWidthUnits,
        //Box Length in units
        BoxLengthUnits = BoxLengthUnits,
        //Box Height in mm
        BoxHeight = height,
        //Box Floor Thickness in mm
        BoxFloor = height+0.01
    );
      for (count = [0:6])
         BatteryHole(count*5+5, count, HoleDiameter, HoleHeight);
    
    }
    translate([1,3,height ]) linear_extrude(1) text(BatteryName,size=3,font="Liberation Sans:style=Bold");
}
module BatteryHole(y,count, HoleDiameter, HoleHeight) {
  x = (count % 2 == 1 ) ? 12:28;
  translate([x,y,11]) rotate([90,0,0]) cylinder(d=HoleDiameter,h=HoleHeight,center=true);
  translate([x,y,13]) rotate([90,0,0]) cube([HoleDiameter,4,HoleHeight],center=true);
}


CoinBatteryTile("CR1632");