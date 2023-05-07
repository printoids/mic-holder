// Define the dimensions of the tripod
base_width = 15;
base_depth = 15;
pole_height = 20;
pole_radius = 1;
platform_width = 5;
platform_depth = 5;
platform_thickness = 0.5;
leg_width = 2;
leg_depth = 2;
leg_height = 10;
num_legs = 3; // specify the number of legs

// Create the tripod module with multiple legs
module tripod() {
    // Create the base
    difference() {
        cube([base_width, base_depth, platform_thickness]);
        for (i = [0:num_legs-1]) {
            angle = i * 360 / num_legs;
            translate([base_width/2 + cos(angle)*((base_width-leg_width)/2), base_depth/2 + sin(angle)*((base_depth-leg_depth)/2), 0]) cube([leg_width, leg_depth, platform_thickness]);
        }
    }
    
    // Create the pole
    translate([base_width/2, base_depth/2, platform_thickness]) cylinder(r=pole_radius, h=pole_height);
    
    // Create the platform
    translate([base_width/2 - platform_width/2, base_depth/2 - platform_depth/2, platform_thickness + pole_height]) cube([platform_width, platform_depth, platform_thickness]);
}

// Call the tripod module to create the tripod
tripod();