include <BOSL/constants.scad>
use <BOSL/threading.scad>
use <BOSL/involute_gears.scad>

module mic() {
    difference() {
        union() {
            translate([-10, -9.25, 0]) cube([20, 18.5, 1.8]);
            cylinder(10, 5.5, 5.5);
            
            translate([0, 0, 4]) cylinder(8, 15, 15);
        }
        cube([22, 10, 1.6], true);
    }
}


module holder() {
    $fn = 100;
    
    translate([10, 0, 14])
        rotate([0, -90, 0])
        linear_extrude(20)
        polygon([
            [-3, 12], [3.5, 12], [3.5, 6],
            [2, 6], [2, 9.4], [0, 9.4],
            [0, -9.4], [2, -9.4], [2, -6],
            [3.5, -6], [3.5, -12], [-3, -12]
        ]);

    difference() {
        union() {
            translate([-10, -2, 0]) cube([20, 4, 13]);
            translate([0, -2, 0]) rotate([-90, 0, 0]) cylinder(4, 10, 10);
        }
        translate([0, -3, 0]) rotate([-90, 0, 0]) cylinder(6, 4, 4); 
    }
}

module arm () {
    $fn = 100;
    
    translate([0, -3, 0])
    difference() {
        union() {
            rotate([-90, 0, 0]) cylinder(6, 5, 5);
            translate([0, 0, -100]) rotate([-90, 0, 0]) cylinder(6, 5, 5);
            translate([-5, 0, -100]) cube([10, 6, 100]);
        }
        
        translate([0, -1, 0]) rotate([-90, 0, 0]) cylinder(8, 2, 2);
        translate([0, -1, -100]) rotate([-90, 0, 0]) cylinder(8, 2, 2);
        translate([-6, 1.9, -6]) cube([12, 2.2, 12]);
        translate([-6, 1.9, -106]) cube([12, 2.2, 12]);
    }    
}


module fork() {
    difference() {
        union() {
            rotate([-90, 0, 0]) cylinder(12, 10, 10);
            translate([-10, 0, -15]) cube([20, 12, 15]);
        }
        
        translate([0, -1, 0]) rotate([-90, 0, 0]) cylinder(14, 4, 4);
        translate([-11, 3.9, -12]) cube([22, 4.2, 23]);
    }
}


module stand() {
    module leg() {
        cube([100, 12, 3]);
        translate([0, 4, 0]) cube([100, 4, 8]);
    }
    
    $fn = 100;
    
    translate([0, -6, 30]) fork();
    
    translate([0, 0, 7.5]) cube([20, 12, 15], true);
    
    translate([0, -6, 0]) leg();
    rotate([0, 0, 120]) translate([0, -6, 0]) leg();
    rotate([0, 0, -120]) translate([0, -6, 0]) leg();
}


module screw() {
    $fn = 60;
    
    rotate([90, 0, 0])
    union (){
        rotate([0, 180, 0]) cylinder(1, 6, 6);
        translate([0, 0, -1]) rotate([0, 180, 0]) cylinder(4, 6, 2);
        
        
        if ($preview) {
            cylinder(20, 3.9, 3.9);
        } else {
            threaded_rod(d=7.8, l=20, pitch=1.25, bevel2=true, align=[0, 0, 1], $fa=1, $fs=1);
        }
            
        translate([0, 0, -3]) cube([4, 16, 6], true);
    }
}

module extension() {
    $fn=100;
    difference() {
        union() {
            translate([0, -2, 0]) cube([110, 4, 10]);
            translate([110, 2, 10]) rotate([90, 0, 0]) cylinder(4, 10, 10);
            translate([0, 2, 0]) rotate([90, 0, 0]) cylinder(4, 10, 10);

        }

        translate([110, -7, 10]) rotate([-90, 0, 0]) cylinder(14, 4, 4);
        translate([0, -5, 0]) rotate([-90, 0, 0]) cylinder(14, 4, 4);
    }
    
}


module nut() {
    $fn = 60;
    
    rotate([90, 30, 0])
        if ($preview) {
            cylinder(6, 8.1, 8.1, $fn=6);
        }
        else {
            threaded_nut(od=14, id=7.8, h=6, pitch=1.25, align = V_UP, $fa=1, $fs=1);
        }
        

    translate([-1.5, -6, 5]) cube([3, 6, 5]);
    rotate([0, 180, 0]) translate([-1.5, -6, 5]) cube([3, 6, 5]);
}


module leg() {
    $fn = 100;
    
    translate([0, -5, 0]) cube([100, 5, 5]);
    translate([0, 0, 0]) cube([100, 5, 5]);
    difference() {
        cylinder(2, 5, 5);
        translate([0, 0, 1]) cylinder(2, 4, 4);
    }
}

a1 = 0;
a2 = 0;
a3 = 0;

a1_0 = atan2(10, 110);
l = sqrt(100 + 110 ^ 2);

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
