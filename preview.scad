use <holder.scad>

a1_max = 150;
a1 = $t < 0.25 ? $t * a1_max
    : $t < 0.5 ? 0.25 * a1_max
    : $t < 0.75 ? (0.75 - $t) * a1_max
    : 0;

a2_max = 120;
a2 = $t < 0.25 ? 0
    : $t < 0.5 ? ($t - 0.25) * a2_max
    : $t < 0.75 ? 0.25 * a2_max
    : (1 - $t) * a2_max;


a1_0 = atan2(10, 110);
l = sqrt(100 + 110 ^ 2);
a3 = 0;

$vpr = [74.2, 0, 203.9 + $t * 360];

// elements
stand();
translate([0, 0, 30]) rotate([0, -a1, 0]) extension();
translate([l * cos(a1 + a1_0), 4, 30 + l * sin(a1 + a1_0)])
rotate([0, -a2, 180])
    {
        extension();
        translate([0, 8, 0]) extension();
        
        translate([0, 10, 0]) screw();
        translate([0, -2, 0]) nut();
        
        translate([110, 10, 10]) screw();
        translate([110, -2, 10]) nut();
        
        translate([110, 4, 10])
        rotate([0, a3, 0]) {
            holder();
            %translate([0, 0, 14]) mic();
        }
    }

translate([0, 6, 30]) screw();
translate([0, -6, 30]) nut();
