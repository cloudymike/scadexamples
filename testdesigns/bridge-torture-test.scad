bridge_length = 50;
bridge_angle = 0;
bridge_width = 5;

bridge_recovery_layers = 10;

layer_height = 0.1;
extrusion_width = 0.5;

module foot() {
	rotate([0, 0, 180/4]) cylinder(r=bridge_width * 2, h=layer_height, $fn=4);
}

module strut() {
	rotate([0, 0, 180/4])
	difference() {
		cylinder(r1=bridge_width / 1.5 / cos(45), r2=bridge_width / 2 / cos(45), h=10, $fn=4);
		translate([0, 0, -1]) cylinder(r1=(bridge_width / 1.5 - extrusion_width * 2) / cos(45), r2=(bridge_width / 2 - extrusion_width * 2) / cos(45), h=10, $fn=4);
	}
}

rotate(bridge_angle) {
	%translate([00, 0, 0]) foot();
	%translate([bridge_length + bridge_width, 0, 0]) foot();

	translate([00, 0, 0]) strut();
	translate([bridge_length + bridge_width, 0, 0]) strut();

	translate([bridge_width / -2, bridge_width / -2, 10]) cube([bridge_length + bridge_width * 2, bridge_width, layer_height * bridge_recovery_layers]);

	translate([bridge_length / 2 + bridge_width / 2, 0, 10 + layer_height * bridge_recovery_layers])
	difference() {
		cylinder(r=bridge_width / 2, h=1, $fn=32);
		cylinder(r=bridge_width / 2 - extrusion_width, h=1.01, $fn=32);
	}
}
