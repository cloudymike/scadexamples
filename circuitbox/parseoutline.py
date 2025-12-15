from gcodeparser import GcodeParser

def get_outline():
  # open gcode file and store contents as variable
  with open('Gerber_BoardOutlineLayer.nc', 'r') as f:
    gcode = f.read()

  parsed_gcode = GcodeParser(gcode, include_comments=True)
  allLines=parsed_gcode.lines
  minX=999999
  minY=999999
  maxX=-999999
  maxY=-999999

  for line in allLines:
    if line.command == ('G',1):
      X=line.get_param('X')
      Y=line.get_param('Y')
      if X is not None:
        minX=min(minX,X)
        maxX=max(maxX,X)
      if Y is not None:
        minY=min(minY,Y)
        maxY=max(maxY,Y)
  outline={'minX':minX,'maxX':maxX,'minY':minY,'maxY':maxY}
  return(outline)

if __name__ == "__main__":

  ol=get_outline()

  sizeX=ol['maxX']-ol['minX']
  sizeY=ol['maxY']-ol['minY']

  print(sizeX,sizeY)