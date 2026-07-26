/*
Traced from the supplied overhead photograph.

Overall width: 28.0 mm
Approximate height from photograph: 26.722 mm
Thickness: 1.0 mm

The photograph provides reliable plan-view geometry but not reliable
depth information for the molded-looking surface features, so this model
reproduces the outside profile as a uniform 1 mm thick part.
*/

part_width = 28.0;
part_thickness = 1.0;

module plastic_piece_2d() {
    polygon(points=[
        [12.972, 12.859],
        [12.371, 13.286],
        [11.769, 12.985],
        [7.132, 13.361],
        [-0.213, 12.784],
        [-6.254, 11.004],
        [-10.365, 8.297],
        [-12.947, 4.462],
        [-13.850, 1.153],
        [-14.000, -0.426],
        [-13.699, -1.780],
        [-13.975, -1.880],
        [-12.446, -5.490],
        [-12.697, -5.841],
        [-11.594, -7.244],
        [-11.644, -7.771],
        [-11.042, -7.721],
        [-11.017, -8.222],
        [-10.616, -8.272],
        [-10.791, -8.799],
        [-10.039, -9.300],
        [-9.563, -9.175],
        [-9.563, -9.701],
        [-9.939, -9.801],
        [-8.585, -9.977],
        [-8.385, -10.428],
        [-7.107, -10.879],
        [-7.031, -11.180],
        [-2.870, -12.559],
        [1.767, -13.361],
        [9.187, -13.336],
        [13.173, -12.935],
        [14.000, -12.433],
        [12.621, -4.988],
        [12.220, -0.376],
        [12.195, 3.259]
    ]);
}

linear_extrude(height=part_thickness, convexity=10)
    plastic_piece_2d();
