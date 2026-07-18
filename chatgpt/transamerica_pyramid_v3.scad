
/*
  Transamerica Pyramid — printable architectural model
  Approximate, stylized model designed for FDM printing without supports.

  Default size:
    overall height: 180 mm
    base plate:     66 x 66 mm
    tower base:     48 x 48 mm

  Suggested printing:
    Orientation: upright
    Layer height: 0.16–0.24 mm
    Walls: 3
    Infill: 10–15%
    Supports: none
    Brim: 5–8 mm for tall prints

  Set show_window_bands = false for a faster, simpler render.
*/

$fn = 48;

// ---------- User parameters ----------
model_height       = 180;
tower_base_width   = 48;
base_plate_width   = 66;
base_plate_height  = 3.0;

spire_fraction     = 0.25;   // upper fraction of total height
wing_start_fraction= 0.52;   // measured against total tower height
wing_end_fraction  = 0.76;   // automatically clamped below the spire

show_window_bands  = true;
band_count         = 35;
band_depth         = 0.55;
band_height        = 0.65;

// ---------- Derived dimensions ----------
tower_height = model_height - base_plate_height;
spire_height = tower_height * spire_fraction;
body_height  = tower_height - spire_height;

top_body_width = tower_base_width * 0.20;
spire_base_width = top_body_width;
spire_tip_width  = 1.2;

wing_start_z = base_plate_height + tower_height * wing_start_fraction;
wing_end_z   = base_plate_height + tower_height * wing_end_fraction;
wing_height  = wing_end_z - wing_start_z;

// ---------- Helpers ----------
module tapered_square(h, bottom_w, top_w) {
    linear_extrude(height=h, scale=top_w/bottom_w)
        square([bottom_w, bottom_w], center=true);
}

module rounded_base_plate() {
    linear_extrude(height=base_plate_height)
        offset(r=2.2)
            square([base_plate_width-4.4, base_plate_width-4.4], center=true);
}

/*
  Return the width of the main occupied tower at a given absolute Z height.
  This lets the wings follow the actual sloping facade instead of being
  positioned from the much wider ground-floor footprint.
*/
function body_width_at_z(z) =
    tower_base_width -
    (tower_base_width - top_body_width) *
    ((z - base_plate_height) / body_height);

/*
  Connected elevator/service wings.

  Geometry verified against reference views of the building:
    - the outer face of each wing is vertical;
    - the main pyramid slopes inward behind it;
    - therefore the wing projects farther from the tower at the top;
    - the inner face overlaps the pyramid continuously from bottom to top.

  The wing is a closed eight-vertex polyhedron. Its outer X coordinate is
  constant while its inner X coordinate follows the taper of the tower.
*/
module attached_wing(side=1) {
    lower_z = max(base_plate_height + 1,
                  min(wing_start_z, base_plate_height + body_height - 70));
    upper_z = max(lower_z + 3,
                  min(wing_end_z, base_plate_height + body_height - 0.8));

    lower_face = body_width_at_z(lower_z) / 3;
    upper_face = body_width_at_z(upper_z) / 2;

    // The wing cuts into the tower this far for a continuous manifold joint.
    wing_overlap = max(2.8, tower_base_width * 0.06);

    // Set the vertical outer face from the lower attachment point.
    lower_projection = tower_base_width * 0.075;
    outer_abs_x = lower_face + lower_projection;

    // Constant front-to-back width, matching the slab-like service cores.
    wing_span = tower_base_width * 0.15;
    y0 = -wing_span / 2;
    y1 =  wing_span / 2;

    // Inner edges track the sloped tower and remain buried inside it.
    lower_inner_abs_x = lower_face - wing_overlap;
    upper_inner_abs_x = upper_face - wing_overlap;

    // Convert unsigned distances to the selected side of the tower.
    outer_x       = side * outer_abs_x;
    lower_inner_x = side * lower_inner_abs_x;
    upper_inner_x = side * upper_inner_abs_x;

    /*
      Vertex order is mirrored for the negative-X wing so all face normals
      remain consistent. The top is automatically thicker because
      upper_inner_abs_x is closer to the center while outer_abs_x is fixed.
    */
    if (side > 0) {
        polyhedron(
            points=[
                [lower_inner_x, y0, lower_z], // 0 lower inner front
                [outer_x,       y0, lower_z], // 1 lower outer front
                [outer_x,       y1, lower_z], // 2 lower outer back
                [lower_inner_x, y1, lower_z], // 3 lower inner back
                [upper_inner_x, y0, upper_z], // 4 upper inner front
                [outer_x,       y0, upper_z], // 5 upper outer front
                [outer_x,       y1, upper_z], // 6 upper outer back
                [upper_inner_x, y1, upper_z]  // 7 upper inner back
            ],
            faces=[
                [0,3,2,1], // bottom
                [4,5,6,7], // top
                [0,1,5,4], // front
                [1,2,6,5], // vertical outside
                [2,3,7,6], // back
                [3,0,4,7]  // sloped inner attachment
            ],
            convexity=10
        );
    } else {
        polyhedron(
            points=[
                [lower_inner_x, y0, lower_z], // 0 lower inner front
                [outer_x,       y0, lower_z], // 1 lower outer front
                [outer_x,       y1, lower_z], // 2 lower outer back
                [lower_inner_x, y1, lower_z], // 3 lower inner back
                [upper_inner_x, y0, upper_z], // 4 upper inner front
                [outer_x,       y0, upper_z], // 5 upper outer front
                [outer_x,       y1, upper_z], // 6 upper outer back
                [upper_inner_x, y1, upper_z]  // 7 upper inner back
            ],
            faces=[
                [1,2,3,0], // bottom
                [7,6,5,4], // top
                [4,5,1,0], // front
                [5,6,2,1], // vertical outside
                [6,7,3,2], // back
                [7,4,0,3]  // sloped inner attachment
            ],
            convexity=10
        );
    }
}

module wing_pair() {
    attached_wing(-1);
    attached_wing(1);
}

/*
  Shallow horizontal facade bands. They are intentionally embossed rather
  than cut deeply, preserving wall strength at small print scales.
*/
module facade_bands() {
    usable_h = body_height * 0.88;
    first_z  = base_plate_height + body_height * 0.06;

    for (i=[0:band_count-1]) {
        z = first_z + i * usable_h/(band_count-1);
        local_scale = 1 - (1-top_body_width/tower_base_width) *
                          ((z-base_plate_height)/body_height);
        local_w = tower_base_width * local_scale;

        translate([0, 0, z])
            difference() {
                cube([local_w + 2*band_depth,
                      local_w + 2*band_depth,
                      band_height], center=true);
                cube([local_w,
                      local_w,
                      band_height + 0.4], center=true);
            }
    }
}

module tower() {
    union() {
        // Main tapered occupied tower
        translate([0,0,base_plate_height])
            tapered_square(body_height, tower_base_width, top_body_width);

        // Tall pyramidal crown/spire
        translate([0,0,base_plate_height + body_height])
            tapered_square(spire_height, spire_base_width, spire_tip_width);

        wing_pair();

        if (show_window_bands)
            facade_bands();
    }
}

module entrance_detail() {
    // Small, printable entrance canopy on the front face.
    canopy_w = tower_base_width * 0.24;
    canopy_d = 2.4;
    canopy_h = 2.2;

    translate([0, -tower_base_width/2 - canopy_d/2 + 0.4,
               base_plate_height + 4.0])
        cube([canopy_w, canopy_d, canopy_h], center=true);
}

// ---------- Final model ----------
union() {
    rounded_base_plate();
    tower();
    entrance_detail();
}
