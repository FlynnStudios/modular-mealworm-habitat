// Flat-pack repeatable rack tier R3.5 — units: mm.
// Target: PETG, 0.4 mm nozzle; actual normal layer height varied by part.
//
// Corrected architecture:
// - Two identical side frames and three identical crossbeams.
// - Every crossbeam has an integral C-spec peg at each end.
// - The front and rear beam pegs also pass through the locating tongues of the
//   tier below, so those four integral pegs lock all four stacking corners.
// - The middle beam supports the drawer and aligns with a slim full-height
//   center guide on each side frame to reduce lateral drawer drift.
// - No loose pins, clips, screws, or extra bottom lock passages.
//
// One print plate contains exactly five parts:
//   2 x identical side frames
//   3 x identical crossbeams with integral C-spec pegs
//
// The C fit comes from joint_lock_fit_test_v2_abc.scad. The tongue/socket fit
// comes from captive_joint_fit_test_v3.scad.

$fn = 40;
part = "print_plate";

// Rack and nominal drawer envelope.
rack_d = 150;
inner_w = 182;               // 180 mm drawer + 1 mm per side.
frame_t = 8;
outer_w = inner_w+2*frame_t;
tier_pitch = 58;

drawer_w = 180;
drawer_d = 140;
drawer_h = 48;
drawer_x = 1;
drawer_y = 0;
drawer_z = 8;

// Two-post side frame and three bottom crossbeams.
rail_h = 8;
post_d = 22;
beam_y = 10;
beam_z = 8;
front_joint_y = post_d/2;             // 11 mm.
middle_beam_y = rack_d/2;             // 75 mm.
rear_joint_y = rack_d-post_d/2;       // 139 mm.
beam_centers = [front_joint_y,middle_beam_y,rear_joint_y];
center_guide_d = 10;          // Slim Y-width; adds guidance without a bulky post.

// One shared transverse centerline lets the front/rear beam pegs double as
// the tier-to-tier locks.
joint_center_z = 3.5;

// Nominal C-spec peg/receiver dimensions.
female_slot_y = 8.0;
female_slot_z = 3.0;
male_root_y = 7.9;
male_root_z = 2.9;
male_tip_reduction = 0.30;
male_len = frame_t;

// Nominal repeatable tongue/socket geometry.
stack_tongue_x = 4.8;
stack_tongue_y = 14.0;
stack_tongue_h = 7.0;
stack_chamfer = 0.35;
stack_clearance = 0.10;      // Per side, selected by the physical test.
stack_socket_extra_depth = 0.20;

module stack_tongue(y_center) {
    tx = (frame_t-stack_tongue_x)/2;
    ty = y_center-stack_tongue_y/2;

    union() {
        translate([tx,ty,tier_pitch-0.10])
            cube([stack_tongue_x,stack_tongue_y,
                  stack_tongue_h-stack_chamfer+0.10]);

        hull() {
            translate([tx,ty,
                       tier_pitch+stack_tongue_h-stack_chamfer-0.01])
                cube([stack_tongue_x,stack_tongue_y,0.02]);
            translate([tx+stack_chamfer,
                       ty+stack_chamfer,
                       tier_pitch+stack_tongue_h-0.02])
                cube([stack_tongue_x-2*stack_chamfer,
                      stack_tongue_y-2*stack_chamfer,0.02]);
        }
    }
}

module stack_socket(y_center) {
    sx = stack_tongue_x+2*stack_clearance;
    sy = stack_tongue_y+2*stack_clearance;
    socket_depth = stack_tongue_h+stack_socket_extra_depth;

    translate([(frame_t-sx)/2,
               y_center-sy/2,
               -0.05])
        cube([sx,sy,socket_depth+0.05]);
}

// All three bottom receivers use the same C slot. At the front and rear this
// one opening is also the layer-lock passage; no second hole is added.
module beam_female_slot(y_center,z_center=joint_center_z) {
    translate([-0.05,
               y_center-female_slot_y/2,
               z_center-female_slot_z/2])
        cube([frame_t+0.10,female_slot_y,female_slot_z]);
}

// Matching passage through the top locating tongue. The next tier's
// front/rear integral beam peg passes through this opening.
module tongue_lock_passage(y_center) {
    translate([-0.05,
               y_center-female_slot_y/2,
               tier_pitch+joint_center_z-female_slot_z/2])
        cube([frame_t+0.10,female_slot_y,female_slot_z]);
}

module side_frame() {
    difference() {
        union() {
            // Continuous lower rail includes the complete bottom support.
            cube([frame_t,rack_d,rail_h]);

            // Two equal corner posts plus one slim central drawer guide.
            cube([frame_t,post_d,tier_pitch]);
            translate([0,rack_d-post_d,0])
                cube([frame_t,post_d,tier_pitch]);
            translate([0,middle_beam_y-center_guide_d/2,0])
                cube([frame_t,center_guide_d,tier_pitch]);

            stack_tongue(front_joint_y);
            stack_tongue(rear_joint_y);
        }

        // Exactly three receiver openings along the bottom rail.
        for (yc=beam_centers)
            beam_female_slot(yc);

        // Two bottom sockets receive the tier below.
        stack_socket(front_joint_y);
        stack_socket(rear_joint_y);

        // Two top-tongue passages are used by the next tier's front/rear
        // beams. They are not an additional bottom-hole system.
        tongue_lock_passage(front_joint_y);
        tongue_lock_passage(rear_joint_y);
    }
}

// Positive-X integral C peg. Its centerline is shared with the tongue hole.
module c_male_peg_positive() {
    tip_y = male_root_y-male_tip_reduction;
    tip_z = male_root_z-male_tip_reduction;

    hull() {
        translate([-0.02,-male_root_y/2,
                   joint_center_z-male_root_z/2])
            cube([0.30,male_root_y,male_root_z]);
        translate([male_len-0.30,-tip_y/2,
                   joint_center_z-tip_z/2])
            cube([0.30,tip_y,tip_z]);
    }
}

module crossbeam() {
    union() {
        translate([0,-beam_y/2,0])
            cube([inner_w,beam_y,beam_z]);

        mirror([1,0,0]) c_male_peg_positive();
        translate([inner_w,0,0]) c_male_peg_positive();
    }
}

module assembled_side_frames(z0=0) {
    translate([0,0,z0]) {
        mirror([1,0,0]) side_frame();
        translate([inner_w,0,0]) side_frame();
    }
}

module assembled_beams(z0=0) {
    translate([0,0,z0])
        for (yc=beam_centers)
            translate([0,yc,0]) crossbeam();
}

module assembled_tier(z0=0) {
    assembled_side_frames(z0);
    assembled_beams(z0);
}

module assembled_frame() {
    assembled_tier(0);
}

module two_tier_stack() {
    assembled_tier(0);
    assembled_tier(tier_pitch);
}

module drawer_body() {
    import("../../stl/current/single_drawer_body_v1_4.stl");
}

module assembled_with_drawer() {
    color([0.34,0.38,0.41]) assembled_frame();
    color([0.78,0.38,0.12,0.82])
        translate([drawer_x,drawer_y,drawer_z]) drawer_body();
}

// Exact two-tier preview: front/rear beams of the upper tier are highlighted
// because their four integral ends are the only layer locks.
module two_tier_preview() {
    color([0.34,0.38,0.41]) {
        assembled_side_frames(0);
        assembled_beams(0);
        assembled_side_frames(tier_pitch);
        translate([0,middle_beam_y,tier_pitch]) crossbeam();
    }

    color([0.82,0.22,0.14]) {
        translate([0,front_joint_y,tier_pitch]) crossbeam();
        translate([0,rear_joint_y,tier_pitch]) crossbeam();
    }

    color([0.82,0.43,0.13,0.42]) {
        translate([drawer_x,drawer_y,drawer_z]) drawer_body();
        translate([drawer_x,drawer_y,tier_pitch+drawer_z]) drawer_body();
    }
}

module side_frame_print(x0) {
    // Broad Y-Z face on the bed; printed height is only 8 mm.
    translate([x0,0,frame_t])
        rotate([0,90,0]) side_frame();
}

module print_plate() {
    side_frame_print(0);
    side_frame_print(70);

    // All three beams are identical. Their end pegs are already fused in.
    for (y0=[160,175,190])
        translate([10,y0,0]) crossbeam();
}

module detail_lower_corner() {
    intersection() {
        mirror([1,0,0]) side_frame();
        translate([-frame_t-0.1,0,tier_pitch-10])
            cube([frame_t+0.2,post_d+2,stack_tongue_h+11]);
    }
}

module detail_upper_corner() {
    translate([0,0,tier_pitch])
        intersection() {
            mirror([1,0,0]) side_frame();
            translate([-frame_t-0.1,0,0])
                cube([frame_t+0.2,post_d+2,12]);
        }
}

module detail_lock_beam() {
    intersection() {
        translate([0,front_joint_y,tier_pitch]) crossbeam();
        translate([-frame_t-0.1,0,tier_pitch-0.1])
            cube([frame_t+34,post_d+2,beam_z+0.2]);
    }
}

// Left/front seam detail. The upper tier beam end passes through the upper
// side-frame receiver and the lower locating tongue at the same time.
module front_left_lock_detail() {
    detail_lower_corner();
    detail_upper_corner();
    detail_lock_beam();
}

// Collision checks return only zero-thickness contact surfaces when correct.
module fit_check_stack() {
    intersection() {
        assembled_tier(0);
        assembled_tier(tier_pitch);
    }
}

module fit_check_drawer() {
    intersection() {
        assembled_frame();
        translate([drawer_x,drawer_y,drawer_z+0.01]) drawer_body();
    }
}

if(part=="print_plate") print_plate();
else if(part=="side_frame") side_frame();
else if(part=="crossbeam") crossbeam();
else if(part=="assembled_frame") assembled_frame();
else if(part=="assembled_with_drawer") assembled_with_drawer();
else if(part=="two_tier_stack") two_tier_stack();
else if(part=="two_tier_preview") two_tier_preview();
else if(part=="front_left_lock_detail") front_left_lock_detail();
else if(part=="detail_lower_corner") detail_lower_corner();
else if(part=="detail_upper_corner") detail_upper_corner();
else if(part=="detail_lock_beam") detail_lock_beam();
else if(part=="fit_check_stack") fit_check_stack();
else if(part=="fit_check_drawer") fit_check_drawer();
else assert(false,"Unknown part");
