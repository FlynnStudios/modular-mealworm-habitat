// Six identical removable ventilation cartridges, in one STL plate.
// Compatible with the existing 66 x 4 x 18 mm drawer receiver.
// PETG HF / 0.4 mm nozzle candidate; nominal apertures are not an animal-escape rating.
// Print the slotted face on the bed, at 100% scale, without supports in the slots.

part = "plate"; // "plate" or "single"

module_w = 66;
module_h = 18;
module_depth = 4;
face_t = 1.2;
slot_w = 0.6;
rib_w = 1.0;
// Keep every through-slot inside the rear spacer's 58 x 10 mm clear window.
// This avoids a partial roof over openings when the rear ring is printed.
slot_h = 10;
slot_count = 36;
pitch = slot_w + rib_w;
slot_x0 = (module_w - (slot_count * slot_w + (slot_count-1) * rib_w)) / 2;

// The screen face is Z = 0..1.2 so its holes remain open from the first layer.
// The shallow rear perimeter follows the earlier cartridge's mating geometry.
module single_cartridge() {
    union() {
        difference() {
            cube([module_w, module_h, face_t]);
            for (i = [0:slot_count-1])
                translate([slot_x0 + i*pitch, 4, -0.05])
                    cube([slot_w, slot_h, face_t+0.1]);
        }
        translate([2, 2, face_t-0.1])
            linear_extrude(height=module_depth-face_t+0.1)
                difference() {
                    square([module_w-4, module_h-4]);
                    translate([2, 2]) square([module_w-8, module_h-8]);
                }
    }
}

module six_cartridges() {
    // 2 columns x 3 rows; 6 mm separation of nominal outer envelopes.
    for (row = [0:2], col = [0:1])
        translate([col*(module_w+6), row*(module_h+6), 0])
            single_cartridge();
}

if (part == "plate") six_cartridges();
else if (part == "single") single_cartridge();
else assert(false, "Unknown part");
