# V1 Requirements and Evidence

V1 is intended to be a functional, printable system for a small colony. The physical prototype and a recommended repeat-build configuration are separate states. A CAD feature, a successful first assembly, and a measured repeat-use result are not interchangeable evidence.

| ID | Requirement | Evidence available now | Status / remaining work |
| --- | --- | --- | --- |
| REQ-01 | Use three independently removable drawers for stage management. | Three-drawer assembly photo and builder-reported independent withdrawal. | **Observed** in initial use; record longer-term operation. |
| REQ-02 | Reduce horizontal footprint relative to three spread-out food containers. | Stacked physical configuration. | **Geometric intent visible**; no measured before/after footprint. |
| REQ-03 | Keep ventilation accessible while drawers are stacked, using replaceable printed inserts. | Six installed inserts, two per drawer; builder inspection found little stringing and no initial visible damage during installation. | **Initial assembly observed**; repeated retention and smallest-larva passage remain open. |
| REQ-04 | Use repeatable tiers so the rack can be expanded without replacing earlier tiers. | Three tiers assembled; shared R3.5 interface is present in CAD and a joint coupon favored 0.10 mm nominal per-side clearance. | **Three-tier assembly observed**; a fourth tier and loaded stability not printed/tested. |
| REQ-05 | Assemble structural beams without loose pins, screws, or threaded inserts. | Integral C pegs on the three beams of each tier and assembled prototype. | **Observed** for the current structure; repeated joint cycles remain open. |
| REQ-06 | Provide one removable, positively retained top cover. | Cover and two side rails installed; builder can remove the cover by hand. | **Initial fit observed**; loaded handle carrying untested. |
| REQ-07 | Prevent drawers from sliding out of the rack rear during routine motion. | One glued rear center stop reported installed and hand-push tested. | **Initial stop observed**; adhesive life and rear vent occlusion remain open. |
| REQ-08 | Provide enough side guidance for routine drawer insertion. | Actual unguided insertion jams led to guides; two guided tiers are installed and jam less often. | **Partially met**; occasional realignment is still required. |
| REQ-09 | Fit the existing P1S with a 0.4 mm nozzle and PETG HF. | Complete printed assembly and slicer estimates for selected plates. | **Observed on this printer**; exact profiles and measured elapsed times are not archived. |
| REQ-10 | Document a coherent repeat-build set and its external materials. | [BOM](../BOM.md), selected STLs, editable CAD, and [build guide](build-guide.md). | **Documented candidate**; no second complete repeat build yet. |
| REQ-11 | Distinguish observed function from biological and mechanical limits. | [Validation record](validation.md) separates initial operation from untested containment, airflow, fatigue, and load. | **Documented**; keep updating with real use. |

## Deliberately outside the initial scope

The earlier A/B adult divider is not in the selected configuration. Dedicated sensor ports, automatic environmental monitoring, and systematic print-time/material optimization are later possibilities. A complete breeding cycle, smallest-larva escape observation, a fourth physical tier, and a certified carrying load have **not** been demonstrated. None should be implied by a V1 label without corresponding evidence.

Requirement IDs are stable references for records, not a chronology of design work. Changes to an interface should trigger a fresh fit check for the affected requirement.
