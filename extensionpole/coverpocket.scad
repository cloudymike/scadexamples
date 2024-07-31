
wall=2;
coverlength=10;
difference()
{
  linear_extrude(height=coverlength) polygon([[0-wall,0-wall],[43+wall,0-wall],[48+wall,60],[-5-wall,60]]);
  linear_extrude(height=coverlength) polygon([[0,0],[43,0],[48,60],[-5,60]]);
}