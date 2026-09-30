# REQ-03 & REQ-09 Validation Report

**Subject:** Printed ventilation inserts and drawer fit.  
**Method:** Visual inspection and manual installation.  
**Equipment:** Bambu P1S, 0.4 mm nozzle; PETG HF for the final inserts.

## Trials and Decisions

Dimensions below are nominal CAD values, not measured printed openings.

| Trial | Parameters | Observation | My decision |
| --- | --- | --- | --- |
| Flat mesh coupon | Openings: 0.25 / 0.35 / 0.45 / 0.55 mm; ribs: 0.45 mm | Uneven strands and poorly formed openings | Try a thinner upright slot coupon. |
| Upright slot coupon | Slots: 0.30 / 0.40 / 0.50 / 0.60 mm; ribs: 0.50 mm; panel thickness: 0.80 mm | Fine strings remained, but I judged the 0.60 mm section usable | Carry 0.60 mm into the final insert design. |
| Final inserts | 66 × 18 × 4 mm (W × H × D); 0.60 mm slots; 1.00 mm ribs; 1.20 mm face thickness | Six inserts printed and installed, with almost no fine strings and no obvious initial damage | Use replaceable printed inserts to avoid buying mesh and allow separate replacement. |
| Drawer receivers | Two supported v1.4 drawers; one v1.4.1 drawer with support feet extending from Z = 0 to 24 mm | Both arrangements accepted the inserts; supported v1.4 receivers printed acceptably | Keep the supported v1.4 drawers in use; an added support foot was not essential for those prints. |

**Final six-insert plate:** 13.87 g and 1 h 38 min — slicer estimates.

## Conclusion

I selected the final 0.60 mm-slot insert for the assembled prototype. These trials establish initial printability and fit. Repeated replacement and airflow remain unverified; the rear stop partly obstructs the rear vents. Escape prevention is covered separately under REQ-04.

**Evidence:** [Early coupon](../images/vent_coupon_top.jpg) · [Six final inserts](../images/six_vent_print_plate.jpg) · [Drawer fit](../images/drawer_vent_fit.jpg).

---

**First dated print update:** 2026-09-23 20:25 EDT (2026-09-24 00:25 UTC). Later trial dates are unconfirmed.  
**Report compiled:** 2026-09-29 23:56 EDT (UTC-04:00).
