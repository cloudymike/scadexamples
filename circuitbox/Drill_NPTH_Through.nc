( pcb2gcode 2.5.0 )
( Software-independent Gcode )

( This file uses 2 drill bit sizes. )
( Bit sizes: [1.524mm] [2.2mm] )

G94       (Millimeters per minute feed rate.)
G21       (Units == Millimeters.)
G90       (Absolute coordinates.)
G00 S10000     (RPM spindle speed.)

G00 Z5.00000 (Retract)
T1
M5      (Spindle stop.)
G04 P1.00000
(MSG, Change tool bit to drill size 1.524mm)
M0      (Temporary machine stop.)
M3      (Spindle on clockwise.)
G0 Z1.00000
G04 P1.00000

G1 F25.00000
G0 X-13.60500 Y44.61500
G1 Z-1.80000
G1 Z1.00000
G0 X-13.60500 Y51.61500
G1 Z-1.80000
G1 Z1.00000

G00 Z5.00000 (Retract)
T2
M5      (Spindle stop.)
G04 P1.00000
(MSG, Change tool bit to drill size 2.2mm)
M0      (Temporary machine stop.)
M3      (Spindle on clockwise.)
G0 Z1.00000
G04 P1.00000

G1 F25.00000
G0 X-1.41300 Y3.34300
G1 Z-1.80000
G1 Z1.00000
G0 X-2.98900 Y27.25300
G1 Z-1.80000
G1 Z1.00000
G0 X-2.99700 Y27.25300
G1 Z-1.80000
G1 Z1.00000
G0 X-2.97500 Y50.53600
G1 Z-1.80000
G1 Z1.00000
G0 X-2.98900 Y50.55300
G1 Z-1.80000
G1 Z1.00000
G0 X-26.77500 Y50.54900
G1 Z-1.80000
G1 Z1.00000
G0 X-26.78900 Y50.55300
G1 Z-1.80000
G1 Z1.00000
G0 X-26.78900 Y27.25300
G1 Z-1.80000
G1 Z1.00000
G0 X-26.77500 Y27.23800
G1 Z-1.80000
G1 Z1.00000
G0 X-64.40500 Y51.09500
G1 Z-1.80000
G1 Z1.00000
G0 X-64.40500 Y3.34300
G1 Z-1.80000
G1 Z1.00000

G00 Z5.000 ( All done -- retract )

M5      (Spindle off.)
G04 P1.000000
M9      (Coolant off.)
M2      (Program end.)

