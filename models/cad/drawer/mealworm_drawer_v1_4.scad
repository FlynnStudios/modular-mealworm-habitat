// Mealworm modular drawer v1.4 — units: mm.
// Target: PETG, 0.4 mm nozzle, 0.20–0.28 mm layer height.
// Export with -D 'part="drawer"|"vent_standard"|"vent_labyrinth"'.
//
// v1.4 corrections after visual review of v1.3:
// - The 70 mm pull becomes a true bridge handle. Fingers enter from below and
//   curl behind a separate chamfered grip bar with 15 mm wall clearance.
// - Two end struts plus one narrow center strut divide the printable bridges.
// - The vent receiver becomes a single tapered U-shaped bezel. Precise capture
//   faces remain, but all exposed shoulders blend back into the drawer wall.
// - The raised inner rim remains 2.2 mm thick and 3.0 mm high; smallest-larva
//   containment has not been tested.
// - The 66 x 4 x 18 mm cartridge envelope and nominal 0.60 mm slots remain.

$fn = 36;
part = "drawer";

// Frozen drawer envelope.
W = 180;
D = 140;
H = 48;
wall = 1.6;
floor_t = 2.4;

// Reinforced raised inner rim.
rim_h = 3.0;
body_h = H-rim_h;
lip_t = 2.2;

// Vent cartridge interface.
vent_open_w = 62;
vent_open_h = 14;
vent_open_z = 26;
module_w = 66;
module_h = 18;
module_z = 24;
module_flange_t = 1.2;
module_depth = 4.0;
slot_w = 0.60;
rib_w = 0.80;

// 70 mm wide bridge handle with a real finger-under clearance.
handle_x0 = 55;
handle_x1 = 125;
handle_bar_front = -20;
handle_bar_rear = -15;
handle_bar_z0 = 18;
handle_bar_z1 = 25;

module grip_bar() {
    // Chamfered 5 x 9 mm grip section. The flat-to-flat dimensions remain
    // comfortable to hook while avoiding a sharp rectangular lower edge.
    polyhedron(
        points=[
            [handle_x0,-19.0,18.0],
            [handle_x0,-16.0,18.0],
            [handle_x0,-15.0,19.2],
            [handle_x0,-15.0,23.2],
            [handle_x0,-16.5,25.0],
            [handle_x0,-19.0,25.0],
            [handle_x0,-20.0,23.6],
            [handle_x0,-20.0,19.4],

            [handle_x1,-19.0,18.0],
            [handle_x1,-16.0,18.0],
            [handle_x1,-15.0,19.2],
            [handle_x1,-15.0,23.2],
            [handle_x1,-16.5,25.0],
            [handle_x1,-19.0,25.0],
            [handle_x1,-20.0,23.6],
            [handle_x1,-20.0,19.4]
        ],
        faces=[
            [7,6,5,4,3,2,1,0],
            [8,9,10,11,12,13,14,15],
            [0,1,9,8],
            [1,2,10,9],
            [2,3,11,10],
            [3,4,12,11],
            [4,5,13,12],
            [5,6,14,13],
            [6,7,15,14],
            [7,0,8,15]
        ], convexity=6
    );
}

module handle_strut(x0,w) {
    // A narrow bed-contacting fin runs from the drawer wall to the grip. The
    // handle therefore does not begin in mid-air even with 15 mm finger space.
    hull() {
        translate([x0,-0.20,0])
            cube([w,0.40,26]);
        translate([x0,handle_bar_front,0])
            cube([w,-handle_bar_front,0.80]);
        translate([x0,handle_bar_front,handle_bar_z0])
            cube([w,handle_bar_rear-handle_bar_front,
                  handle_bar_z1-handle_bar_z0]);
    }
}

module pull_handle() {
    union() {
        grip_bar();
        handle_strut(handle_x0,7);
        handle_strut(88.5,3);
        handle_strut(handle_x1-7,7);
    }
}

// Reinforced receiver geometry.
rail_side_clearance = 0.35;
rail_h = body_h-module_z;
capture_x = 1.20;
retaining_lip_y = 1.20;
flange_channel_clearance = 0.35;
bottom_stop_h = 1.60;
rail_blend_x = 4.20;

module tapered_rail_profile(left_inner,guide_y0,channel_back_y,rail_outer_y) {
    // One continuous printable profile replaces separate guide and lip blocks.
    // The inner faces preserve cartridge clearance; the outer faces form a
    // broad, sloped shoulder that grows naturally from the drawer wall.
    translate([0,0,module_z])
        linear_extrude(height=rail_h)
            polygon(points=[
                [left_inner-rail_blend_x, guide_y0],
                [left_inner-0.70, guide_y0],
                [left_inner, guide_y0+0.50],
                [left_inner, channel_back_y],
                [left_inner+capture_x, channel_back_y],
                [left_inner+capture_x, rail_outer_y-0.30],
                [left_inner+capture_x-0.30, rail_outer_y],
                [left_inner-2.20, rail_outer_y],
                [left_inner-3.20, rail_outer_y-0.80]
            ]);
}

module cartridge_rails_front() {
    x0=(W-module_w)/2;
    left_inner=x0-rail_side_clearance;
    channel_back_y=wall+module_flange_t+flange_channel_clearance;
    rail_outer_y=channel_back_y+retaining_lip_y;
    guide_y0=wall-0.2;
    left_outer=left_inner-rail_blend_x;
    right_outer=W-left_outer;
    bezel_w=right_outer-left_outer;

    union() {
        // Identical tapered side profiles, mirrored about the drawer center.
        tapered_rail_profile(left_inner,guide_y0,channel_back_y,rail_outer_y);
        translate([W,0,0]) mirror([1,0,0])
            tapered_rail_profile(left_inner,guide_y0,channel_back_y,rail_outer_y);

        // One tapered lower sill replaces the former rectangular stop plus
        // separate gusset. Its horizontal top locates the cartridge, while
        // the exposed underside blends continuously back into the wall.
        hull() {
            translate([left_outer,guide_y0,module_z-bottom_stop_h-1.60])
                cube([bezel_w,0.22,bottom_stop_h+1.60]);
            translate([left_outer,channel_back_y-0.50,
                       module_z-bottom_stop_h])
                cube([bezel_w,0.50,bottom_stop_h]);
        }
    }
}

module drawer_shell() {
    union() {
        difference() {
            union() {
                difference() {
                    cube([W,D,body_h]);
                    translate([wall,wall,floor_t])
                        cube([W-2*wall,D-2*wall,body_h-floor_t+0.1]);
                }

                // Reinforced raised inner lip: 2.2 mm thick x 3.0 mm high.
                translate([wall,wall,body_h-0.1])
                    difference() {
                        cube([W-2*wall,D-2*wall,rim_h+0.1]);
                        translate([lip_t,lip_t,-0.05])
                            cube([W-2*(wall+lip_t),D-2*(wall+lip_t),rim_h+0.2]);
                    }

                pull_handle();
            }

            // Standardized front and rear cartridge apertures.
            translate([(W-vent_open_w)/2,-0.05,vent_open_z])
                cube([vent_open_w,wall+0.1,vent_open_h]);
            translate([(W-vent_open_w)/2,D-wall-0.05,vent_open_z])
                cube([vent_open_w,wall+0.1,vent_open_h]);

            // Open the reinforced top rim only over the two cartridge channels.
            // The surrounding rim remains a full 2.2 mm thick.
            translate([(W-module_w)/2-rail_side_clearance-0.25,
                       wall-0.3,body_h-0.2])
                cube([module_w+2*rail_side_clearance+0.5,
                      module_flange_t+flange_channel_clearance+
                      retaining_lip_y+0.6,
                      rim_h+0.4]);
            translate([(W-module_w)/2-rail_side_clearance-0.25,
                       D-wall-module_flange_t-flange_channel_clearance-
                       retaining_lip_y-0.3,
                       body_h-0.2])
                cube([module_w+2*rail_side_clearance+0.5,
                      module_flange_t+flange_channel_clearance+
                      retaining_lip_y+0.6,
                      rim_h+0.4]);
        }

        cartridge_rails_front();
        translate([0,D,0]) mirror([0,1,0]) cartridge_rails_front();
    }
}

module slotted_panel(y0, offset=0) {
    pitch=slot_w+rib_w;
    difference() {
        translate([0,y0,0]) cube([module_w,module_flange_t,module_h]);
        for(x=[2+offset:pitch:module_w-2-slot_w])
            translate([x,y0-0.05,2])
                cube([slot_w,module_flange_t+0.1,module_h-4]);
    }
}

module perimeter_spacer() {
    d=module_depth-module_flange_t+0.1;
    translate([2,module_flange_t-0.1,2]) cube([module_w-4,d,2]);
    translate([2,module_flange_t-0.1,module_h-4]) cube([module_w-4,d,2]);
    translate([2,module_flange_t-0.1,4]) cube([2,d,module_h-8]);
    translate([module_w-4,module_flange_t-0.1,4]) cube([2,d,module_h-8]);
}

module vent_standard() {
    union() {
        slotted_panel(0,0);
        perimeter_spacer();
    }
}

module vent_labyrinth() {
    union() {
        slotted_panel(0,0);
        perimeter_spacer();
        slotted_panel(module_depth-module_flange_t,(slot_w+rib_w)/2);
    }
}

module front_cartridge_assembled() {
    cartridge_y=wall+flange_channel_clearance/2;
    translate([(W-module_w)/2,cartridge_y,module_z]) vent_labyrinth();
}

module fit_check_front_cartridge() {
    intersection() {
        drawer_shell();
        front_cartridge_assembled();
    }
}

module assembly_preview() {
    color([0.68,0.38,0.16]) drawer_shell();
    color([0.00,0.42,0.46]) front_cartridge_assembled();
    color([0.00,0.42,0.46])
        translate([(W-module_w)/2,D-wall-flange_channel_clearance/2,module_z])
            mirror([0,1,0]) vent_labyrinth();
}

module handle_detail() {
    intersection() {
        drawer_shell();
        translate([45,handle_bar_front-0.5,0])
            cube([90,-handle_bar_front+5,31]);
    }
}

module rail_detail() {
    intersection() {
        drawer_shell();
        translate([50,0.30,20]) cube([80,7,28.5]);
    }
}

if (part=="drawer") drawer_shell();
else if (part=="vent_standard") vent_standard();
else if (part=="vent_labyrinth") vent_labyrinth();
else if (part=="fit_check_front_cartridge") fit_check_front_cartridge();
else if (part=="assembly_preview") assembly_preview();
else if (part=="handle_detail") handle_detail();
else if (part=="rail_detail") rail_detail();
else assert(false,"Unknown part");
