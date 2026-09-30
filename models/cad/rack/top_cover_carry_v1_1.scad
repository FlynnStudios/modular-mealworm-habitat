// Mealworm rack top cover with handle v1.1 — units: mm.
// Compatible with rack_flatpack_center_guide_r3_5.scad.
// Target: PETG, 0.4 mm nozzle, 0.20–0.24 mm layer height.
//
// Frozen interfaces reused without modifying the rack:
// - R3.5 rack envelope: 198 x 150 mm.
// - Four top tongues: 4.8 x 14.0 x 7.0 mm.
// - Tongue lock passages: 8.0 x 3.0 mm, center height 3.5 mm.
//
// Locating and retention features (loaded carrying is untested):
// - Four vertical sockets locate the cover.
// - Two diagonal sockets use 0.15 mm per-side clearance for light friction.
// - Two sockets use 0.30 mm per-side relief to prevent four-point binding.
// - Two identical removable side-lock rails positively engage all four tongue
//   passages. Carrying load does not rely on socket friction.
// - The continuous 1.2 mm skin closes the top drawer; raised ribs reinforce it.
//
// Export with part="cover" | "side_lock" | "print_plate" |
//                  "assembly_preview" | "fit_check".

use <rack_flatpack_center_guide_r3_5.scad>

$fn = 36;
part = "print_plate";

// Cover placement is shifted +10 X / +2 Y from the R3.5 rack coordinates.
cover_w = 202;
cover_d = 154;
base_t = 1.20;

// Existing rack top-tongue centers in the shifted cover coordinate system.
socket_x = [6,196];
socket_y = [13,141];
tongue_x = 4.80;
tongue_y = 14.00;
tongue_h = 7.00;

// Socket/collar structure.
collar_x = 12.0;
collar_y = 22.0;
collar_h = 8.0;
locator_clearance = 0.15;  // Per side, on two diagonal sockets.
relief_clearance = 0.30;   // Per side, on the other two sockets.
lead_in = 0.35;

// Positive side-lock interface.
lock_passage_y = 8.30;
lock_passage_z = 3.20;
lock_center_z = 3.50;
lock_pin_y = 7.70;
lock_pin_z = 2.70;
lock_pin_len = 14.20;
lock_tip_reduction = 0.30;

// Lightweight structural grid, revised for PETG HF.
perimeter_w = 8.0;
perimeter_total_h = 5.2;
joint_beam_w = 8.0;
joint_beam_total_h = 5.2;
center_beam_w = 12.0;
center_beam_total_h = 7.2;
long_rib_w = 6.0;
long_rib_total_h = 4.2;
long_rib_x = [48,154];

// Slim single-pocket PETG-HF handle with two end supports.
handle_x0 = 44;
handle_x1 = 158;
handle_y0 = 71;
handle_y1 = 83;
handle_bar_z0 = 25;
handle_bar_z1 = 32;
support_w = 8;
support_x = [44,150];
gusset_run = 21;
gusset_z0 = center_beam_total_h;

module perimeter_rib() {
    translate([0,0,base_t-0.01])
        difference() {
            cube([cover_w,cover_d,perimeter_total_h-base_t+0.01]);
            translate([perimeter_w,perimeter_w,-0.02])
                cube([cover_w-2*perimeter_w,
                      cover_d-2*perimeter_w,
                      perimeter_total_h-base_t+0.05]);
        }
}

module beam_x(yc,w,total_h) {
    translate([0,yc-w/2,base_t-0.01])
        cube([cover_w,w,total_h-base_t+0.01]);
}

module rib_y(xc,w,y0,y1,total_h) {
    translate([xc-w/2,y0,base_t-0.01])
        cube([w,y1-y0,total_h-base_t+0.01]);
}

module collar(cx,cy) {
    translate([cx-collar_x/2,cy-collar_y/2,0])
        cube([collar_x,collar_y,collar_h]);
}

module socket_cut(cx,cy,c) {
    sx = tongue_x+2*c;
    sy = tongue_y+2*c;

    // A wider bottom mouth removes first-layer and angular insertion risk.
    hull() {
        translate([cx-(sx+2*lead_in)/2,
                   cy-(sy+2*lead_in)/2,-0.05])
            cube([sx+2*lead_in,sy+2*lead_in,0.02]);
        translate([cx-sx/2,cy-sy/2,0.78])
            cube([sx,sy,0.02]);
    }
    translate([cx-sx/2,cy-sy/2,0.78])
        cube([sx,sy,collar_h-0.73]);
}

module collar_lock_passage(cx,cy) {
    translate([cx-collar_x/2-0.10,
               cy-lock_passage_y/2,
               lock_center_z-lock_passage_z/2])
        cube([collar_x+0.20,lock_passage_y,lock_passage_z]);
}

module grip_bar() {
    // Chamfered 114 x 12 x 7 mm grip; lighter while retaining a comfortable span.
    x0=handle_x0;
    x1=handle_x1;
    y0=handle_y0;
    y1=handle_y1;
    z0=handle_bar_z0;
    z1=handle_bar_z1;
    c=1.4;

    polyhedron(
        points=[
            [x0,y0+c,z0], [x0,y1-c,z0],
            [x0,y1,z0+c], [x0,y1,z1-c],
            [x0,y1-c,z1], [x0,y0+c,z1],
            [x0,y0,z1-c], [x0,y0,z0+c],

            [x1,y0+c,z0], [x1,y1-c,z0],
            [x1,y1,z0+c], [x1,y1,z1-c],
            [x1,y1-c,z1], [x1,y0+c,z1],
            [x1,y0,z1-c], [x1,y0,z0+c]
        ],
        faces=[
            [7,6,5,4,3,2,1,0],
            [8,9,10,11,12,13,14,15],
            [0,1,9,8], [1,2,10,9], [2,3,11,10],
            [3,4,12,11], [4,5,13,12], [5,6,14,13],
            [6,7,15,14], [7,0,8,15]
        ], convexity=6
    );
}

module handle_support(x0) {
    translate([x0,handle_y0,base_t-0.01])
        cube([support_w,handle_y1-handle_y0,
              handle_bar_z1-base_t+0.01]);
}

module gusset_from_edge(xe,dir) {
    // Printable inward shoulder; the two shoulders reduce the central bridge to about 56 mm.
    // The first two hull nodes overlap the support by 0.25 mm, avoiding a
    // coincident-edge-only union that some slicers report as non-manifold.
    xs=xe-dir*0.25;
    xt=xe+dir*gusset_run;
    node=0.30;

    hull() {
        translate([xs-node/2,handle_y0,gusset_z0-node/2])
            cube([node,handle_y1-handle_y0,node]);
        translate([xs-node/2,handle_y0,handle_bar_z0-node/2])
            cube([node,handle_y1-handle_y0,node]);
        translate([xt-node/2,handle_y0,handle_bar_z0-node/2])
            cube([node,handle_y1-handle_y0,node]);
    }
}

module carry_handle() {
    union() {
        grip_bar();
        for (x0=support_x) handle_support(x0);

        // One inward shoulder from each end support; no center post.
        gusset_from_edge(support_x[0]+support_w, 1);
        gusset_from_edge(support_x[1],-1);
    }
}

module cover_positive() {
    union() {
        cube([cover_w,cover_d,base_t]);
        perimeter_rib();

        // Front/rear load beams align with the four rack tongues.
        for (yc=socket_y)
            beam_x(yc,joint_beam_w,joint_beam_total_h);

        // Central handle beam transfers lift to both side beams.
        beam_x((handle_y0+handle_y1)/2,
               center_beam_w,center_beam_total_h);

        // Longitudinal ribs connect the handle end supports to both joint rows.
        for (xc=long_rib_x)
            rib_y(xc,long_rib_w,socket_y[0],socket_y[1],long_rib_total_h);

        for (cx=socket_x)
            for (cy=socket_y)
                collar(cx,cy);

        carry_handle();
    }
}

module top_cover() {
    difference() {
        cover_positive();

        // Tight sockets are diagonal; relieved sockets absorb rack/print skew.
        for (ix=[0:1])
            for (iy=[0:1]) {
                c=(ix==iy) ? locator_clearance : relief_clearance;
                socket_cut(socket_x[ix],socket_y[iy],c);
                collar_lock_passage(socket_x[ix],socket_y[iy]);
            }
    }
}

module positive_lock_pin(yc) {
    // The root overlaps the strap by 0.2 mm; the insertion tip is tapered.
    root_x=9.80;
    tip_x=10+lock_pin_len;
    hull() {
        translate([root_x,yc-lock_pin_y/2,(3-lock_pin_z)/2])
            cube([0.35,lock_pin_y,lock_pin_z]);
        translate([tip_x-0.35,
                   yc-(lock_pin_y-lock_tip_reduction)/2,
                   (3-(lock_pin_z-lock_tip_reduction))/2])
            cube([0.35,
                  lock_pin_y-lock_tip_reduction,
                  lock_pin_z-lock_tip_reduction]);
    }
}

module side_lock() {
    union() {
        // 144 mm strap. In assembly it sits outside one rack side.
        translate([6,5,0]) cube([4,144,3]);

        // Center pull tab remains outside the cover edge.
        hull() {
            translate([0,69,0]) cube([10,16,3]);
            translate([2,66,0]) cube([8,22,3]);
        }

        positive_lock_pin(socket_y[0]);
        positive_lock_pin(socket_y[1]);
    }
}

module left_lock_assembled(z0=58) {
    translate([-10,0,z0+2]) side_lock();
}

module right_lock_assembled(z0=58) {
    translate([212,154,z0+2])
        rotate([0,0,180]) side_lock();
}

module rack_reference() {
    // R3.5 native bounds are X=-8..190, Y=0..150.
    translate([10,2,0]) assembled_tier(0);
}

module assembly_preview() {
    color([0.34,0.38,0.41]) rack_reference();
    color([0.73,0.40,0.13]) translate([0,0,58]) top_cover();
    color([0.82,0.20,0.14]) {
        left_lock_assembled(58);
        right_lock_assembled(58);
    }
}

module print_plate() {
    top_cover();

    // Two identical locks fit on the same 256 x 256 mm plate.
    translate([0,184,0]) rotate([0,0,-90]) side_lock();
    translate([0,214,0]) rotate([0,0,-90]) side_lock();
}

module fit_check() {
    // A valid result is empty or only zero-thickness contact surfaces.
    intersection() {
        color([0.34,0.38,0.41]) rack_reference();
        union() {
            translate([0,0,58]) top_cover();
            left_lock_assembled(58);
            right_lock_assembled(58);
        }
    }
}

if (part=="cover") top_cover();
else if (part=="side_lock") side_lock();
else if (part=="print_plate") print_plate();
else if (part=="assembly_preview") assembly_preview();
else if (part=="fit_check") fit_check();
else assert(false,"Unknown part");
