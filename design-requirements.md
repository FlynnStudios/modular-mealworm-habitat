# V1 Product Requirements

My goal for V1 is a compact, opaque, modular habitat for a small mealworm colony. The starting point is three independent drawers for beetles, small larvae, and larger larvae, with roles reassigned as the colony develops. The system must support routine care and later tier expansion.

V1 prioritizes usable functionality and reliable assembly. Print-time and material optimization, sensing, and automation are reserved for later development.

This document defines design inputs and planned verification. Detailed geometry, connection types, manufacturing settings, and test results are recorded separately.

## 1. Requirement Index

| ID | Requirement | User need | V1 target | Verification |
| --- | --- | --- | --- | --- |
| REQ-01 | Independent drawer access | Manage life stages and perform routine care separately | Three compartments; access one without removing the others | Operation demonstration |
| REQ-02 | Compact desktop footprint | Reduce the space occupied by separately arranged containers | Less occupied desktop area than the existing three-container setup | Dimensional comparison |
| REQ-03 | Ventilation and serviceability | Maintain ventilation when stacked; replace ventilation components independently | Open ventilation paths during closed use; replacement without replacing the drawer | Inspection and replacement trial |
| REQ-04 | Occupant containment | Keep larvae and beetles in their assigned compartments | No escape or transfer between drawers during the defined observation period | Containment observation |
| REQ-05 | Tier expansion | Increase capacity as the colony grows | Add one tier while reusing existing tiers; retain stability and access | Expansion assembly and load test |
| REQ-06 | Removable top cover and carrying handle | Access the upper tier and move the assembled system | Hand-removable cover; secure handling of the loaded three-tier assembly | Removal and carrying tests |
| REQ-07 | Rearward drawer retention | Prevent a drawer from being pushed out of the rear | A seated drawer remains supported during normal insertion | Repeated insertion test |
| REQ-08 | Drawer support and alignment | Insert and withdraw drawers without slipping or jamming | Supported, aligned travel without manual sideways correction | Loaded operation test |
| REQ-09 | Fabrication with available equipment | Build the system using existing printing equipment | Printable components and assembly without specialized equipment | Slicing review and prototype build |

All nine requirements are within V1 scope. IDs provide stable references; their sequence does not indicate implementation order. Verification results are tracked in the test records.

## 2. Requirement Definitions and Checks

### REQ-01 — Independent drawer access

**Requirement:** The system shall provide three separate rearing compartments. Each drawer shall be removable and reinsertable for feeding, inspection, transfer, and cleaning while the other drawers remain installed.

**Verification:** Demonstrate each operation on every tier. Confirm that access does not require dismantling the rack or removing another drawer.

### REQ-02 — Compact desktop footprint

**Requirement:** In its normal closed configuration, the system shall occupy less desktop area than the existing three containers arranged separately for use.

**Verification:** Compare occupied areas using a consistent measurement boundary and ventilation clearance. Record temporary drawer-access space separately.

### REQ-03 — Ventilation and serviceability

**Requirement:** Each compartment shall have a ventilation path available with all drawers closed and stacked. Ventilation components shall be replaceable without replacing or damaging the drawer body.

**Verification:** Inspect every tier for obstructed openings and repeat component replacement. Confirm secure retention and absence of damage. Opening inspection establishes the availability of a ventilation path; suitability during rearing remains part of the use evaluation.

### REQ-04 — Occupant containment

**Requirement:** The closed system shall retain the intended larvae and beetles within their assigned drawers, including the smallest larvae intended for this system.

**Verification:** Observe a populated assembly inside a secondary enclosure. Record life stages, approximate sizes, conditions, and duration. Acceptance requires no escape or unintended movement between compartments within that test period.

### REQ-05 — Tier expansion

**Requirement:** The system shall accept at least one additional tier without remaking the existing tiers. The expanded assembly shall remain stable under its intended load and preserve independent drawer access.

**Verification:** Assemble a fourth tier, apply a recorded representative load, and operate each drawer. Check for connection separation, instability, interference, and damage. This test establishes four-tier capability only.

### REQ-06 — Removable top cover and carrying handle

**Requirement:** The top cover shall remain secured during routine operation and be removable by hand for access and expansion. Its handle and attachment shall support moving the three-tier assembly at its defined service load.

**Verification:** Repeat cover installation and removal, then perform a controlled carrying test using an inert load representing the intended filled assembly. Acceptance requires no release, cracking, or permanent deformation that impairs function. Expanded-stack carrying requires a separate load case.

### REQ-07 — Rearward drawer retention

**Requirement:** Normal insertion shall not push a drawer beyond its supported rear position or allow it to exit through the back of the rack.

**Verification:** Repeatedly seat each loaded drawer and inspect its final position and support. Confirm that rearward travel control remains effective without prescribing a particular stopping mechanism.

### REQ-08 — Drawer support and alignment

**Requirement:** Each drawer shall remain supported and aligned throughout normal insertion and withdrawal, until intentionally removed. It shall not slip sideways or jam in a way that requires manual realignment.

**Verification:** Operate loaded drawers on every tier. Record sideways displacement, jams, manual corrections, and visible damage. Acceptance requires completion of the defined cycles without these functional failures.

### REQ-09 — Fabrication with available equipment

**Requirement:** Custom components shall be printable on the available Bambu P1S with a 0.4 mm nozzle and assemblable without specialized equipment. V1 shall establish a reproducible build process; no fixed print-time or material-mass limit is assigned.

**Verification:** Review build-volume fit, print the components, and assemble the system. Record material, settings, orientation, supports, finishing, and assembly steps. Record time and material use as a baseline, distinguishing slicer estimates from measurements.

## 3. Test Log Plan

Dedicated logs cover tests that require repeated operation, load testing, biological observation, or comparison across revisions. Requirements sharing a setup are recorded together.

| Planned log | Related requirements | Record focus |
| --- | --- | --- |
| Ventilation and component replacement | REQ-03, REQ-09 | Opening availability, replacement cycles, retention, damage, and relevant print conditions |
| Occupant containment | REQ-04 | Life stages, sizes, escape paths, observation conditions, duration, and outcome |
| Modular assembly and expansion | REQ-05 | Assembly method, connection behavior, load, stability, and drawer access after expansion |
| Top cover and carrying handle | REQ-06 | Removal cycles, retention, total carried mass, lifting method, and structural condition |
| Drawer operation and retention | REQ-01, REQ-07, REQ-08 | Independent access, support, alignment, rearward travel, and operating failures |

REQ-02 is recorded as a short footprint comparison in the assembly record. REQ-09 is covered by a complete build record and the relevant component trials; it does not require a duplicate standalone test report.

Each log identifies the REQs, tested revision, setup, acceptance criteria, results, evidence, and follow-up action. Cycle counts, service loads, and observation durations remain open test-planning parameters here and are fixed in the relevant protocol before testing. These planned checks do not indicate that a requirement has passed.
