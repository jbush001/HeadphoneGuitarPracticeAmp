//
// Print Settings (tested with Cura Slicer, Creality Ender 3)
//   Infill Density: 20%
//   Support Placement: Everywhere
//   Support Density: 20%
//   Layer Height: 0.2mm
// Both shells are printed with the open side pointed towards the print bed.
//

epsilon = 0.001; // Small offset used to avoid z-fighting
relief = 0.5; // Gap between interfacing parts to avoid sticking. Specific to printing process.
wall = 2; // Thickness of walls
pcb_thickness = 1.5; // Oshpark 4 layer board (actually 1.46)
$fs = 0.5;
$fa = 0.5;

pcb_xy_gap = 0.8; // horizontal gap between PCB and inside enclosure wall, on all sides.
enclosure_radius = 2.5 + wall + pcb_xy_gap;
pcb_width = 80;
pcb_height = 30;
pcb_screw_inset = 2.5; // center of screw from edge of PCB
pcb_z_offset = 3 + wall; // From top surface
lip_height = 1.8;
plug_cylinder_or = 16 / 2;
plug_cylinder_len = 37;
plug_opening_id = 10;
plug_x_offset = 8;
boss_od = pcb_screw_inset * 2;
top_boss_id = 2.5;   // For an M2.3 screw, should be larger
bottom_boss_id = 2.2;   // Also for M2.3 screw, we want it to self thread into this.
counterbore_id = 4.0; // Head of screw is 3.56mm
top_shell_depth = 9;
bottom_shell_depth = 9;
shell_width = pcb_width + pcb_xy_gap * 2 + wall * 2;
shell_height = pcb_height + pcb_xy_gap * 2 + wall * 2;
headphone_jack_radius = 3.175 / 2;
led_radius = 2.5; // 5mm

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

// Radius all vertical surfaces, but not top and bottom
module rounded_rect(width, height, depth, radius) {
    hull() {
        translate([radius, radius, 0]) cylinder(r=radius, h=depth);
        translate([width - radius, radius, 0]) cylinder(r=radius, h=depth);
        translate([width - radius, height - radius, 0]) cylinder(r=radius, h=depth);
        translate([radius, height - radius, 0]) cylinder(r=radius, h=depth);
    }
}

// Cylinder with a ball end
module rounded_cylinder(height, radius) {
    translate([radius, radius, 0]) cylinder(h=height - radius, r=radius);
    translate([radius, radius, height - radius]) sphere(radius);
}

module bottom_shell() {
    difference() {
        union() {
            // Outer shell
            translate([0, 0, 0]) shell(shell_width, shell_height, bottom_shell_depth, enclosure_radius);

            // Plug holder
            rotate([90, 0, 0]) translate([plug_x_offset, bottom_shell_depth - plug_cylinder_or, -shell_height - 12]) {
                rounded_cylinder(plug_cylinder_len, plug_cylinder_or);
            }
        }

        union() {
            translate([0, 0, -20]) cube([shell_width, shell_height, 20]);
            translate([wall, wall, -wall]) shell(shell_width - wall * 2, shell_height - wall * 2,
                bottom_shell_depth, enclosure_radius - wall);

            // lip (outer)
            translate([wall / 2 - relief / 2, wall / 2 - relief / 2, -epsilon])
                rounded_rect(shell_width - (wall / 2) * 2 - relief, shell_height - (wall / 2 / 2) * 2 - relief,
                    lip_height, enclosure_radius - (wall - wall / 2 - relief));

            // Inside of plug holder
            rotate([90, 0, 0]) translate([plug_x_offset, bottom_shell_depth - plug_cylinder_or, -shell_height - 12 + wall]) {
                translate([wall, wall, -epsilon]) rounded_cylinder(plug_cylinder_len - wall * 2 + epsilon, plug_cylinder_or - wall);
                translate([plug_cylinder_or, plug_cylinder_or, -3]) cylinder(d=plug_opening_id, h=6); // Opening
            }
        }
    }

}

module top_shell() {
    INSET = wall / 2;

    difference() {
        union() {
            difference() {
                shell(shell_width, shell_height, top_shell_depth, enclosure_radius);
                translate([-epsilon, -epsilon, -10]) cube([shell_width + epsilon * 2, shell_height + epsilon * 2,
                    10 + lip_height - relief]);
            }

            // Lip (inner)
            translate([wall / 2 + relief / 2, INSET + relief / 2, -epsilon]) rounded_rect(
                shell_width - wall - relief,
                shell_height - wall - relief,
                INSET * 2, enclosure_radius - (wall - INSET));
        }

        // Cavity
        translate([wall, wall, -wall]) shell(shell_width - wall * 2, shell_height - wall * 2,
            top_shell_depth, enclosure_radius - wall);
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
    translate([pcb_width - 1, (pcb_height - usb_port_width) / 2, 0])
        cube([4, usb_port_width, usb_port_height + pcb_thickness]);

    // Charging LED
    translate([pcb_width - 1, 24.19, pcb_thickness + led_od / 2 + 0.5]) rotate([90, 180, 90])
        make_side_hole(led_od, isbottom);

    // Power LED
    led_od = 3.1;
    translate([73.56836, -3, pcb_thickness + led_od / 2 + 0.5]) rotate([-90, 0, 0]) make_side_hole(led_od,  isbottom);

    // Power switch
    // Center x is 70mm from origin
    // 2mm travel, switch is 1.5mm wide.
    translate([65 - 3, -3, 0]) cube([6, 5, 4 + pcb_thickness]);

    // Audio jack
    jack_id = 4;
    translate([15, -3, pcb_thickness + 1.85]) rotate([-90, 0, 0]) make_side_hole(jack_id, isbottom);

    // Front buttons
    for (i = [0:3])
        translate([33 + i * 9, 24, 0]) rotate([0, -180, 0]) cylinder(d=7 + relief * 2, h=7);
}

module bottom_enclosure() {
    boss_length = top_shell_depth + bottom_shell_depth - pcb_z_offset - pcb_thickness - relief; // offset from bottom surface
    boss_top = bottom_shell_depth - boss_length;
    xy1 = pcb_screw_inset + wall + pcb_xy_gap;
    x2 = xy1 + pcb_width - pcb_screw_inset * 2;
    y2 = xy1 + pcb_height - pcb_screw_inset * 2;

    difference() {
        union() {
            bottom_shell();

            translate([xy1, xy1, boss_top]) cylinder(d1=boss_od, d2=boss_od + 1, h=boss_length);
            translate([x2, xy1, boss_top]) cylinder(d1=boss_od, d2=boss_od + 1, h=boss_length);
            translate([xy1, y2, boss_top]) cylinder(d1=boss_od, d2=boss_od + 1, h=boss_length);
            translate([x2, y2, boss_top]) cylinder(d1=boss_od, d2=boss_od + 1, h=boss_length);
        }

        union() {
            // Screw holes to attach to top.
            translate([xy1, xy1, boss_top - epsilon]) cylinder(d=bottom_boss_id, h=boss_length - wall);
            translate([x2, xy1, boss_top - epsilon]) cylinder(d=bottom_boss_id, h=boss_length - wall);
            translate([xy1, y2, boss_top - epsilon]) cylinder(d=bottom_boss_id, h=boss_length - wall);
            translate([x2, y2, boss_top - epsilon]) cylinder(d=bottom_boss_id, h=boss_length - wall);
            translate([wall + pcb_xy_gap, wall + pcb_xy_gap, boss_top]) openings(true);
        }
    }
}

module top_enclosure() {
    pcb_boss_bottom = top_shell_depth - pcb_z_offset;

    xy1 = pcb_screw_inset + wall + pcb_xy_gap;
    x2 = xy1 + pcb_width - pcb_screw_inset * 2;
    y2 = xy1 + pcb_height - pcb_screw_inset * 2;

    difference() {
        union() {
            top_shell();

            // Bosses to attach to bottom
            translate([xy1, xy1, pcb_boss_bottom]) cylinder(d1=boss_od, d2=boss_od + 1, h=pcb_z_offset);
            translate([x2, xy1, pcb_boss_bottom]) cylinder(d1=boss_od, d2=boss_od + 1, h=pcb_z_offset);
            translate([xy1, y2, pcb_boss_bottom]) cylinder(d1=boss_od, d2=boss_od + 1, h=pcb_z_offset);
            translate([x2, y2, pcb_boss_bottom]) cylinder(d1=boss_od, d2=boss_od + 1, h=pcb_z_offset);
        }

        union() {
            // Screw holes
            translate([xy1, xy1, 0]) cylinder(d=top_boss_id, h=top_shell_depth + epsilon);
            translate([x2, xy1, 0]) cylinder(d=top_boss_id, h=top_shell_depth + epsilon);
            translate([xy1, y2, 0]) cylinder(d=top_boss_id, h=top_shell_depth + epsilon);
            translate([x2, y2, 0]) cylinder(d=top_boss_id, h=top_shell_depth + epsilon);

            // Counterbore screw heads
            translate([0, 0, pcb_boss_bottom + wall]) {
                translate([xy1, xy1, 0]) cylinder(d=counterbore_id, h=20);
                translate([x2, xy1, 0]) cylinder(d=counterbore_id, h=20);
                translate([xy1, y2, 0]) cylinder(d=counterbore_id, h=20);
                translate([x2, y2, 0]) cylinder(d=counterbore_id, h=20);
            }

            // Openings for various connectors
            translate([wall + pcb_xy_gap, wall + pcb_xy_gap, pcb_boss_bottom]) rotate([180, 0, 0])
                translate([0, -pcb_height, 0]) openings(false);

            // Label Inset
            difference() {
                translate([enclosure_radius / 4 + 0.5, enclosure_radius / 4 + 0.5, top_shell_depth - 0.4])
                    rounded_rect(shell_width - (enclosure_radius / 2 + 1), shell_height - (enclosure_radius / 2 + 1), 1, enclosure_radius - 2);
                echo("Enclosure size", shell_width, shell_height);
                echo("Label size", shell_width - (enclosure_radius / 2 + 1), shell_height - (enclosure_radius / 2 + 1));
                echo("Label inset", enclosure_radius / 4 + 0.5);
                // Front button area
                hull() {
                    translate([33 + pcb_xy_gap + wall, pcb_xy_gap + wall + 6, top_shell_depth - 1]) cylinder(d=9, h=1);
                    translate([60 + pcb_xy_gap + wall, pcb_xy_gap + wall + 6, top_shell_depth - 1]) cylinder(d=9, h=1);
                }

                echo("button1 cx from label edge", 33 + 2.5 - (enclosure_radius / 4 + 0.5));
            }
        }
    }
}

module button() {
    top_radius = 8;
    button_height = 6.5;
    od = 7;
    support_width = 0.8;
    flange_odr = 1.5;
    flange_thickness = 1.5;

    difference() {
        union() {
            cylinder(h=flange_thickness, d=od + flange_odr);  // Bottom flange
            intersection() {
                // Main button and rounded top
                cylinder(h=button_height * 2, d=od);
                translate([0, 0, -top_radius + button_height]) sphere(r=top_radius);
            }
        }

        // Hollow out middle
        union() translate([0, 0, -epsilon * 2]) {
            cylinder(h=button_height - flange_odr, d=od - 1);
        }
    }

    // Add cross supports
    support_length1 = od - 0.5;
    translate([-support_length1 / 2, -support_width / 2, 0]) cube([support_length1, support_width, button_height - 1]);
    translate([-support_width / 2, -support_length1 / 2, 0]) cube([support_width, support_length1, button_height - 1]);

    // Bottom sticks out to press dome switch
    translate([0, 0, -0.5]) cylinder(h=button_height, d=2);  // Bottom flange
}

// Stand-in for the PCB.
module pcb() {
    x2 = pcb_width - pcb_screw_inset;
    y2 = pcb_height - pcb_screw_inset;
    difference() {
        union() {
            color("purple") hull() {
                translate([pcb_screw_inset, pcb_screw_inset, 0]) cylinder(r=pcb_screw_inset, h=pcb_thickness);
                translate([x2, pcb_screw_inset, 0]) cylinder(r=pcb_screw_inset, h=pcb_thickness);
                translate([pcb_screw_inset, y2, 0]) cylinder(r=pcb_screw_inset, h=pcb_thickness);
                translate([x2, y2, 0]) cylinder(r=pcb_screw_inset, h=pcb_thickness);
            }
        }

        union() {
            translate([pcb_screw_inset, pcb_screw_inset, -0.1]) cylinder(h=10, d=2.2);
            translate([x2, pcb_screw_inset, -0.1]) cylinder(h=10, d=2.2);
            translate([pcb_screw_inset, y2, -0.1]) cylinder(h=10, d=2.2);
            translate([x2, y2, -0.1]) cylinder(h=10, d=2.2);
        }
    }
}

// Stand-in for the battery.
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

// The orients all of the pieces how they would be assembled to check fit.
module assembled(alpha) {
    pcb_xy = wall + pcb_xy_gap;
    pcb_z = top_shell_depth - pcb_z_offset - pcb_thickness;
    translate([pcb_xy, pcb_xy, pcb_z]) pcb();
    translate([30, 5, pcb_z - 0.5 - 5.6]) battery();
    rotate([90, 0, 0]) translate([16, -7.5, -5]) plug();

    // Front buttons
    for (i = [0:3])
        translate([pcb_xy + 33 + i * 9, shell_height - pcb_xy - 24.8 + relief, pcb_z + pcb_thickness + 1.5]) button();

    color("yellow", alpha) {
        top_enclosure();
        rotate([180, 0, 0]) translate([0, -shell_height, -lip_height + relief]) bottom_enclosure();
    }
}

// Cut a chunk of the assembly away to see stack-up.
module cutaway() {
    difference() {
        assembled(1);
        translate([15, -11, -8]) cube([shell_width, 17, 50]);
    }
}

//assembled(1);
cutaway();
