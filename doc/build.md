# Build Guide

This guide covers the three-tier configuration using the files in [models/stl/current](../models/stl/current/). Initial printing and assembly have been checked; functional validation is still in progress.

## 1. Files and Quantities

Print at **100% scale, in millimeters**. The counts below are file copies, not individual parts. Files containing several parts already include their print layout.

| STL file | Copies | Parts produced |
| --- | ---: | --- |
| [single_drawer_body_v1_4.stl](../models/stl/current/single_drawer_body_v1_4.stl) | 3 | Three drawers with integrated finger pulls |
| [rack_flatpack_center_guide_r3_5_plate.stl](../models/stl/current/rack_flatpack_center_guide_r3_5_plate.stl) | 3 | Six side frames and nine crossbars |
| [top_cover_carry_v1_1_complete_plate.stl](../models/stl/current/top_cover_carry_v1_1_complete_plate.stl) | 1 | One cover with integrated handle and two removable side-lock rails |
| [vent_single_060_rib100_x6.stl](../models/stl/current/vent_single_060_rib100_x6.stl) | 1 | Six vent inserts: two per drawer |
| [rear_center_glue_stop_r3_5_174x12x6.stl](../models/stl/current/rear_center_glue_stop_r3_5_174x12x6.stl) | 1 | One rear stop spanning three tiers |

The rack uses the pegs built into the crossbars. It needs no separate rack pins, screws, nuts, or threaded inserts. The **two cover side locks are separate parts** and are included in the cover plate.

Additional material: PETG HF filament and cyanoacrylate adhesive for the rear stop. Purchased mesh is not required.

Component revision numbers are independent of the overall project version. Use the files listed here together; later-looking filenames in `experiments/` are not automatically replacements.

## 2. Printing

**Recorded equipment:** Bambu P1S, 0.4 mm nozzle, PETG HF. Normal layer heights varied between 0.24 and 0.28 mm by part.

| Component | Orientation and support notes |
| --- | --- |
| Drawer | Bottom on the bed, opening upward. Use supports from the build plate for the vent receivers and finger pull. The v1.4 receivers begin above the drawer floor; this file does not include the experimental support feet. |
| Rack plate | Keep the supplied flat layout: side frames lie on their broad faces, with crossbars beside them. Build-plate-only supports were used for the rack. Inspect the small peg undersides and receiver openings in the sliced preview. |
| Cover plate | Flat cover underside on the bed, handle upward; keep both side locks flat beside it. The original support settings were not recorded. Inspect the handle bridge and locking passages before printing. |
| Vent plate | Keep all six inserts flat, slotted face on the bed. Do not generate supports inside the slots. Check that the 0.60 mm nominal slots remain open in the sliced preview. |
| Rear stop | Lay the 174 × 12 mm face on the bed; printed height is 6 mm. |

The exact per-part profiles, first-layer height, temperatures, speeds, wall counts, and infill settings were not retained in the current records. This is not a complete slicer preset. Record these settings when reproducing the build.

Use the **standalone vent file listed above**. The older vent options inside the drawer SCAD are different from the selected six-insert model.

### Recorded slicer estimates

| Component | Quantity | Material | Time |
| --- | ---: | ---: | ---: |
| Supported v1.4 drawer | 1 | 116.78 g | 5 h 40 min |
| Guided R3.5 rack plate | 1 | 62.38 g | 4 h 41 min |
| Cover plate, including both side locks | 1 | 90.12 g | 5 h 15 min |
| Six-insert vent plate | 1 | 13.87 g | 1 h 38 min |
| Rear stop | 1 | 8.24 g | 35 min |
| **Three-tier set: 3 drawers + 3 rack plates + remaining plates** | **1 set** | **649.71 g** | **38 h 31 min** |

The total is calculated from the individual estimates. It is not a measured build time or material total and excludes failed prints, calibration pieces, finishing, and assembly.

## 3. Assembly

Remove supports and loose strings first, especially around the receivers, sockets, and pegs. Check the fit by hand before applying adhesive.

### Rack

Each tier uses two identical side frames and three identical crossbars. The upper tongues and lower sockets locate the tiers. The front and rear crossbar pegs of the tier above pass through the lower tier's tongues and lock the connection.

**Stacking order matters:** align the tongues and sockets before fully seating the crossbars that pass through them. Fully assembled tiers cannot simply be stacked while these pegs occupy the socket passages.

A sequence based on the CAD geometry is:

1. Arrange two columns of three side frames, with the tongues upward and sockets over the tongues below. Support the loose columns during assembly.
2. Position three crossbars at each tier: front, middle, and rear. Start their pegs into one side, then align the opposite side before fully seating the joints.
3. Seat the frame joints progressively. Check that all tier seams close and that the front and rear pegs engage the tongue passages.
4. Test each drawer before adding the cover or rear stop. It should sit on the crossbars with the finger pull facing forward.

Do not force a misaligned peg. Check for support residue and confirm that the tier seams are seated.

[Assembled rack reference](images/empty_three_tier_rack.jpg)

### Vent inserts and rear stop

1. Slide two inserts downward into each drawer's front and rear receivers. The flat slotted face sits toward the drawer wall; the raised spacer faces into the drawer. Seat both inserts without forcing the retaining lips.
2. Stand the rear stop vertically at the center of the rack's back: **174 mm tall, 12 mm wide, 6 mm deep**.
3. Dry-fit it against the rear edges of all three rear crossbars. Check drawer travel, then bond those contact areas with cyanoacrylate and let it cure according to the adhesive instructions.

The rear stop partly obstructs the rear vents. Its current length is specific to three tiers.

[Vent fit reference](images/drawer_vent_fit.jpg)

### Cover

Lower the cover onto the four top tongues. Insert one side-lock rail from each side so that both pins on each rail engage the aligned passages. To remove the cover, withdraw both rails first.

Loaded carrying has not been tested. Support the assembled rack from underneath when moving it until that check is complete.

## 4. Prototype Configuration and Open Checks

The photographed prototype contains **two guided R3.5 tiers and one earlier unguided tier**, plus **two supported v1.4 drawers and one v1.4.1 drawer with receiver support feet**. The print list above instead uses three copies of the current guided frame and supported v1.4 drawer.

Initial assembly, drawer access, and vent fit were checked. Occasional drawer realignment remains. Containment, ventilation during rearing, fourth-tier expansion, loaded carrying, and repeated-use durability remain open.

See the [validation reports](test-logs/) for observations and the [requirements](../design-requirements.md) for the planned checks. For containment testing, use a secondary enclosure as described in the REQ-04 report.

---

**Guide compiled:** 2026-09-30 EDT (UTC-04:00).

