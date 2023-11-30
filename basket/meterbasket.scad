use <basket_module.scad>

basketheight = 60;
basketwidth = 170;
basketdepth = 25;

basket(
  binDimensions = [ basketwidth, basketheight, basketdepth],
  binWallThickness = 2,
  binMaxGapSize = 15,
  screwSlotPositions = [
    [ 2,0 ],
    [ 5,0 ]
  ]

);

