/*
Parametric crescent-shaped plastic piece.

Geometry:
- Convex half-ellipse on the left.
- Concave semicircle on the right.
- Two sharp junctions at the top and bottom.
- Uniform extrusion thickness.

All dimensions are in millimeters.
*/

overall_width  = 28.0;   // From leftmost outer edge to the two corner line
overall_height = 26.6;   // Distance between the two sharp corners
thickness      = 1.0;

outer_segments = 160;
inner_segments = 120;

module plastic_piece_2d(
    width = overall_width,
    height = overall_height,
    outer_fn = outer_segments,
    inner_fn = inner_segments
) {
    half_height = height / 2;
    //inner_radius = half_height/8;  // True semicircle
    inner_radius = half_height/7;  // True semicircle

    /*
      Both curves share endpoints at:
          [0,  height/2]
          [0, -height/2]

      The outer ellipse reaches x = -width.
      The inner semicircle reaches x = -height/2.
    */

    outer_arc = [
        for (i = [0 : outer_fn])
            let(a = 90 + 180 * i / outer_fn)
            [
                width * cos(a),
                half_height * sin(a)
            ]
    ];

    inner_arc = [
        for (i = [0 : inner_fn])
            let(a = -90 + 180 * i / inner_fn)
            [
                -inner_radius * cos(a),
                half_height * sin(a)
            ]
    ];

    polygon(points = concat(outer_arc, inner_arc));
}

linear_extrude(height = thickness, convexity = 10)
    plastic_piece_2d();
