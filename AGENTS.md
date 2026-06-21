# AGENTS.md — Project Brutality Weapons Pack (PBWP)

## Project Overview

This is a weapons add-on package for **Project Brutality** (PB), a gameplay mod for classic Doom running on the **UZDoom/GZDoom** source ports. The pack adds 75+ weapons across all 10 weapon slots (0–9), along with systems like champion enemies, killstreaks, damage indicators, a melee weapon wheel, equipment gadgets, and more.

**Upstream source:** [RENEGADE-ANDROiD/Project-Brutality-Weapons-Pack](https://github.com/RENEGADE-ANDROiD/Project-Brutality-Weapons-Pack) (main branch). This local copy has been modified for PB Staging compatibility — see `CHANGELOG.md` for a complete diff summary.

**Required dependency:** [Project Brutality Staging branch](https://github.com/pa1nki113r/Project_Brutality/tree/PB_Staging)

**Engine target:** UZDoom/GZDoom — ZScript version `4.14.2` (declared in `ZSCRIPT.zc`)

**Load order:** Map WAD → Project Brutality Staging → PB Weapons Pack (loaded last)

**Local reference:** The latest PB Staging branch source is kept in a root-level folder `PB_Staging/` for human and agentic reference only. It is not part of this add-on project — do not package it or treat it as PBWP source unless explicitly directed.

---

## Authoritative References

When evaluating or modifying ZScript, DECORATE, or engine-level code, consult these sources:

| Topic | URL |
|---|---|
| ZScript reference (primary) | <https://github.com/zdoom-docs/stable> |
| UZDoom source (engine context) | <https://github.com/UZDoom/UZDoom/tree/4.14.3> |
| DECORATE format specifications | <https://zdoom.org/w/index.php?title=DECORATE_format_specifications> |
| Action functions | <https://zdoom.org/w/index.php?title=Action_functions> |
| Classes | <https://zdoom.org/w/index.php?title=Classes> |
| Actor flags | <https://zdoom.org/w/index.php?title=Actor_flags> |
| Actor properties | <https://zdoom.org/w/index.php?title=Actor_properties> |
| Actor states | <https://zdoom.org/w/index.php?title=Actor_states> |
| DECORATE expressions | <https://zdoom.org/w/index.php?title=DECORATE_expressions> |

---

## Directory Structure

```
Project-Brutality-Weapons-Pack-main/
├── ZSCRIPT.zc                          # Main entry point — all #include directives
├── README.md                           # Load order, weapon list, credits
├── AGENTS.md                           # This file
├── CHANGELOG.md                        # Diff summary vs upstream repo
├── zscript/                            # ZScript source code
│   ├── WEAPON_TEMPLATE.zs              # Canonical template for new addon weapons
│   ├── Ouchie.zs                       # Misc gameplay feature
│   ├── DisableCustomMelee.dec          # DECORATE — custom melee disable logic
│   ├── Weapons/                        # Weapon definitions by slot
│   │   ├── BaseWeapon_Functions.zsc    # extend class PB_WeaponBase — core helper functions + local stubs
│   │   ├── BaseWeapon_Melee.zsc       # extend class — melee/kick system (uses A_LegOverlay)
│   │   ├── BaseWeapon_Equipment.zsc   # extend class — equipment handling
│   │   ├── BaseWeapon_PBWP.zs         # extend class — PBWP extensions, UnloaderToken, PB_ExecuteGK stub
│   │   ├── BaseWeapon_GKCompat.zs     # extend class — GloryKill compat (DISABLED — include commented out)
│   │   ├── BaseWeapon_MonsterPackCompat.zs # extend class — monster pack compat
│   │   ├── BaseWeapon_MeleeSystem.zs  # extend class — melee weapon system
│   │   ├── BaseWeapon_MeleeAnimations.zs # extend class — melee animations
│   │   ├── BaseWeapon_EquipmentAnims.zs  # extend class — equipment animations
│   │   ├── PBWP_BulletSystem.zc       # Casing/bullet system
│   │   ├── Slot-0/                    # Slot 0 weapons (Demonic Exterminator, etc.)
│   │   ├── Slot-3/                    # Slot 3 weapons (CSSG, etc.)
│   │   ├── Slot-4/                    # Slot 4 weapons (M41A, HeavySniperRifle)
│   │   ├── Slot-5/                    # Slot 5 weapons (NeoHMG)
│   │   ├── Slot-6/                    # Slot 6 weapons (Excavator)
│   │   └── Slot-8/                    # Slot 8 weapons (CalamityBlade variants)
│   ├── PBWP_Core/                     # Core systems
│   │   ├── BeefHandler.zs             # Event handler
│   │   ├── BeefCore.zs                # Spawner base classes, PBWP_Spawner, PBWP_ComplexAmmo
│   │   ├── BeefJMod.zs               # Misc modifications
│   │   ├── BeefTokens.zs             # Inventory tokens
│   │   └── PBWP_Projectiles.zs       # Projectile definitions
│   ├── PBWP_Systems/                  # Major gameplay systems
│   │   ├── Champions/                 # Champion enemy variants (17 color types)
│   │   ├── Killstreak/               # Kill streak tracking and rewards
│   │   ├── Random Weapon Switcher/   # Randomized weapon switching
│   │   ├── Doorbuster/               # Door-busting mechanic
│   │   ├── Magnets/                  # Item magnet system
│   │   ├── HelmetDrops/              # Zombie helmet drop system
│   │   └── DmgIndicatorV2/           # Visual damage feedback
│   ├── PBWP_Spawners/                # Weapon, item, and monster spawners
│   ├── PBWP_Misc/                    # Power-ups, bosses, weapon wheels
│   ├── Player/                        # Player class extensions
│   ├── gearbox/                       # Equipment and melee wheel menus
│   ├── Insanity's Nightmare/         # IN weapon pack code
│   └── Scientist/                    # Blood sample / scientist systems
├── actors/                            # DECORATE actor definitions (.dec files)
│   ├── Weapons/                       # Weapon actors by slot and category
│   │   ├── Slot-1/                    # Slot 1 weapons (BeamKatana, BattleAxeAndShield*, ArgentSith*)
│   │   ├── Slot-2/ through Slot-6/   # Per-slot weapon definitions (from upstream)
│   │   ├── Slot-7/                    # Slot 7 weapons (Gauss*) — local addition, not in upstream
│   │   ├── Slot-8/                    # Slot 8 weapons (PlasmaRifle*, Extinction_Ray) — local addition
│   │   ├── Slot-9/                    # Slot 9 weapons
│   │   ├── Special/                   # Special projectiles, tokens, effects
│   │   ├── FX/                       # Visual effects (casings, smoke, flares)
│   │   ├── Doom4WeaponPack/          # Doom 2016-style weapons
│   │   ├── GodComplex/               # God Complex tier weapons
│   │   └── Grenades/                 # Grenade definitions
│   ├── Equipments/                    # Equipment actors (hooks, shurikens, etc.)
│   ├── CustomMelee/                   # Melee weapon actors
│   ├── Entities/                      # Health, armor, shell, pickup actors
│   ├── Monsters/                      # Custom monster actors
│   ├── Effects/                       # Visual effect actors
│   ├── Spawners/                      # DECORATE-based spawner actors
│   └── Items/                         # Item/power-up actors
├── CREDITS/                           # Per-feature credit .txt files
├── TextColours*.txt                   # Text color definitions
├── TRNSLATE.txt                       # Translation tables
└── PB_Staging/                        # [NOT PART OF PROJECT] Local reference copy of PB Staging source — do not include in pk3

(* = file added locally, not present in upstream repo. PB_Staging/ = local reference only, not part of the add-on or pk3.)
```

---

## PB Staging Compatibility

This codebase has been patched for compatibility with PB Staging's breaking API changes. Future agents must be aware of these differences from the upstream source. See `CHANGELOG.md` for the full diff.

### API Changes Applied

| Area | Old (upstream/broken) | Current (patched) | Why |
|---|---|---|---|
| `PB_Execute()` | `action void` | `action state`, returns `resolveState(null)` | ~100 call sites do `return PB_Execute()` expecting a state return |
| `PB_SpawnCasing()` | `class casing` | `class<Actor> casing` | UZDoom 4.14.x `Spawn()` returns `Object` for untyped `class` |
| `PB_UnloadMag()` | `class AmmoMag_Action, class AmmoPool_Action, ... class spawnActor` | `class<Inventory> ..., class<Actor> spawnActor` | Same typed-class requirement |
| `PB_TakeAmmo()` | `class ammoType` | `class<Inventory> ammoType` | Same typed-class requirement |
| `PB_CheckReload()` | 5 parameters | 7 parameters (3 leading nulls added) | PB Staging expanded the signature |
| Leg overlays | `A_Overlay(-10, "FirstPersonLegs...")` | `A_LegOverlay(-1000, "FirstPersonLegs...")` | PB Staging replaced the overlay system |

### Local Stub Definitions

These were removed from PB Staging but are still referenced by PBWP code. Stubs are defined at the end of `BaseWeapon_Functions.zsc`:

| Stub | Type | Purpose |
|---|---|---|
| `PB_VisualRailBlue(int dummy = 0)` | Action function | Wraps `PB_LightVisualRail()` — used by Gauss, PlasmaRifle |
| `PB_VisualRailRed(int dummy = 0)` | Action function | Wraps `PB_LightVisualRail()` — used by Extinction_Ray |
| `LaserSightActivated` | `Inventory` class | Referenced by `gearbox/pb/tokens.zs` |
| `HasLeech` | `Inventory` class | Referenced by `BaseWeapon_Equipment.zsc` |
| `ThrownStunGrenade` | `Actor` class | Referenced by `BaseWeapon_EquipmentAnims.zs` |

### Local Property/Function Re-declarations

These were removed from `PB_WeaponBase` in PB Staging, so PBWP re-declares them in `BaseWeapon_PBWP.zs`:

- `string UnloaderToken` + `property UnloaderToken : UnloaderToken` — weapon unload tracking
- `action state PB_ExecuteGK()` — stub that delegates to `PB_Execute()`. The full implementation in `BaseWeapon_GKCompat.zs` is currently disabled (its `#include` is commented out in `BaseWeapon_PBWP.zs` line 3).

### When Adding New Weapons

All new weapons must use the **current** API signatures:
- Use `A_LegOverlay(-1000, ...)` for leg sprites, never `A_Overlay(-10, ...)`
- `PB_CheckReload` takes 7 parameters — pass `null` for the first 3 if not needed
- `PB_Execute()` returns `state` — `return PB_Execute();` is valid in both ZScript and DECORATE
- Function parameters accepting actor/inventory classes must be typed: `class<Actor>` or `class<Inventory>`, never bare `class`

---

## Code Languages and Formats

The codebase uses two actor definition formats, both targeting the ZDoom engine:

### ZScript (`.zs`, `.zsc`, `.zc`)
- The preferred and more capable format — supports full classes, functions, variables, enums, and proper OOP.
- All new weapons and systems should be written in ZScript.
- Entry point: `ZSCRIPT.zc` uses `#include` directives to pull in all modules.
- Extension pattern: `extend class PB_WeaponBase` adds methods to the PB base weapon class without modifying PB source.

### DECORATE (`.dec`)
- Legacy format still used for many weapons, effects, items, and spawners in the `actors/` directory.
- Uses the `ACTOR ClassName : ParentClass { ... }` syntax.
- Action functions are called inline within state definitions.
- DECORATE actors use `A_JumpIfInventory` token checks; ZScript actors prefer `if`/`switch` logic and class variables.

Both formats can coexist and interoperate — a DECORATE actor can inherit from a ZScript class and vice versa.

---

## Class Hierarchy

All weapons in this pack inherit from Project Brutality's base weapon class:

```
Actor (engine)
 └── Inventory
      └── Weapon
           └── PB_WeaponBase (from PB — primary base class)
                ├── PB_AddonWeapon (WEAPON_TEMPLATE.zs — reference template)
                ├── M41A, PB_CSSG, PB_DemonExt, etc. (ZScript weapons)
                └── 44PDW, D2016Shotgun, etc. (DECORATE weapons)
```

Other key base classes from PB used by this pack:
- `PB_Projectile` — base for all PB-compatible projectiles
- `PB_PlayerPrawn` / `PlayerPawnBase` — player pawn class
- `PB_SpawnerBase` → `PBWP_Spawner` — weapon/item spawner base
- `PB_Ammo` → `PBWP_ComplexAmmo` — custom ammo definitions
- `BaseStatusBar` → `PB_Hud_ZS` — HUD rendering

---

## Weapon Architecture

### Creating a New Weapon

Use `zscript/WEAPON_TEMPLATE.zs` as the canonical reference. A weapon must:

1. **Extend `PB_WeaponBase`** (the PB base, not Doom's `Weapon`).
2. **Set `default` properties:**
   - `weapon.slotnumber` — slot 0–9
   - `weapon.ammotype1` — reserve ammo pool (PB ammo class)
   - `weapon.ammotype2` — loaded/magazine ammo
   - `PB_WeaponBase.unloadertoken` — token for unloaded state
   - `PB_WeaponBase.respectItem` — token for first-pickup respect animation
   - `PB_WeaponBase.DualWieldToken` — token for dual-wield support (if applicable)
   - `Tag`, `inventory.pickupmessage`, `inventory.pickupsound`
3. **Define required states:**
   - `Spawn` — world pickup sprite
   - `Select` → call `PB_WeaponRaise()`, `PB_WeapTokenSwitch()`, `PB_RespectIfNeeded()`
   - `SelectContinue` / `SelectAnimation` — raise animation
   - `Deselect` — lower animation ending with `A_Lower(120); wait;`
   - `Ready` / `Ready3` — main ready loop calling `A_DoPBWeaponAction()`
   - `Fire` / `AltFire` — attack states
   - `Reload` — reload logic using `PB_checkReload()` and `PB_AmmoIntoMag()`
   - `Unload` — unload logic using `PB_UnloadMag()`
   - `Weaponspecial` — weapon-special-key handler
   - `FlashPunching` (14 frames), `FlashKicking` (15 frames), `FlashAirKicking` (16 frames), `FlashSlideKicking` (27 frames), `FlashSlideKickingStop` (7 frames) — required for melee/kick integration
   - `LoadSprites` — force-load any sprites set via `GetSpriteIndex()`

### PB Ammo Types

Weapons use PB's ammo pool classes as `ammotype1` (reserve):
- `PB_LowCalMag` — pistols, SMGs
- `PB_HighCalMag` — rifles, DMRs
- `PB_Shell` — shotguns
- `PB_RocketAmmo` — rockets/explosives
- `PB_Cell` — plasma/energy
- `PB_Fuel` — fuel-based weapons
- `PB_DTech` — demonic tech / soul charges

Magazine ammo is defined as a custom `Ammo` subclass per weapon (e.g., `M41AChamberAmmo`).

---

## Key Functions (from `extend class PB_WeaponBase`)

These are available to all weapons via the `BaseWeapon_*.zsc` extension files:

| Function | Purpose |
|---|---|
| `A_DoPBWeaponAction(weapflags, pbFlags, unloadtoken, noReload)` | Main ready-state handler — replaces `A_WeaponReady()`. Handles barrels, kicks, equipment, executions, unloading, and reload checks. |
| `PB_WeaponRaise(upSnd)` | Select-state initialization — clears overlays, resets tokens, sets up leg overlays. |
| `PB_WeapTokenSwitch(wepToken)` | Clears all weapon-selected tokens and sets the given one. Required for PB monster death animations. |
| `PB_RespectIfNeeded()` | Handles first-pickup helmet/respect animations. |
| `PB_WeaponRecoil(pitchDelta, angleDelta, powerMod)` | Applies recoil with bracing and berserk modifiers. |
| `PB_FireBullets(type, amount, angle, offs, height, pitch)` | Fires projectile-based hitscan with PB spread/crouchfactor. |
| `PB_SpawnCasing(class<Actor> casing, xOfs, horOfs, vertOfs, ...)` | Spawns ejected casing with optional smoke and sparks. |
| `PB_GunSmoke(d1, d2, d3, SActor)` | Spawns muzzle smoke with CVar-based quality settings. Variants: `_Deagle`, `_Sniper`, `_FlashHider`, `_Compensator`, `_Launcher`. |
| `PB_MuzzleFlashEffects(d1, d2, d3, col, sparks, light, rad, tics)` | Spawns muzzle flash light and spark particles. |
| `PB_AmmoIntoMag(mag, pool, maxFill, takeReserve, giveMag)` | Transfers ammo from reserve pool into magazine. |
| `PB_UnloadMag(class<Inventory> mag, class<Inventory> pool, giveReserve, takeMag, maxSize, goal, class<Actor> spawnActor)` | Transfers ammo from magazine back to reserve. Excess ammo is dropped as world items. |
| `PB_TakeAmmo(class<Inventory> ammoType, takeNum, emptyMag, emptyChamber, dual)` | Takes ammo and updates empty-mag/chamber flags. |
| `PB_CheckReload(null, null, null, emptyReload, fullAlready, noAmmo, full, equal)` | Pre-reload validation — 7 params; first 3 are typically `null`. |
| `PB_jumpIfNoAmmo(reloadstate, min, secondary)` | Jumps to reload if magazine is empty. |
| `PB_jumpIfHasBarrel(nukage, flame, ice)` | Redirects to barrel throw/place states if player is holding a barrel. |
| `PB_Execute()` → `action state` | Fatality/execution system — checks range, health threshold, dispatches to per-monster execution states. Returns `resolveState(null)`. |
| `PB_ExecuteGK()` → `action state` | GloryKill-compatible execution. Currently a stub delegating to `PB_Execute()`. |
| `FiretoExecute()` → `action state` | Entry point for fire-to-execute — branches between `PB_Execute()` and `PB_ExecuteGK()`. |
| `PB_QuakeCamera(qDur, camRoll)` | Camera shake effect. |
| `PB_LightVisualRail(...)` | Draws particle-based rail/beam visuals with hitscan damage. |
| `PB_VisualRailBlue(int dummy = 0)` | Local stub — wraps `PB_LightVisualRail()` with blue color presets. |
| `PB_VisualRailRed(int dummy = 0)` | Local stub — wraps `PB_LightVisualRail()` with red color presets. |
| `A_LegOverlay(layer, state)` | PB Staging leg overlay — replaces old `A_Overlay(-10, ...)`. Use layer `-1000`. |
| `PB_FireOffset(interp)` | Exaggerated visual recoil (CVar-controlled). |
| `PB_DynamicTail(tailInside, tailOutside)` | Plays interior/exterior gunshot tail sounds based on environment geometry. |
| `PB_GunShot(shotSound, mechSound, tailInside, tailOutside, ...)` | Combined shot sound + mech sound + tail + low-ammo warning. |
| `PressingFire()`, `PressingAltfire()`, `PressingReload()` | Input helper booleans. |
| `JustPressed(which)`, `JustReleased(which)`, `IsHoldingInput(which)` | Edge/hold input detection. |

---

## State Machine Conventions

PB weapons do not use the standard `Ready` state as a true idle. The typical flow:

```
Select → SelectFirstPersonLegs → SelectContinue → SelectAnimation → Ready/Ready3
```

- `Ready` / `Ready3`: Main idle loop. Always calls `A_DoPBWeaponAction()`.
- `Fire`: Check barrels first (`PB_jumpIfHasBarrel`), then check execution (`PB_Execute`), then fire logic.
- `AltFire`: Secondary fire mode — often mode-dependent via `invoker.SecondaryFire` bool or `invoker.specialmode` int/enum.
- `Reload`: Use `PB_checkReload()` at entry, `PB_AmmoIntoMag()` for the transfer.
- `Unload`: Take `"Unloading"` token, use `PB_UnloadMag()`.
- `Deselect`: Animation frames → `A_Lower(120); wait;`

Use `invoker.` prefix to access weapon-class variables from action functions.

---

## Token-Based State Management

PB uses inventory tokens extensively for cross-system communication:

- **Weapon selection tokens** (`SSGSelected`, `RifleSelected`, `AddonSelected`, etc.) — set via `PB_WeapTokenSwitch()`, control monster death animations.
- **Unloader tokens** (per weapon, e.g., `M41AUnloaded`) — track whether a weapon has been unloaded.
- **Respect tokens** (per weapon, e.g., `M41ARespect`) — prevent repeat first-pickup animations.
- **Dual-wield tokens** (per weapon, e.g., `M41ADueling`) — enable akimbo mode.
- **Barrel tokens** (`GrabbedBarrel`, `GrabbedFlameBarrel`, `GrabbedIceBarrel`) — barrel carrying state.
- **System tokens** (`ExecutionToken`, `Kicking`, `Zoomed`, `CantDoAction`, etc.) — global state flags.

Prefer ZScript class variables (`bool`, `int`, `enum`) over tokens for new weapon-internal state. Use tokens only for cross-system interop where PB expects them.

---

## Coding Conventions

- **Class naming:** `PB_` prefix for classes integrating with PB systems. Descriptive PascalCase names.
- **Function naming:** `PB_` prefix for PB-compatible action functions. Helper utilities use `A_` prefix.
- **File extensions:** `.zs` for new ZScript, `.zsc` for compiled/extension files, `.zc` for entry/include files, `.dec` for DECORATE.
- **Indentation:** Tabs throughout. Mixed brace styles exist — prefer opening brace on same line for new code.
- **State labels:** Standard Doom convention — `Spawn`, `Ready`, `Fire`, `AltFire`, `Reload`, `Deselect`, `Select`, plus PB-specific labels.
- **Sprite naming:** 4-character names (e.g., `PMAW`, `PMAF`, `44PF`), frame letters A–Z, rotation digits 0–8.
- **Sound naming:** Path-based strings like `"weapons/cssg/in"`, `"M41A/PickUp"`.
- **Comments:** Functional comments explaining intent are valued. Author credits appear as `//[Name]` or `// by Name`.

---

## Systems Overview

| System | Location | Description |
|---|---|---|
| Champions | `PBWP_Systems/Champions/` | 17 color-variant enemy mutations with special abilities |
| Killstreak | `PBWP_Systems/Killstreak/` | Kill tracking with power-up rewards |
| Random Weapon Switcher | `PBWP_Systems/Random Weapon Switcher/` | Timed random weapon changes |
| Doorbuster | `PBWP_Systems/Doorbuster/` | Destructible doors from Brutal Doom Platinum |
| Magnets | `PBWP_Systems/Magnets/` | Item magnet with purchasable upgrades |
| Helmet Drops | `PBWP_Systems/HelmetDrops/` | Zombie helmet drop spawners |
| Damage Indicators V2 | `PBWP_Systems/DmgIndicatorV2/` | Directional damage feedback |
| Equipment/Melee Wheel | `gearbox/` | Equipment selection and melee weapon wheel UI |
| Weapon Spawners | `PBWP_Spawners/` | Configurable weapon/item/monster spawners |
| Scientist | `Scientist/` | Blood sample collection system |

---

## Build and Packaging

- There is no build script. The source directory structure is the pk3 layout.
- To package: zip the project root contents into a `.pk3` file (or load the directory directly in UZDoom/GZDoom). **Exclude `PB_Staging/`** — it is local reference only, not part of the add-on or compile scope.
- `ZSCRIPT.zc` is the engine entry point — all code must be reachable via its `#include` chain.
- New files must be added to `ZSCRIPT.zc` with an `#include` directive to be compiled.

---

## Common Pitfalls

- **Missing `#include`:** Adding a new `.zs` file without adding it to `ZSCRIPT.zc` will cause it to be silently ignored.
- **Token cleanup:** New weapons must clear all relevant tokens in `PB_WeapTokenSwitch()` or rely on the existing call to it during `Select`.
- **Flash states:** The `FlashPunching`, `FlashKicking`, `FlashAirKicking`, `FlashSlideKicking`, and `FlashSlideKickingStop` states are mandatory for melee/kick interop, even if the weapon doesn't have melee.
- **Ammo duality:** `ammotype1` is the reserve pool (shared across weapons), `ammotype2` is the per-weapon magazine. Getting this backwards will break reload logic.
- **DECORATE vs ZScript syntax:** DECORATE uses `A_JumpIfInventory("Token", 1, "State")` while ZScript uses `if(CountInv("Token") >= 1) return ResolveState("State");`. Do not mix syntaxes within a single actor definition.
- **`invoker.` prefix:** In ZScript action functions, weapon-class members must be accessed via `invoker.` — bare references will resolve against the player pawn (the calling actor).
- **Leg overlays:** Always use `A_LegOverlay(-1000, ...)`, never `A_Overlay(-10, ...)`. The old API was removed in PB Staging. After setting a leg overlay, add `A_OverlayFlags(-1000, PSPF_ADDWEAPON|PSPF_ADDBOB, False)` where needed.
- **Typed class parameters:** Function parameters accepting classes must use `class<Actor>` or `class<Inventory>`, not bare `class`. UZDoom 4.14.x returns `Object` from `Spawn()` when given untyped `class`, causing type conversion errors.
- **`PB_CheckReload` signature:** Takes 7 parameters now. The first 3 are typically `null`. Old 5-parameter calls will fail.
- **GKCompat is disabled:** `BaseWeapon_GKCompat.zs` exists but its `#include` is commented out in `BaseWeapon_PBWP.zs` (line 3). `PB_ExecuteGK()` is provided as a stub in `BaseWeapon_PBWP.zs` instead. Do not uncomment the GKCompat include without verifying it compiles.
- **Stub classes are local:** `LaserSightActivated`, `HasLeech`, and `ThrownStunGrenade` are minimal stubs defined at the end of `BaseWeapon_Functions.zsc`. They exist solely to satisfy references — they have no real behavior. If PB Staging re-adds these classes, the stubs should be removed to avoid duplicate definitions.
- **`PB_VisualRailBlue`/`PB_VisualRailRed` are stubs:** These are local replacements appended to `BaseWeapon_Functions.zsc`. Both currently use identical `PB_LightVisualRail()` parameters (no actual color differentiation). If color-specific behavior is needed, the stub implementations must be updated.
- **Case sensitivity in ZScript:** ZScript is case-sensitive. There is a known issue in `PB_UnloadMag` where `maxsize` (lowercase) is used on lines 1828–1829 instead of the parameter name `maxSize`. Be careful with casing when referencing parameters.
- **Lump-path collisions with PB Staging:** PBWP overrides three PB Staging files by having identically-pathed files that the engine loads instead (last pk3 wins). When PB Staging adds new functions or changes logic in any of these files, those changes must be manually synced into PBWP's copies or the add-on will fail to load. The colliding files are: `zscript/Weapons/BaseWeapon_Functions.zsc`, `zscript/Weapons/BaseWeapon_Melee.zsc`, `zscript/Weapons/BaseWeapon_Equipment.zsc`. These overrides exist because PBWP needed to patch API signatures and add extension code that chains into PBWP-specific includes.
