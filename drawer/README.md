# Drawer tiles
The idea of this collection is to provide storage that would work in a drawer. 
Instead of using the traditional dividers, this uses tiles that connects in the drawer
and have special purpose storage. See the tiles section below for the current version of things to store.

The basic tile is based on the Interocking Boxes by JordanGrant (https://www.thingiverse.com/thing:3104430). Instead of just doing boxes this is the basis for "tiles" that are customized
for special purpose storage.

The tiles are all create with OpenScad, that allows easy expansion. Many tiles are based on a 
"base tile" and then allow you to create a larger tiles without the interconnections.

I stayed with the base tile of 40x40mm. As this is all Openscad and parametric it should 
be possibe to use other dimensions.

The idea is simple, just make something fit into one (or several) tiles. Please make make sure you add your remix, I may want to pick it up for my drawer :).

## The tiles
This section is a description of the differnt tiles that (so far) I have created. The headlines
refer to scad files, just add .scad to the name.

##9v
For 9 volt batteries. Each 40mmx40mm tile can hold 2 batteries.

#AA
This tile is for AA batteries. The layout algoritm is done to pack as many batteries as possible
into a tile. Thus a 3x3 tiles (120x120mm) may have more batteries than 9 1x1 tiles.

#AAA
Same as AA but, you guessed it, for AAA batteries.

##applepower
Apple provides a slide in power plug for their power supply and it if you travel you can get 
a collection of these for different counties. This tile allow you to save the plugs on a tile.

##bigcableholders
A 40x40mm tile that has a big hole to hold a fairly large USB (or other) cable. The holder is 120mm high, that worked for me and my drawer but is customizable.

## buttonBattery
This is a small tile to hold 357 style of button batteries.

## cabeHolders
Intended to hold 2 USB or other smaller cables. 120mm tall. Similar to bigcableholders

## coinbattery
Creates a tile  for many popular coinbatteries. As the name tells the dimensions of the battery, it is use to defined the slots for the batteries.This requires TOUL.scad, to extract the parameters, it is included, and sourced from:
Author: Nathanaël Jourdane
Email: nathanael@jourdane.net
thingiverse: http://www.thingiverse.com/thing:1237203

## interlockingmodule
This is from https://www.thingiverse.com/thing:3104430. It is modulerized to make it easy
to use in the other tiles. Also created a "negative space" that can be used with difference
to remove anything that is interfering with the frame and the dovetails.

## nozzle
A tile to save your Ender3 (or any other MK8) nozzles. This is a M6 threaded hole. For me this
required using 0.12mm layers. You may want to try out a small tile of this to see what works with your printer.
Uses threads module: https://www.thingiverse.com/thing:1938150


## phones.scad
This provides slots for something like an iphone or an ipad, based on the with of the tile you create.

## spacer
Most likely you will not be able to tile things out perfectly in your drawer. Thus the spacers.  They allow you to create an inexpensive (5mm tall) tile that will fill up the space, and thus hold in place, your other tiles.

## spring
Your drawer is probably not a perfect multiplier of 40mm. The spring is a flexilble tile that you can put at the edge to push the tiles in place.


## TOUL
Helper code.
See thingiverse: http://www.thingiverse.com/thing:1237203

## usbchargers
These are basic US style power sockets, with the intention that you can plug in your USB chargers to save them in a tidy way.


