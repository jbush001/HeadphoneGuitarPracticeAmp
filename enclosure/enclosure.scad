$fn = 64;

wall_thickness = 1.3;
pcb_width = 75;
pcb_height = 30;
pcb_relief = 0.5;
pcb_thickness = 1.57;
inner_width = pcb_width + pcb_relief * 2;
inner_height = pcb_height + pcb_relief * 2;
inner_radius = 2.5 + pcb_relief;
boss1x = inner_radius + wall_thickness;
boss1y = inner_radius + wall_thickness;
top_boss_height = 3;
boss_x_spacing = 70;
boss_y_spacing = 25;
epsilon = 0.01; // Used to avoid z-fighting
lower_boss_outer = 5;
top_enclosure_height = 15;
plug_housing_length = 20;

module rounded_rect(width, height, depth, radius) {
    hull() {
        translate([radius, radius, 0]) cylinder(r=radius, h=depth);
        translate([width - radius, radius, 0]) cylinder(r=radius, h=depth);
        translate([radius, height - radius, 0]) cylinder(r=radius, h=depth);
        translate([width - radius, height - radius, 0]) cylinder(r=radius, h=depth);
    }
}

module top_boss_outer() {
    cylinder(h=top_boss_height, d=4.5);
}

module top_boss_inner() {
    cylinder(h=top_boss_height + 2, d=2.3);
    cylinder(h=top_boss_height - wall_thickness, d=3.5);
}


module enclosure_top() {
    // Shell
    difference() {
        union() {
            difference() {
                union() {
                    rounded_rect(inner_width + wall_thickness * 2, inner_height + wall_thickness * 2, top_enclosure_height, inner_radius + wall_thickness);
                    // Plug housing
                    rotate([-90, 0, 0]) translate([top_enclosure_height / 2, -top_enclosure_height / 2, inner_height - 1])
                        cylinder(d=top_enclosure_height, h=plug_housing_length);
                }

                union() {
                    // Inner shell
                    translate([wall_thickness, wall_thickness, wall_thickness]) rounded_rect(inner_width, inner_height, top_enclosure_height, inner_radius);

                    // Interior of plug housing
                    rotate([-90, 0, 0]) translate([top_enclosure_height / 2, -top_enclosure_height / 2, inner_height - wall_thickness])
                        cylinder(d=top_enclosure_height - wall_thickness * 2, h=plug_housing_length - wall_thickness);

                    // Plug hole
                    rotate([-90, 0, 0]) translate([top_enclosure_height / 2, -top_enclosure_height / 2, inner_height + 10]) cylinder(d=10, h=10);
                }
            }

            translate([boss1x, boss1y, epsilon]) top_boss_outer();
            translate([boss1x + boss_x_spacing, boss1y, epsilon]) top_boss_outer();
            translate([boss1x, boss1y + boss_y_spacing, epsilon]) top_boss_outer();
            translate([boss1x + boss_x_spacing, boss1y + boss_y_spacing, epsilon]) top_boss_outer();
        }

        union() {
            // USB port
            translate([inner_width, (inner_height + wall_thickness * 2) / 2 - 4, top_boss_height + pcb_thickness]) cube([20, 8, 4]);

            // Audio Jack
            translate([10 + wall_thickness + pcb_relief, -epsilon, top_boss_height + wall_thickness + 3.5 / 2 + 0.5]) rotate([0, 90, 90]) cylinder(d=6, h=5);

            // Power Switch
            // Left side 42.291 mm, right 51.308, middle 46.8
            // 2mm travel, switch is 1.5mm wide. Extents are 46.8 +/- (2 + 1.5) / 2
            translate([pcb_relief + wall_thickness + 44.5, -1, top_boss_height + pcb_thickness + 1]) cube([4, 2.5, 4]);

            // Holes for push buttons
            for (i = [0:3]) {
                translate([wall_thickness + (35 + 8 * i), wall_thickness + inner_height - 5, -epsilon]) cylinder(d=6, h=5);
            }

            // XXX Light pipe for charging LED

            // Screw bosses
            translate([boss1x, boss1y, -epsilon]) top_boss_inner();
            translate([boss1x + boss_x_spacing, boss1y, -epsilon]) top_boss_inner();
            translate([boss1x, boss1y + boss_y_spacing, -epsilon]) top_boss_inner();
            translate([boss1x + boss_x_spacing, boss1y + boss_y_spacing, -epsilon]) top_boss_inner();
        }
    }
}

module button() {
    cylinder(h=1, d=7);
    cylinder(h=4, d=5.5);
}

module bottom_boss() {
    bottom_boss_height = top_enclosure_height - top_boss_height - pcb_thickness;
    difference() {
        cylinder(h=bottom_boss_height, d=4.2);
        translate([0, 0, 2]) cylinder(h=bottom_boss_height, d=1.8);
    }
}

module enclosure_bottom() {
    difference() {
        union() {
            rounded_rect(inner_width - pcb_relief * 2, inner_height - pcb_relief, wall_thickness, inner_radius);

            // Screw bosses
            translate([boss1x - wall_thickness, boss1y - wall_thickness, epsilon]) bottom_boss();
            translate([boss1x - wall_thickness+ boss_x_spacing, boss1y - wall_thickness, epsilon]) bottom_boss();
            translate([boss1x - wall_thickness, boss1y - wall_thickness + boss_y_spacing, epsilon]) bottom_boss();
            translate([boss1x - wall_thickness + boss_x_spacing, boss1y - wall_thickness + boss_y_spacing, epsilon]) bottom_boss();
        }
    }
}

// Placeholder for logic board, used to check placement in assembly model.
module logic_board() {
    difference() {
        union() {
            color("purple") hull() {
                translate([2.5, 2.5, 0]) cylinder(r=2.5, h=pcb_thickness);
                translate([72.5, 2.5, 0]) cylinder(r=2.5, h=pcb_thickness);
                translate([2.5, 27.5, 0]) cylinder(r=2.5, h=pcb_thickness);
                translate([72.5, 27.5, 0]) cylinder(r=2.5, h=pcb_thickness);
            }
        }

        union() {
            translate([2.5, 2.5, -0.1]) cylinder(h=10, d=2.2);
            translate([72.5, 2.5, -0.1]) cylinder(h=10, d=2.2);
            translate([2.5, 27.5, -0.1]) cylinder(h=10, d=2.2);
            translate([72.5, 27.5, -0.1]) cylinder(h=10, d=2.2);
        }
    }
}

module battery() {
    color("gray") cube([36, 20, 5.6]);
}

module plug() {
    // Total length is 48.815625, 1 59/64"
    translate([-1.5, -3, 0]) cube([3, 1, 11]);
    translate([-1.5, 2, 0]) cube([3, 1, 11]);

    translate([0, 0, 11]) cylinder(h=6, d=10);
    translate([0, 0, 17.25]) cylinder(d1=11.8872, d2=10, h=1);
    translate([0, 0, 18.25]) cylinder(h=25, d=6.324);
    translate([0, 0, 43.25]) cylinder(h=5.55, d1=6.324, d2=1);

}

module assembly(case_alpha) {
    translate([wall_thickness + pcb_relief, wall_thickness + pcb_relief, 3]) logic_board();
    for (i = [0:3]) {
        color("blue") translate([36.5 + i * 8, 27.5, 3]) rotate([0, 180, 0]) button();
    }

    translate([25, 7, 6]) battery();

    // Render this last to see inner components
    color("yellow", case_alpha) enclosure_top();
    color("red", case_alpha) translate([wall_thickness + pcb_relief, inner_height + wall_thickness - pcb_relief / 2, top_enclosure_height]) rotate([0, 180, 180]) enclosure_bottom();
    color("white") rotate([-90, 0, 0]) translate([top_enclosure_height / 2, -top_enclosure_height / 2, 33]) plug();
}

module cutaway() {
    difference() {
        assembly(1);
        translate([-1, -1, -1]) cube([6, 100, 100]);
    }
}

module printable() {
    for (i = [0:3])
        translate([i * 8, 0, 0]) button();

    translate([0, 7, 0]) enclosure_bottom();
    translate([0, 40, 0]) enclosure_top();
}

//cutaway();
//assembly(1);
printable();
