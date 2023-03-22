include <BOSL/constants.scad>
use <BOSL/metric_screws.scad>
// fn will be overridden by test script
$fn=100;

metric_nut(size=6, hole=true, pitch=1, flange=3, details=true);
