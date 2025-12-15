from gcodeparser import GcodeParser


def get_mounts():
  # open gcode file and store contents as variable
  with open('Drill_NPTH_Through.nc', 'r') as f:
    gcode = f.read()

  parsed_gcode = GcodeParser(gcode, include_comments=True)
  allLines=parsed_gcode.lines
  mountlist=[]

  prevX=99999
  prevY=99999
  for line in allLines:
    if line.command == ('G',0):
      X=line.get_param('X')
      Y=line.get_param('Y')
      if X is not None:
        if (abs(Y-prevX) > 1) and (abs(Y-prevY) > 1):
          XY=[X,Y]
          mountlist.append(XY)
        prevX=X
        prevY=Y
  return(mountlist)


if __name__ == "__main__":
  print(get_mounts())
