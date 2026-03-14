# AGENTIC_CHANGELOG.md

Agent-applied compatibility notes for this local PBWP workspace.

This file supplements `CHANGELOG.md` with focused notes about recent maintenance work driven by PB Staging drift.

## 2026-03-13 - PB_NailgunAltFire sync fix

Summary:
PB Staging added a new `PB_NailgunAltFire()` function to `BaseWeapon_Functions.zsc`. Because PBWP overrides that file at the same lump path, the engine was loading PBWP's forked copy instead of PB Staging's — causing the new function to be missing. This produced a fatal DECORATE parse error: `Invalid parameter 'PB_NailgunAltFire'` in `actors/weapons/slot5/nailgun.dec` line 688.

Root cause:
PBWP's `zscript/Weapons/BaseWeapon_Functions.zsc` collides with PB Staging's identically-pathed file. In GZDoom/UZDoom, `#include` resolves to the last-loaded pk3's version of a file when paths match. Since PBWP loads after PB Staging, PB Staging's `#include "zscript/Weapons/BaseWeapon_Functions.zsc"` resolves to PBWP's forked copy, which lacked the newly-added function.

Fix applied:
- Added `PB_NailgunAltFire()` to PBWP's `zscript/Weapons/BaseWeapon_Functions.zsc`, matching PB Staging's implementation exactly.

Known file-path collisions (override by design):
PBWP intentionally overrides three PB Staging files via lump-path collision. When PB Staging updates any of these, the changes must be manually synced into PBWP's copies:
- `zscript/Weapons/BaseWeapon_Functions.zsc` (PBWP patches: `PB_Execute` return type, typed class params, stubs)
- `zscript/Weapons/BaseWeapon_Melee.zsc` (PBWP patches: leg overlay migration, melee system extensions)
- `zscript/Weapons/BaseWeapon_Equipment.zsc` (PBWP patches: equipment animation extensions)

---

## 2026-03-13 - PB Staging drift follow-up

Summary:
PB Staging was updated again after the original compatibility pass. A targeted drift audit found that most prior shims were still required, but two local compatibility placeholders had become stale against newer upstream definitions.

Changes applied:
- Removed the local `HasLeech` stub from `zscript/Weapons/BaseWeapon_Functions.zsc`. PB Staging now defines `HasLeech` in `PB_Staging/actors/Weapons/Throwables.dec`, so keeping the stub risked a duplicate-definition load/compile failure.
- Removed the local `ThrownStunGrenade` stub from `zscript/Weapons/BaseWeapon_Functions.zsc`. PBWP no longer needs the placeholder after aligning with the current upstream class name.
- Updated the stun grenade throw action in `zscript/Weapons/BaseWeapon_EquipmentAnims.zs` to fire `PB_ThrownStunGrenade` instead of `ThrownStunGrenade`, matching current PB Staging behavior.

Compatibility shims intentionally kept:
- `LaserSightActivated` stub in `zscript/Weapons/BaseWeapon_Functions.zsc`
- `PB_VisualRailBlue` and `PB_VisualRailRed` stubs in `zscript/Weapons/BaseWeapon_Functions.zsc`
- `action state PB_Execute()` compatibility change in `zscript/Weapons/BaseWeapon_Functions.zsc`
- `UnloaderToken` property re-declaration in `zscript/Weapons/BaseWeapon_PBWP.zs`
- `PB_ExecuteGK()` stub in `zscript/Weapons/BaseWeapon_PBWP.zs`

Verification completed:
- Confirmed no remaining local `class HasLeech` definition in PBWP-owned files.
- Confirmed no remaining PBWP-owned references to legacy `ThrownStunGrenade`.
- Confirmed the updated throw state now uses `PB_ThrownStunGrenade`.

Verification still recommended outside source review:
- Launch UZDoom with load order `Map WAD -> PB Staging -> PBWP` and perform a compile/load smoke test to catch any additional runtime or parser-level drift introduced by the newest PB Staging update.
# CHANGELOG — Local Modifications vs Upstream

All changes documented below are relative to the upstream source:
[RENEGADE-ANDROiD/Project-Brutality-Weapons-Pack](https://github.com/RENEGADE-ANDROiD/Project-Brutality-Weapons-Pack) (main branch)

---

## PB Staging API Compatibility Fixes

PB Staging introduced breaking API changes that caused ~129 ZScript/DECORATE compilation errors. The following fixes were applied to restore compatibility.

### `PB_Execute()` return type (fixes ~100 call-site errors)

**File:** `zscript/Weapons/BaseWeapon_Functions.zsc`

Changed `PB_Execute()` from `action void` to `action state` and added `return resolveState(null);` at all exit points. This single change fixes every call site that does `return PB_Execute()` across 80+ weapon files — no per-file edits required.

### Typed `class` parameters (fixes ~10 errors)

**File:** `zscript/Weapons/BaseWeapon_Functions.zsc`

PB Staging's `Spawn()` returns `Object` when given an untyped `class` parameter, causing "Cannot convert from Object to Actor/Inventory" errors. The following function signatures were updated:

| Function | Parameter | Before | After |
|---|---|---|---|
| `PB_SpawnCasing` | `casing` | `class` | `class<Actor>` |
| `PB_UnloadMag` | `AmmoMag_Action` | `class` | `class<Inventory>` |
| `PB_UnloadMag` | `AmmoPool_Action` | `class` | `class<Inventory>` |
| `PB_UnloadMag` | `spawnActor` | `class` | `class<Actor>` |
| `PB_TakeAmmo` | `ammoType` | `class` | `class<Inventory>` |

### Stub functions for removed PB APIs (fixes ~13 errors)

**File:** `zscript/Weapons/BaseWeapon_Functions.zsc` (appended at end of file)

PB Staging removed `PB_VisualRailBlue()` and `PB_VisualRailRed()`. Stub replacements were added that wrap the existing `PB_LightVisualRail()` with appropriate color presets. These are called by:

- `actors/Weapons/Slot-7/Gauss.dec` (Blue)
- `actors/Weapons/Slot-8/PlasmaRifle.dec` (Blue)
- `actors/Weapons/Slot-8/Extinction_Ray.dec` (Red, 11 calls)

### Stub classes for removed PB definitions (fixes 3 errors)

**File:** `zscript/Weapons/BaseWeapon_Functions.zsc` (appended at end of file)

PB Staging removed three classes that this pack references. Minimal stubs were added:

| Class | Type | Referenced By |
|---|---|---|
| `LaserSightActivated` | `Inventory` | `zscript/gearbox/pb/tokens.zs` |
| `HasLeech` | `Inventory` | `zscript/Weapons/BaseWeapon_Equipment.zsc` |
| `ThrownStunGrenade` | `Actor` | `zscript/Weapons/BaseWeapon_EquipmentAnims.zs` |

### `PB_ExecuteGK()` stub and `UnloaderToken` property

**File:** `zscript/Weapons/BaseWeapon_PBWP.zs`

- Added `UnloaderToken` string property declaration to `extend class PB_WeaponBase`. PB Staging removed this property from the base class, so the weapons pack re-declares it.
- Added `PB_ExecuteGK()` stub function (delegates to `PB_Execute()`). The GKCompat module that originally defined this is disabled, but `FiretoExecute()` still references it.

---

## Leg Overlay System Migration

PB Staging replaced the old `A_Overlay(-10, ...)` leg-sprite system with a new `A_LegOverlay(-1000, ...)` API. All occurrences were updated:

### `zscript/Weapons/BaseWeapon_Melee.zsc`

Six `A_Overlay(-10, ...)` calls changed to `A_LegOverlay(-1000, ...)` across the kick/melee states: `DoKick`, `LowerKick`, `DropKick`, `AirKick`, and `GoMeleeInstead`. An `A_OverlayFlags(-1000, PSPF_ADDWEAPON|PSPF_ADDBOB, False)` call was also added after the DoKick leg overlay setup.

### `zscript/Weapons/BaseWeapon_MeleeSystem.zs`

`A_Overlay(-10, ...)` changed to `A_LegOverlay(-1000, ...)` in the `GoMeleeInstead` state.

### `zscript/Weapons/BaseWeapon_GKCompat.zs`

`A_Overlay(-10, ...)` changed to `A_LegOverlay(-1000, ...)` in the `BloodPunch` state.

### `actors/Weapons/Slot-1/BeamKatana.dec`

`A_Overlay(-10, ...)` changed to `A_LegOverlay(-1000, ...)` in `QuickMelee`/`GoMeleeInstead` states.

---

## `PB_CheckReload` Signature Update

PB Staging added new parameters to `PB_CheckReload`, expanding it from 5 to 7 parameters. The following weapon files were updated to pass 3 leading `null` arguments matching the new signature:

- `zscript/Weapons/Slot-5/NeoHMG.zs` — `PB_checkReload(null,"Ready","NoAmmo",80,1)` changed to `PB_CheckReload(null,null,null,"Ready","NoAmmo",80,1)`
- `zscript/Weapons/Slot-4/M41A.zs` — Same pattern applied to the `PB_CheckReload` call

---

## New Files Added

### New weapon actors (DECORATE)

| File | Weapon | Notes |
|---|---|---|
| `actors/Weapons/Slot-1/BattleAxeAndShield.dec` | Battle Axe and Shield | New Slot 1 melee weapon from Schism |
| `actors/Weapons/Slot-1/ArgentSith.dec` | Argent Sith Beam Katana | New Slot 1 weapon; upgrade over Energy Beam Katana |
| `actors/Weapons/Slot-7/Gauss.dec` | UAC Gauss Cannon | New Slot 7 directory and weapon (moved from Slot 8) |
| `actors/Weapons/Slot-8/PlasmaRifle.dec` | Plasma Assault Rifle | New Slot 8 directory and weapon |

### Documentation and tooling

| File | Purpose |
|---|---|
| `AGENTS.md` | AI coding agent reference — project architecture, conventions, class hierarchy, key functions |
| `.cursor/plans/fix_pb_staging_compat.plan.md` | Cursor IDE plan documenting the 129-error fix strategy |

