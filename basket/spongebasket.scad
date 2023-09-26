use <basket_module.scad>
use <shelfhook.scad>

basketheight = 65;
basketwidth = 200;
basketdepth = 80;

basket(
  binDimensions = [ basketwidth, basketheight, basketdepth],
  binWallThickness = 2,
  screwSlotPositions = []
);

translate([basketwidth/2,0,basketdepth]) rotate([0,0,180]) twoslot(11);