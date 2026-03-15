# Overlay Ghost-Weapon Fix — Layer -998 Melee Persistence Bug

## Problem

After performing a melee attack, the player sees **two copies of their weapon** — one animating (e.g. reload) and one frozen at the idle frame. The static "ghost" weapon persists across all subsequent actions (fire, reload, ADS, etc.) until the player switches weapons.

## Root Cause

PB Staging's `Melee_Equipment_Handler_Overlay` (defined in `BaseWeapon.zc`, running on overlay layer **-777**) dispatches `QuickMelee` to **overlay layer -998** — a separate overlay from `PSP_WEAPON` (layer 1):

```
// From PB Staging's BaseWeapon.zc, Melee_Equipment_Handler_Overlay:
PB_SetUsingMelee(true);
A_Overlay(-998, "QuickMelee");
```

The `QuickMelee` state (overridden by PBWP in `BaseWeapon_MeleeSystem.zs`) runs on layer -998. It flows through `GoMeleeInstead` into the melee animation, and eventually into `GoingToReady` → `SelectingAnimation` → `Ready3`.

At that point, **layer -998 is in `Ready3`**, calling `A_DoPBWeaponAction()` every tic and drawing the weapon's idle sprite — permanently. Meanwhile, `PSP_WEAPON` (layer 1) is *also* in `Ready3`. Both layers display the weapon.

When the player reloads:

- **PSP_WEAPON** transitions to the `Reload` state (showing the animated reload).
- **Layer -998** stays in `Ready3` (showing the static idle frame).
- The player sees both: the animated reload on PSP_WEAPON, and a frozen idle weapon from -998.

`A_WeaponReady()` always transitions `PSP_WEAPON` regardless of which layer calls it, so layer -998 never leaves `Ready3` on its own.

### Why It Wasn't Visible In PB Staging Without PBWP

In PB Staging's **original** design (without PBWP's melee system), the melee animation ran on -998 while `PSP_WEAPON` stayed in `Ready3` showing the weapon idle. Both layers showed the same weapon at the same offset, overlapping perfectly — the player never noticed the duplicate. PBWP's custom melee system changed the behavior but didn't address the -998 lifecycle.

### Additional Contributing Factor: PB_Execute Cleans Up, Regular Melee Doesn't

`PB_Execute()` (the fatality/execution system) correctly handles -998 — it redirects to `PSP_WEAPON` and calls `A_ClearOverlays(-998, -997)`. But the regular melee path (`GoMeleeInstead` → melee animation → `GoingToReady`) never clears -998.

## Overlay Layer Map

| Layer | Name / Purpose | Created By |
|---|---|---|
| **PSP_WEAPON (1)** | Main weapon display | Engine / weapon states |
| **PSP_FLASH (2)** | Muzzle flash / FlashPunching | Fire states / melee one-handed |
| **10, 11** | Dual-wield left/right overlays | Akimbo weapons |
| **-777** | `Melee_Equipment_Handler_Overlay` | `PB_WeaponRaise` |
| **-778** | `KickHandler_Overlay` | `PB_WeaponRaise` |
| **-779** | `Equipment_Toggle_Handler_Overlay` | `PB_WeaponRaise` |
| **-998** | **QuickMelee dispatch** (BUG SOURCE) | Handler at -777 |
| **-999** | `DoKick` dispatch | Handler at -778 |
| **-1000** | `FirstPersonLegsStand` / leg sprites | `PB_WeaponRaise`, `A_LegOverlay` |

## Fix Applied (3 parts)

### 1. Primary Fix: Redirect melee to PSP_WEAPON, destroy -998

**File:** `zscript/Weapons/BaseWeapon_MeleeSystem.zs`

`GoMeleeInstead` was restructured to redirect the melee flow from layer -998 onto `PSP_WEAPON`, then immediately destroy -998:

```
GoMeleeInstead:
    TNT1 A 0 {
        // ... zoom/roll/leg overlay cleanup ...
        A_LegOverlay(-1000, "FirstPersonLegsStand");
        A_OverlayFlags(-1000, PSPF_ADDWEAPON|PSPF_ADDBOB, False);
        A_Overlay(PSP_WEAPON, "MeleeDispatch");
        A_OverlayOffset(PSP_WEAPON, 0, 32);
    }
    Stop; // Destroy layer -998
```

A new `MeleeDispatch` state (running on `PSP_WEAPON`) now contains the melee token checks and dispatches to the appropriate melee animation. After the melee ends and flows to `GoingToReady` → `Ready3`, it's all on `PSP_WEAPON` — no orphaned overlay.

**How it works:**

1. Handler (-777) creates -998 with `QuickMelee`.
2. `QuickMelee` (on -998) does pre-checks, `PB_Execute()`, then falls through to `GoMeleeInstead`.
3. `GoMeleeInstead` (on -998) calls `A_Overlay(PSP_WEAPON, "MeleeDispatch")` to redirect the melee onto PSP_WEAPON.
4. `Stop;` destroys layer -998.
5. `MeleeDispatch` (on PSP_WEAPON) dispatches to the appropriate melee animation state.
6. Melee animation → `GoingToReady` → `Ready3`, all on PSP_WEAPON. No ghost layer.

### 2. Safety Net: GoingToReady override clears -998

**File:** `zscript/Weapons/BaseWeapon_MeleeSystem.zs`

PB Staging's `GoingToReady` / `SelectingAnimation` states (from `BaseWeapon.zc`) are overridden in PBWP to add `-998` to the overlay clear range. This catches **weapon-specific `GoMeleeInstead` overrides** (DemonicExterminator, BeamKatana, BattleAxeAndShield, ArgentSith) that still run their melee animation on layer -998.

The clear is placed at the **end** of the `SelectingAnimation` code block:

```
SelectingAnimation:
    TNT1 A 0 {
        // ... all cleanup logic first ...
        PB_SetUsingMelee(false);
        PB_SetUsingEquipment(false);
        PB_SetExecutingEnemy(false);
        A_ClearReFire();
        A_ClearOverlays(-999, -998);  // was (-999, -999) — now also clears -998
    }
```

**Why at the end:** If `GoingToReady` is running on layer -998 itself (from a weapon-specific override), `A_ClearOverlays(-999, -998)` sets -998's state to null. Code *within the same anonymous function* (the `{ }` block) still executes to completion — so `PB_SetUsingMelee(false)` and other cleanup runs before -998 is destroyed. But subsequent state frames (the `A_Jump` to `Ready3`) do NOT execute because the state machine sees the null state after the function returns. This is exactly what we want: cleanup runs, but -998 doesn't proceed to `Ready3`.

### 3. Hardening: PB_WeaponRaise clears stale -998 and sets leg overlay flags

**File:** `zscript/Weapons/BaseWeapon_Functions.zsc`

Two defensive changes in `PB_WeaponRaise` (called during weapon select):

```
A_ClearOverlays(-999, -997);  // was (-999, -999) — now clears -998 and -997 too
// ...
A_Overlay(-1000, "FirstPersonLegsStand");
A_OverlayFlags(-1000, PSPF_ADDWEAPON|PSPF_ADDBOB, False);  // NEW — closes 1-frame flag gap
```

- **Expanded clear range:** Catches any stale -998 overlay left from a previous weapon's melee.
- **Immediate PSPF flags:** The `FirstPersonLegsStand` state sets `PSPF_ADDWEAPON|PSPF_ADDBOB` to `False` every frame, but there was a 1-frame gap on the very first frame where the flags hadn't been applied yet. Setting them immediately after overlay creation closes this gap.

## Weapons With Custom GoMeleeInstead (Partially Covered)

These weapons define their own `GoMeleeInstead` and bypass the base class redirect-and-stop fix. They are covered by the `GoingToReady` override (fix #2) which clears -998 when the melee animation returns to ready:

| Weapon | File | Format |
|---|---|---|
| Demonic Exterminator | `zscript/Weapons/Slot-0/DemonicExterminator/DemonicExt.zs` | ZScript |
| Beam Katana | `actors/Weapons/Slot-1/BeamKatana.dec` | DECORATE |
| Battle Axe and Shield | `actors/Weapons/Slot-1/BattleAxeAndShield.dec` | DECORATE |
| Argent Sith | `actors/Weapons/Slot-1/ArgentSith.dec` | DECORATE |

For these weapons, during the melee animation, both PSP_WEAPON (idle) and -998 (melee animation) are visible simultaneously — matching PB Staging's original design where the weapon stays on screen during melee. The `GoingToReady` override ensures -998 is cleaned up when the melee ends, preventing the ghost idle frame from persisting into subsequent actions.

## Kick Overlay Behavior (Layer -999, Not Changed)

Kicks are dispatched to layer **-999** by `KickHandler_Overlay`. The PBWP `DoKick` state (in `BaseWeapon_Melee.zsc`) sets `PSP_WEAPON` to `FlashKicking` (weapon-specific kick sprites for ~15 frames, then `goto Ready3`) or `HideWeaponDuringAction` (fallback). After the kick, -999 is destroyed via `Stop;` at the end of the kick animation. `FlashKicking` naturally returns `PSP_WEAPON` to `Ready3`.

No changes were needed for kicks. Layer -999 is also cleared by the expanded `A_ClearOverlays(-999, -998)` in `SelectingAnimation` and `A_ClearOverlays(-999, -997)` in `PB_WeaponRaise` as a safety net.

## GZDoom/UZDoom Engine Behavior Notes

- **`A_ClearOverlays` never clears `PSP_WEAPON`** (layer 1). It is protected by the engine. Calls to `A_ClearOverlays` that include layer 1 in their range simply skip it.
- **`A_ClearOverlays` on the calling layer:** Sets the PSprite's state to `null`. Code within the *same action function* (anonymous `{ }` block) runs to completion. Subsequent state frames (0-duration or otherwise) are NOT processed because the state machine sees the null state after the function returns. The PSprite is cleaned up on the next tic.
- **`A_Overlay(PSP_WEAPON, "State")`** works from any layer — it always modifies `PSP_WEAPON`, not the calling layer.
- **`A_WeaponReady()`** always processes input for `PSP_WEAPON` regardless of which overlay layer calls it.
- **`PSPF_ADDWEAPON`** controls whether an overlay's position is relative to `PSP_WEAPON`'s position. Default is `true`. Set to `false` for overlays that should be independently positioned (legs, kicks).
- **`PSPF_ADDBOB`** controls whether weapon bob affects the overlay. Default is `true`. Set to `false` for legs, kicks.
