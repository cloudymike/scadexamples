use <basket_module.scad>

basketwidth = 30;
basketlength = 222;
basketdepth = 170;

basket(
  binDimensions = [ basketlength, basketwidth, basketdepth],
  binWallThickness = 3,
  binMaxGapSize = 15,
  screwSlotPositions = [
    [ 2,7 ],
    [ 7,7 ]
  ],
  screwHeadDiameter = 6.7,
  screwThreadDiameter = 3.6

);

