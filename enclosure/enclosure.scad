//
// Print Settings (tested with Cura Slicer, Creality Ender 3)
//   Infill Density: 100%
//   Support Placement: Everywhere
//   Support Density: 8%
//   Layer Height: 0.2mm
//

EPSILON=0.01; // Used to avoid z-fighting
RELIEF=0.5; // Gap between interfacing parts
WALL=2; // Thickness of wall
PCB_THICKNESS=1.57; // Oshpark 4 layer board
$fs = 0.5;
$fa = 0.5;

EDGE_RADIUS=2.5 + WALL + RELIEF;
PCB_WIDTH=80;
PCB_HEIGHT=30;
PCB_SCREW_INSET=2.5;
PCB_OFFSET=4;
TOP_SHELL_DEPTH=8;
BOTTOM_SHELL_DEPTH=8.5;
LIP_HEIGHT = 1.5;
PLUG_LARGE_RADIUS=16 / 2;
PLUG_CYLINDER_LEN = 37;
PLUG_OPENING_ID=10;
PLUG_OFFSET=8;  // along width
BOSS1_ID=2.2;   // For an M2 screw, should be larger
BOSS2_ID=1.8;   // Also for M2 screw, we want it to self thread into this.
COUNTERBORE_DEPTH=2;
COUNTERBORE_ID=3.8;
SHELL_WIDTH=PCB_WIDTH + RELIEF * 2 + WALL * 2;
SHELL_HEIGHT=PCB_HEIGHT + RELIEF * 2 + WALL * 2;
BOSS_OUTER_RADIUS=PCB_SCREW_INSET;
HEADPHONE_JACK_RADIUS=3.175 / 2;
LED_RADIUS=2.5; // 5mm

module shell(width, height, depth, radius) {
    hull() {
        chamfer = radius / 4;

        x1 = radius;
        y1 = radius;
        x2 = width - radius;
        y2 = height - radius;

        translate([x1, y1, 0]) cylinder(r=radius, h=depth - chamfer);
        translate([x2, y1, 0]) cylinder(r=radius, h=depth - chamfer);
        translate([x1, y2, 0]) cylinder(r=radius, h=depth - chamfer);
        translate([x2, y2, 0]) cylinder(r=radius, h=depth - chamfer);

        translate([x1, y1, 0]) cylinder(r=radius - chamfer, h=depth);
        translate([x2, y1, 0]) cylinder(r=radius - chamfer, h=depth);
        translate([x1, y2, 0]) cylinder(r=radius - chamfer, h=depth);
        translate([x2, y2, 0]) cylinder(r=radius - chamfer, h=depth);
    }
}

// Radius on all vertical surfaces, but not on top and bottom
module rounded_rect(width, height, depth, radius) {
    hull() {
        translate([radius, radius, 0]) cylinder(r=radius, h=depth);
        translate([width - radius, radius, 0]) cylinder(r=radius, h=depth);
        translate([width - radius, height - radius, 0]) cylinder(r=radius, h=depth);
        translate([radius, height - radius, 0]) cylinder(r=radius, h=depth);
    }
}

module rounded_cylinder(height, radius) {
    translate([radius, radius, 0]) cylinder(h=height - radius, r=radius);
    translate([radius, radius, height - radius]) sphere(radius);
}

module bottom_shell() {
    INSET = WALL / 2;

    difference() {
        union() {
            // Outer shell
            translate([0, 0, 0]) shell(SHELL_WIDTH, SHELL_HEIGHT, BOTTOM_SHELL_DEPTH, EDGE_RADIUS);

            // Plug holder
            rotate([90, 0, 0]) translate([PLUG_OFFSET, BOTTOM_SHELL_DEPTH - PLUG_LARGE_RADIUS, -SHELL_HEIGHT - 12]) {
                rounded_cylinder(PLUG_CYLINDER_LEN, PLUG_LARGE_RADIUS);
            }
        }

        union() {
            translate([0, 0, -20]) cube([SHELL_WIDTH, SHELL_HEIGHT, 20]);
            translate([WALL, WALL, -WALL]) shell(SHELL_WIDTH - WALL * 2, SHELL_HEIGHT - WALL * 2,
                BOTTOM_SHELL_DEPTH, EDGE_RADIUS - WALL);

            // lip
            translate([INSET - RELIEF / 2, INSET - RELIEF / 2, -EPSILON])
                rounded_rect(SHELL_WIDTH - (INSET - RELIEF / 2) * 2, SHELL_HEIGHT - (INSET - RELIEF / 2) * 2,
                    LIP_HEIGHT, EDGE_RADIUS - (WALL - INSET - RELIEF));

            // Inside of plug holder
            rotate([90, 0, 0]) translate([PLUG_OFFSET, BOTTOM_SHELL_DEPTH - PLUG_LARGE_RADIUS, -SHELL_HEIGHT - 12 + WALL]) {
                translate([WALL, WALL, -EPSILON]) rounded_cylinder(PLUG_CYLINDER_LEN - WALL * 2 + EPSILON, PLUG_LARGE_RADIUS - WALL);
                translate([PLUG_LARGE_RADIUS, PLUG_LARGE_RADIUS, -3]) cylinder(d=PLUG_OPENING_ID, h=6); // Opening
            }
        }
    }

}

module top_shell() {
    INSET = WALL / 2;

    difference() {
        union() {
            difference() {
                shell(SHELL_WIDTH, SHELL_HEIGHT, TOP_SHELL_DEPTH, EDGE_RADIUS);
                translate([-EPSILON, -EPSILON, -10]) cube([SHELL_WIDTH + EPSILON * 2, SHELL_HEIGHT + EPSILON * 2,
                    10 + LIP_HEIGHT]);
            }

            // Lip
            translate([WALL - INSET, WALL - INSET, -EPSILON]) rounded_rect(SHELL_WIDTH - (WALL - INSET) * 2,
                SHELL_HEIGHT - (WALL - INSET) * 2, INSET * 2, EDGE_RADIUS - (WALL - INSET));
        }

        // Cavity
        union() {
            // Cavity
            translate([WALL, WALL, -WALL]) shell(SHELL_WIDTH - WALL * 2, SHELL_HEIGHT - WALL * 2,
                TOP_SHELL_DEPTH, EDGE_RADIUS - WALL);

            // Label Inset
            difference() {
                translate([EDGE_RADIUS / 4 + 0.5, EDGE_RADIUS / 4 + 0.5, TOP_SHELL_DEPTH - 0.4])
                    rounded_rect(SHELL_WIDTH - (EDGE_RADIUS / 2 + 1), SHELL_HEIGHT - (EDGE_RADIUS / 2 + 1), 1, EDGE_RADIUS - 2);
                echo("Label size", SHELL_WIDTH - (EDGE_RADIUS / 2 + 1), SHELL_HEIGHT - (EDGE_RADIUS / 2 + 1));
                // Front buttons
                hull() {
                    translate([33 + 2.5, 8.5, TOP_SHELL_DEPTH - 1]) cylinder(d=9, h=1);
                    translate([60 + 2.5, 8.5, TOP_SHELL_DEPTH - 1]) cylinder(d=9, h=1);
                }

                echo("button1 cx from label edge", 33 + 2.5 - (EDGE_RADIUS / 4 + 0.5));
            }
        }
    }
}

module make_side_hole(diameter, isbottom) {
    cylinder(d=diameter, h=4);
    if (isbottom)
        translate([-diameter / 2, 0, 0]) cube([diameter, diameter + 1, 4]);
    else
        translate([-diameter / 2, -diameter, 0]) cube([diameter, diameter, 4]);
}


// This is from the origin of the top surface of the PCB, with positive
// extending away from the bottom.
// The isbottom flag cuts the lip away in the correct direction.
module openings(isbottom) {
    // USB port. This extends 3.2mm from the PCB surface it is soldered to and is
    // about 9.18mm wide.
    usb_port_width = 10;
    usb_port_height = 4;
    translate([PCB_WIDTH - 1, (PCB_HEIGHT - usb_port_width) / 2, 0]) {
        cube([4, usb_port_width, usb_port_height + PCB_THICKNESS]);
    }

    // Charging LED
    translate([PCB_WIDTH - 1, 24.19, PCB_THICKNESS + led_od / 2 + 0.5]) rotate([90, 180, 90])
        make_side_hole(led_od, isbottom);

    // Power LED
    led_od = 3.1;
    translate([73.56836, -3, PCB_THICKNESS + led_od / 2 + 0.5]) rotate([-90, 0, 0]) make_side_hole(led_od,  isbottom);

    // Power switch
    // Center x is 70mm from origin
    // 2mm travel, switch is 1.5mm wide.
    translate([65 - 3, -3, 0]) cube([6, 5, 4 + PCB_THICKNESS]);

    // Audio jack
    jack_id = 4;
    translate([15, -3, PCB_THICKNESS + 1.85]) rotate([-90, 0, 0]) make_side_hole(jack_id, isbottom);

    // Front buttons
    for (i = [0:3])
        translate([33 + i * 9, 24, 0]) rotate([0, -180, 0]) cylinder(d=7 + RELIEF, h=7);
}

module bottom_enclosure() {
    boss_length = TOP_SHELL_DEPTH + BOTTOM_SHELL_DEPTH - PCB_OFFSET - WALL * 2 - PCB_THICKNESS - RELIEF;
    boss_bottom = TOP_SHELL_DEPTH - WALL - boss_length;
    xy1 = PCB_SCREW_INSET + WALL + RELIEF;
    x2 = xy1 + PCB_WIDTH - PCB_SCREW_INSET * 2;
    y2 = xy1 + PCB_HEIGHT - PCB_SCREW_INSET * 2;

    difference() {
        union() {
            bottom_shell();

            translate([xy1, xy1, boss_bottom - WALL + EPSILON]) cylinder(r=BOSS_OUTER_RADIUS, h=BOTTOM_SHELL_DEPTH - boss_bottom);
            translate([x2, xy1, boss_bottom - WALL + EPSILON]) cylinder(r=BOSS_OUTER_RADIUS, h=BOTTOM_SHELL_DEPTH - boss_bottom);
            translate([xy1, y2, boss_bottom - WALL + EPSILON]) cylinder(r=BOSS_OUTER_RADIUS, h=BOTTOM_SHELL_DEPTH - boss_bottom);
            translate([x2, y2, boss_bottom - WALL + EPSILON]) cylinder(r=BOSS_OUTER_RADIUS, h=BOTTOM_SHELL_DEPTH - boss_bottom);
        }

        union() {
            // Screw holes to attach to top.
            translate([xy1, xy1, boss_bottom - WALL * 2]) cylinder(d=BOSS2_ID, h=boss_length);
            translate([x2, xy1, boss_bottom - WALL * 2]) cylinder(d=BOSS2_ID, h=boss_length);
            translate([xy1, y2, boss_bottom - WALL * 2]) cylinder(d=BOSS2_ID, h=boss_length);
            translate([x2, y2, boss_bottom - WALL * 2]) cylinder(d=BOSS2_ID, h=boss_length);
            translate([WALL + RELIEF, WALL + RELIEF, boss_bottom]) openings(true);
        }
    }
}

module top_enclosure() {
    pcb_boss_bottom=TOP_SHELL_DEPTH - WALL - PCB_OFFSET;

    xy1 = PCB_SCREW_INSET + WALL + RELIEF;
    x2 = xy1 + PCB_WIDTH - PCB_SCREW_INSET * 2;
    y2 = xy1 + PCB_HEIGHT - PCB_SCREW_INSET * 2;

    difference() {
        union() {
            top_shell();

            // Bosses to attach to bottom
            translate([xy1, xy1, pcb_boss_bottom]) cylinder(r=BOSS_OUTER_RADIUS, h=PCB_OFFSET + EPSILON);
            translate([x2, xy1, pcb_boss_bottom]) cylinder(r=BOSS_OUTER_RADIUS, h=PCB_OFFSET + EPSILON);
            translate([xy1, y2, pcb_boss_bottom]) cylinder(r=BOSS_OUTER_RADIUS, h=PCB_OFFSET + EPSILON);
            translate([x2, y2, pcb_boss_bottom]) cylinder(r=BOSS_OUTER_RADIUS, h=PCB_OFFSET + EPSILON);
        }

        union() {
            // Screw holes
            translate([xy1, xy1, 0]) cylinder(d=BOSS1_ID, h=TOP_SHELL_DEPTH + EPSILON);
            translate([x2, xy1, 0]) cylinder(d=BOSS1_ID, h=TOP_SHELL_DEPTH + EPSILON);
            translate([xy1, y2, 0]) cylinder(d=BOSS1_ID, h=TOP_SHELL_DEPTH + EPSILON);
            translate([x2, y2, 0]) cylinder(d=BOSS1_ID, h=TOP_SHELL_DEPTH + EPSILON);

            // Counterbore screw heads
            translate([0, 0, pcb_boss_bottom + WALL]) {
                translate([xy1, xy1, 0]) cylinder(d=COUNTERBORE_ID, h=20);
                translate([x2, xy1, 0]) cylinder(d=COUNTERBORE_ID, h=20);
                translate([xy1, y2, 0]) cylinder(d=COUNTERBORE_ID, h=20);
                translate([x2, y2, 0]) cylinder(d=COUNTERBORE_ID, h=20);
            }

            translate([WALL + RELIEF, WALL + RELIEF, pcb_boss_bottom]) rotate([180, 0, 0]) translate([0, -PCB_HEIGHT, 0]) openings(false);
        }
    }
}

module button() {
    top_radius = 8;
    button_height = 7.5;
    od = 7;
    support_width = 0.8;
    flange_rod = 1.5;
    flange_thickness = 4;

    difference() {
        union() {
            cylinder(h=flange_thickness, d=od + flange_rod);  // Bottom flange
            intersection() {
                // Main button and rounded top
                cylinder(h=button_height * 2, d=od);
                translate([0, 0, -top_radius + button_height]) sphere(r=top_radius);
            }
        }

        // Hollow out middle
        union() translate([0, 0, -EPSILON]) {
            cylinder(h=button_height - flange_rod, d=od - 1);
            cylinder(h=flange_thickness - 1, d=od + flange_rod - 1);
        }
    }

    // Add cross supports
    support_length1 = od - 0.5;
    translate([-support_length1 / 2, -support_width / 2, 0]) cube([support_length1, support_width, button_height - 1]);
    translate([-support_width / 2, -support_length1 / 2, 0]) cube([support_width, support_length1, button_height - 1]);

    support_length2 = od + flange_rod - 0.5;
    translate([-support_length2 / 2, -support_width / 2, 0]) cube([support_length2, support_width, flange_thickness - 0.1]);
    translate([-support_width / 2, -support_length2 / 2, 0]) cube([support_width, support_length2, flange_thickness - 0.1]);
}

// This is a stand-in for the PCB, useful during design to check fit.
module pcb() {
    x2 = PCB_WIDTH - PCB_SCREW_INSET;
    y2 = PCB_HEIGHT - PCB_SCREW_INSET;
    difference() {
        union() {
            color("purple") hull() {
                translate([PCB_SCREW_INSET, PCB_SCREW_INSET, 0]) cylinder(r=PCB_SCREW_INSET, h=PCB_THICKNESS);
                translate([x2, PCB_SCREW_INSET, 0]) cylinder(r=PCB_SCREW_INSET, h=PCB_THICKNESS);
                translate([PCB_SCREW_INSET, y2, 0]) cylinder(r=PCB_SCREW_INSET, h=PCB_THICKNESS);
                translate([x2, y2, 0]) cylinder(r=PCB_SCREW_INSET, h=PCB_THICKNESS);
            }
        }

        union() {
            translate([PCB_SCREW_INSET, PCB_SCREW_INSET, -0.1]) cylinder(h=10, d=2.2);
            translate([x2, PCB_SCREW_INSET, -0.1]) cylinder(h=10, d=2.2);
            translate([PCB_SCREW_INSET, y2, -0.1]) cylinder(h=10, d=2.2);
            translate([x2, y2, -0.1]) cylinder(h=10, d=2.2);
        }
    }
}

// This is a stand-in for the battery, useful during design to check fit.
module battery() {
    color([0, 1, 0]) cube([36, 20, 5.6]);
}

// Stand in for 1/4" plug
module plug() {
    color("gray") {
        // Total length is 48.815625, 1 59/64"
        translate([-1.5, -3, 0]) cube([3, 1, 11]);
        translate([-1.5, 2, 0]) cube([3, 1, 11]);

        translate([0, 0, 11]) cylinder(h=6, d=10);
        translate([0, 0, 17.25]) cylinder(d1=11.8872, d2=10, h=1);
        translate([0, 0, 18.25]) cylinder(h=25, d=6.324);
        translate([0, 0, 43.25]) cylinder(h=5.55, d1=6.324, d2=1);
    }
}

// The orients all of the pieces how they would be assembled. It is useful during
// design to check fit.
module assembled(alpha) {
    pcb_xy = WALL + RELIEF;
    pcb_z = TOP_SHELL_DEPTH - WALL - PCB_THICKNESS - PCB_OFFSET;
    translate([WALL + RELIEF, WALL + RELIEF, pcb_z]) pcb();
    translate([30, 5, pcb_z - 0.5 - 5.6]) battery();
    rotate([90, 0, 0]) translate([16, -6, -5]) plug();

    // Front buttons
    for (i = [0:3])
        translate([pcb_xy + 33 + i * 9, SHELL_HEIGHT - pcb_xy - 24, pcb_z + PCB_THICKNESS + 0.5]) button();

    color("yellow", alpha) {
        top_enclosure();
        rotate([180,0,0]) translate([0, -SHELL_HEIGHT, -WALL * 1.5]) bottom_enclosure();
    }
}

// Orient pieces as assembled, but cut a box out of the corner to allow the insides to be
// visible. It is useful during design to check fit, alignment, and size.
module cutaway() {
    difference() {
        assembled(1);
        translate([15,-27,-7]) cube([SHELL_WIDTH,SHELL_HEIGHT,50]);
    }
}

//assembled(0.7);
cutaway();
