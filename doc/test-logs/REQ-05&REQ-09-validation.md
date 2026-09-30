# REQ-05 & REQ-09 Validation Report

**Subject:** Frame connections and tier expansion.  
**Method:** Manual fit checks and prototype assembly.  
**Equipment:** Bambu P1S, 0.4 mm nozzle; PETG HF for the final rack.

## Trials and Decisions

Dimensions are nominal CAD values, not measured printed clearances.

| Trial | Parameters | Observation | My decision |
| --- | --- | --- | --- |
| A/B/C pin samples | 8.0 × 3.0 mm hole; A: 7.7 × 2.7, B: 7.8 × 2.8, C: 7.9 × 2.9 mm roots; 5.4 mm shaft length | C fitted, but the two mating blocks still did not engage firmly | Keep the C pin size and continue refining the mating connection. |
| Stacking fit refinement | Selected nominal clearance: 0.10 mm per side | The later sample felt secure and fitted as intended | Use this clearance for the tier tongue/socket interface. |
| Full frame | R3.5: two side frames and three beams per tier; 58 mm tier pitch; integral pegs at both beam ends | Three tiers assembled; fourth-tier expansion was not tested | Integrate the pegs into the beams. The front/rear beam ends also lock the stacking joints, avoiding separate rack pins. |

**Interface distinction:** The final beam peg root is 7.9 × 2.9 mm in an 8.0 × 3.0 mm hole: **0.10 mm total difference per dimension**. The stacking tongue/socket has **0.10 mm clearance per side**. These are separate fits.

**One guided R3.5 tier:** 62.38 g and 4 h 41 min — slicer estimates.

## Conclusion

I selected the tested connection concept for the modular frame. Initial fit and three-tier assembly are established. Fourth-tier expansion, repeated assembly cycles, and load capacity remain unverified.

**Evidence:** [A/B/C samples](../images/joint_fit_coupon.jpg) · [Selected connection](../images/c_joint_selected_assembled.jpg) · [Assembled frame](../images/empty_three_tier_rack.jpg).

---

**Test dates:** Unconfirmed in the retained records.  
**Report compiled:** 2026-09-30 00:03 EDT (UTC-04:00).
