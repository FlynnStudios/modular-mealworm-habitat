// One glued rear-center stop for the three-tier R3.5 rack; units: mm.
// Print orientation lies flat on the bed: 174 x 12 x 6 mm.
// Install orientation is upright: 12 mm across rack, 6 mm rearward, 174 mm tall.
// Glue face rests against the back edge of the three rear crossbeams.
// This replaces the earlier per-tier press-fit bar proposal.

part = "print"; // print | installed

stop_length = 174;
stop_width = 12;
stop_depth = 6;

module rear_stop_print() {
    cube([stop_length,stop_width,stop_depth]);
}

// R3.5 inner frame: X = 0..182; its center is X = 91 mm.
// Rear crossbeams end at Y = 144 mm. Tier bottoms are Z = 0, 58, 116 mm.
module rear_stop_installed() {
    translate([91-stop_width/2,144,0])
        cube([stop_width,stop_depth,stop_length]);
}

if (part == "print") rear_stop_print();
else if (part == "installed") rear_stop_installed();
else assert(false,"Unknown part");
