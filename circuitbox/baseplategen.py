

import parseoutline
import parsemounts


mounts=parsemounts.get_mounts()



ol=parseoutline.get_outline()

sizeX=ol['maxX']-ol['minX']
sizeY=ol['maxY']-ol['minY']


# Center mount and flip Y as hole file is from bottom of board
adjusted_mounts=[]
for XY in mounts:
	X=XY[0]-ol['minX']-sizeX/2
	Y=-XY[1]+ol['minY']+sizeY/2
	adjXY=[X,Y]
	adjusted_mounts.append(adjXY)

scadstring="""use <baseplate.scad>
baseplate(
  board_length={0},
  board_width={1},
  mount_holes={2}
);

""".format(sizeX,sizeY,adjusted_mounts)

print(scadstring)