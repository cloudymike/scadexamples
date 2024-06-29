use <basket_module.scad>

basketwidth = 80;
basketlength = 170;
basketdepth = 25;

basket(
  binDimensions = [ basketlength, basketwidth, basketdepth],
  binWallThickness = 3,
  binMaxGapSize = 15,
  screwSlotPositions = [
    [ 2,0 ],
    [ 5,0 ]
  ]

);

