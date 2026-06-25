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

---

## Cyberaugumented Weapon Fold (PBWP)

Ten slot-4–9 weapons folded from the Cyberaugumented pk7 (`DCY_*` sources) live under `zscript/PBWP_Weapons/Cyberaugumented/`. All extend `PBWP_CA_WeaponBase` (in `PBWP_CA_Common.zs`), which extends `PB_WeaponBase`.

| Class | Slot | Ammo model | Source |
|---|---|---|---|
| `PBWP_Warbringer` | 4 | `PB_HighCalMag` → `PBWP_WarbringerMag` (20) | DCY_Cyberrifle |
| `PBWP_Nightfall` | 5 | `PB_HighCalMag` → `PBWP_NightfallMag` (200) | DCY_Minigun |
| `PBWP_Intervention` | 6 | `PB_RocketAmmo` direct | DCY_Grenades |
| `PBWP_Caduceus` | 6 | `PB_Cell` → `PBWP_CaduceusMag` (60) | DCY_NeonicWand |
| `PBWP_Dispatcher` | 6 | `PB_Cell` direct | DCY_RehauledPlasmaRifle |
| `PBWP_AmnesiaProtonPhaser` | 7 | `PB_Cell` ×40 per shot | DCY_TheBFG9000 |
| `PBWP_Liquidation` | 7 | `PB_Cell` direct (hold beam) | DCY_TheBFG10000 |
| `PBWP_Deracinator` | 8 | `PB_Cell` ×5 per shot | DCY slot-8 BFG |
| `PBWP_Dismantler` | 8 | `PB_DTech` → `PBWP_DismantlerMag` (100) | DCY_VeneratedTruncheon |
| `PBWP_CinerealOrdnance` | 9 | `PB_DTech` → `PBWP_CinerealMag` (100) | DCY_TheCinerealOrdnance |

Shared projectiles / FX: `PBWP_CA_Projectiles.zs`. Magazine actors: `actors/Weapons/Cyberaugumented/CyberaugumentedAmmo.dec`.

### Sprite layout (`SPRITES/WEAPONS/Cyberaugumented/`)

**Do not use loose `_Shared/` or `_Patches/` folders.** Each weapon has a PascalCase subfolder matching its class name (e.g. `Warbringer/`, `Dispatcher/`). Rules:

- Weapon view/pickup/projectile PNGs for a weapon go in that weapon’s subfolder (lump name unchanged — GZDoom resolves by filename, not path).
- Cross-weapon lumps (`TRAC`, `PUFF`, `PBAL`) come from PB Staging / `PBWP_ProjectileFamilies.dec` — do not duplicate in CA folders.
- `_Common/FX/` holds **selective** upstream projectile/explosion sprites (M_TR, KABE, EF1_, BF3X, MNAD, etc.) imported via `tools/Import-CA-FX-Sprites.ps1`. Hybrid FX logic lives in `PBWP_CA_Projectiles.zs` (upstream sprites + PB particles/HitSpark/RocketExplosion).
- `_Common/ModImport/` is a **temporary** pk7 overflow only. After import, run `tools/Trim-CA-Common.ps1` to move still-needed patch sources into weapon folders and delete duplicates/orphans. Do not ship a full ModImport dump in releases.
- Cross-reference upstream vs PBWP FX: `tools/Audit-CA-FX.ps1` → `tools/ca_fx_audit.txt`.
- When consolidating, **prefer the file already in the weapon subfolder** over a duplicate in a loose folder (delete the duplicate).
- First-person composites for many CA weapons are still defined in `TEXTURES.PBWP` (patch layers); loose PNGs are patch sources only.

Re-run `tools/Consolidate-CA-Sprites.ps1` after bulk sprite imports, then `tools/Trim-CA-Common.ps1` to drop duplicate/orphan ModImport lumps. After trimming, run `tools/Import-CA-FX-Sprites.ps1` if weapon FX sprites need restoring from pk7.

### Mag + reserve reload pattern (required for CA mag weapons)

Do **not** rely on `PB_CheckReload()` alone for mag-fed CA weapons — `chamberEmpty` defaults false and reload silently fails.

1. Fire gate: `return PB_jumpIfNoAmmo("Reload", min);` (or a custom count check for burst costs).
2. Ammo take: `PB_TakeAmmo("PBWP_*Mag", n, 0, 0)` — not bare `A_TakeInventory` on the mag.
3. `Reload` state (must be named **`Reload`**, not `ReloadMag`): Fusil-style checks then animated `DoReload`:
   - If mag ≥ max → `Ready3`
   - If reserve < 1 → `Ready3`
   - Else → `DoReload` with weapon sprite frames + reload sounds → `PB_AmmoIntoMag(...)` then `PB_SetChamberEmpty(false)`, `PB_SetMagEmpty(false)`, and `PB_SetMagUnloaded(false)`.
   - Use `PBWP_CA_ReloadPreamble()` at reload entry; `PB_JumpIfMagUnloaded("MagIn")` before clip eject when applicable.
4. Set `Inventory.AltHudIcon` to the pickup sprite; add HUD offsets in `PBWP_AddonWeaponHud.zs` if needed.

Spawners / toggles: `zscript/PBWP_Spawners/PBWP_FoldedWeaponSpawners.zs`, `CVARINFO` (`PBSpawnPBWP_*`), `PBWP_WeaponPackPresets.SetCyberaugumented()`.

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

## PB Staging Fire-State Standards

All PBWP ballistic firearms should use PB Staging helper calls in **fire states** (and bolt/chamber casing eject frames) instead of legacy missile spawners. Apply these **per weapon** when touching a file — do not batch-replace across the roster without reading each weapon's offsets and fire modes.

Reference implementations: `AK-47.dec`, `AssaultRifle.dec`, `LiTRevolver.dec`, `D2016SHOTGUN.dec`, `Demon_Murderer.dec`.

### Migration map (legacy → PB)

| Legacy call | PB replacement | Notes |
|---|---|---|
| `A_FireCustomMissile("GunFireSmoke", 0, 0, hor, vert, …)` | `PB_GunSmoke(0, hor, vert)` | Params 4–5 of the missile call map to `d2`/`d3`. Respects `pb_gunsmoketype` CVar and FX throttle. |
| `A_FireCustomMissile("GunSmokeSpawner", …)` | `PB_GunSmoke(0, hor, vert)` | Same as GunFireSmoke. |
| `A_FireCustomMissile("Doom4WeaponPackGunFireSmoke", …)` | `PB_GunSmoke(0, hor, vert)` | D4 pack primary fire only. |
| `A_FireCustomMissile("RifleCaseSpawn", …)` / `RifleCaseSpawnLeft` | `PB_SpawnCasing("PB_EmptyBrass", 32, hor, vert, frandom(4,7), frandom(6,9), frandom(0,5))` | Use hor/vert from missile args 4–5. OK on bolt-cycle frames (Kar98k pattern). |
| `PistolCasingSpawner` / `Mp40CaseSpawnLeft` / `MP40CaseSpawn` | `PB_SpawnCasing("PB_EmptyBrass", 28, hor, 28, …)` | Pistols: `hor=-2`, speeds `frandom(-6,-3)` for left eject. Dual pistols: mirror hor (±3/±10). |
| `SMGCasingSpawner` / `EmptyCaseSpawn` | `PB_SpawnCasing("PB_EmptyBrass", 28, hor, 28, …)` | SMG right eject often `hor=8`, `vert=-14`. |
| `LMGCasingStandard` on LMGs | Keep class or use `PB_SpawnCasing("LMGCasingStandard", …)` | Demon Murderer uses `LMGCasingStandard`; HYDRA/INMinigun use `PB_EmptyBrass`. |
| `ShotgunCasing` | `PB_SpawnCasing("ShotgunCasing", 51, 10, 28.6, …)` | See `D2016SHOTGUN.dec`. |
| `ShakeYourAssMinor` + separate shot sounds | Keep **or** use `PB_GunShot` | See below. |

### Smoke variants

| Variant | When to use |
|---|---|
| `PB_GunSmoke()` | Default pistols, SMGs, rifles, shotguns, miniguns. |
| `PB_GunSmoke_Deagle()` | Magnum handguns (44PDW, THMagnum, heavy revolvers). |
| `PB_GunSmoke_Sniper()` | Bolt rifles, DMRs, snipers (Kar98k, BlackDMR, ChthonicRifle, Fallen Hawk). |
| `PB_GunSmoke_Launcher()` | Rocket/grenade launchers (Duke RPG already uses this). |
| `PB_GunSmoke_Compensator()` | Compensated/ ported barrels (rare in PBWP). |

Do **not** replace `SmokeSpawner` / `SmokeSpawner11` on **reload animation** frames (`####` templated poses, shell-insert puffs) unless they are clearly muzzle fire on the same frame as `PB_FireBullets`.

### Required fire-state checklist (ballistic weapons)

On every `Fire` path that calls `PB_FireBullets`:

1. **`PB_LowAmmoSoundWarning(type)`** — call on the same tic as fire, **before** ammo is taken if possible.
   - Types: `"pistol"`, `"smg"`, `"hdmr"`, `"Shotgun"`, `"sniper"`, `"revolver"`.
   - Belt-fed / no mag actor: pass reserve class as 2nd arg, e.g. `PB_LowAmmoSoundWarning(hdmr, "PB_HighCalMag")`.
   - Dual mag: pass mag class, e.g. `PB_LowAmmoSoundWarning(hdmr, "LeftBlack_Clip")`.
2. **`PB_GunSmoke` or variant** — once per shot (remove duplicate GunFireSmoke on the same frame).
3. **`PB_SpawnCasing`** — when the weapon ejects brass on fire or bolt cycle.
4. **`PB_FireOffset`** — at the start of full-auto / refire loops (rifles, SMGs, LMGs). Already on AK-47, Assault Rifle, ACR.
5. **Keep `A_RailAttack` + `PB_alttracer` branches** — PB_FireBullets handles damage tracers when CVar is off; rail is cosmetic when on.

### `PB_GunShot` — use sparingly

`PB_GunShot(shotSound, mechSound, tailInside, tailOutside, ammoType, …)` combines shot + mechanical + `PB_DynamicTail` + low-ammo warning. **Do not** replace weapons that use:

- Custom multi-channel sound stacks (Duke `FARSHT` + `P3DFIRE`, VietDoom `DistantFireSoundRifle` missiles).
- Unique tail systems not mapped to PB atmo paths (`weapons/atmo/int/*`, `weapons/atmo/ext/*`).

Prefer `PB_GunShot` only when refactoring a weapon that already matches PB Staging's two-sound + tail pattern. Most PBWP addon weapons keep explicit `A_PlaySound` + `PB_LowAmmoSoundWarning` + optional `DistantRifleFireSound`.

### Exemptions (do not force PB_FireBullets helpers)

| Category | Reason |
|---|---|
| `AutoCannon` guided laser | `A_FireBullets` with `GuidedLaser` — not ballistic |
| `DTPISTOL`, energy/plasma weapons firing projectiles | Hellbullet / beam actors, not caliber hitscan |
| `Extinction_Ray` | IN laser projectiles |
| Explosives (RPG, pipebombs, grenade modes) | Not hitscan |
| `MegaRig` | Custom mount `A_FireProjectile("PB_*")` |
| Reload-only decorative smoke | `SmokeSpawner` on insert poses, cooldown steam (`Extinction_Ray ToCompleteCooldown`) |
| Cosmetic-only legacy FX | Karnage `muzzlesmoker` / `muzzlelight` may coexist with `PB_GunSmoke` until individually reviewed |

### Caliber roster

See `zscript/PBWP_Misc/PBWP_FirearmCaliber.zs` for IN/Duke/Karnage → PB caliber maps and exempt weapons.

---

## PB Staging Non-Fire State Standards

Apply these **per weapon** when touching Select / Ready / Reload / Unload — same discipline as the fire-state pass. Reference: `zscript/WEAPON_TEMPLATE.zs`, `zscript/Weapons/Slot-4/Fusil/PB_Fusil.zs`, `zscript/PBWP_Weapons/Cyberaugumented/PBWP_Warbringer.zs`, `actors/Weapons/Slot-4/AK-47.dec`.

### Select flow (required on `PB_WeaponBase` firearms)

```
Select → [barrel token cleanup] → SelectFirstPersonLegs → SelectContinue → SelectAnimation → Ready/Ready3
```

On **`SelectContinue`** (after leg overlay), every firearm should call:

1. **`PB_WeaponRaise(upSnd)`** — optional select sound string; bare `PB_WeaponRaise;` is valid. Clears overlays, resets tilt/zoom, sets leg overlay baseline.
2. **`PB_WeapTokenSwitch("TokenName")`** — replaces manual `A_TakeInventory("XSelected",1)` / `A_GiveInventory` spam. Required for PB monster death animations.
3. **`PB_RespectIfNeeded()`** — on `Ready`/`SelectReady` entry when the weapon defines `PB_WeaponBase.RespectItem` and a respect animation (see AK-47, AssaultRifle, BlackDMR).

Do **not** use `A_Overlay(-10, "FirstPersonLegs…")` — use `SelectFirstPersonLegs` / `A_LegOverlay(-1000, …)` via `PB_WeaponRaise`.

#### Common selection tokens

| Weapon category | Token |
|---|---|
| Pistols / general handguns | `HandgunSelected` |
| Revolvers / magnum handguns | `RevolverSelected` or `DeagleSelected` |
| SMGs | `UACSMGSelected` |
| Rifles / carbines (slot 4) | `RifleSelected` |
| DMRs / marksman | `DMRSelected` |
| Bolt / sniper (single-shot insert) | `SSGSelected` |
| Pump / auto shotguns | `SSGSelected` / `ASGSelected` |
| LMGs / miniguns | `MinigunSelected` |
| Rockets / grenade launchers | `RocketLauncherSelected` / `GrenadeLauncherSelected` |
| Plasma / energy rifles | `PlasmaGunSelected` |
| BFG-tier | `BFGSelected` |
| Duke pistol | `DukePistolSelected` |
| Oddball addon weapons | `AddonSelected` |

`PB_WeapTokenSwitch` clears the standard PB token set then sets the one passed in. Prefer it over copying the long manual list (legacy Kar98k/ACR pattern).

### Ready states

- **`Ready` / `Ready3`** must call **`A_DoPBWeaponAction(...)`** every tic — never bare `A_WeaponReady()`.
- Pass **`WRF_ALLOWRELOAD`** (or appropriate `weapflags`) so reload, kick, equipment, and unload routing work.
- **`Ready`** may branch to respect / steady / zoom setup; **`Ready3`** is the main idle loop after select completes.

### Reload (mag + reserve weapons)

State label must be **`Reload`** (not `ReloadMag`). Pattern:

1. **Barrel guards** at entry (`GrabbedBarrel` / flame / ice → idle throw states).
2. **`PB_CheckReload(unloadedReload, emptyReload, loadChamber, fullAlready, noAmmo, full, equal)`** — replaces manual `A_JumpIfInventory(mag, max)` + `A_JumpIfInventory(reserve)` + zoom clears at reload entry. First three labels are `null` when unused. Resets zoom, clears dual-wield reload state, calls `PB_SetReloading(true)`.
   - Example (31-round rifle mag): `PB_CheckReload(null, null, null, "NoReload", "NoAmmo", 31)`
   - Dual mag: pass `dual=true` and use left-mag ammo class on the actor.
3. **Animated reload** — mag-out frames, `PB_JumpIfMagUnloaded("MagIn")` before clip eject when the weapon supports unload.
4. **`PB_AmmoIntoMag("MagClass", "PB_HighCalMag", maxFill, 1)`** — replaces `InsertBullets` loops that `GiveInventory` one round at a time when animation already played.
5. **After fill:** `PB_SetChamberEmpty(false)`, `PB_SetMagEmpty(false)`, `PB_SetMagUnloaded(false)`.
6. **`A_TakeInventory("Reloading", 1)`** before `Goto Ready3` if the reload animation used the `Reloading` token.

**Fire gate:** use **`return PB_jumpIfNoAmmo("Reload", min);`** (or custom count) on fire entry — do not rely on `PB_CheckReload` alone; `chamberEmpty` defaults false and silent reload fails on CA-style weapons.

**Refire after shot:** keep **`A_CheckReload`** or **`A_JumpIfInventory(mag, 1, …)`** on auto-fire refire paths unless the weapon maintains PB chamber/mag flags — then **`PB_jumpIfNoAmmo`** is valid. Do **not** substitute `PB_CheckReload` on refire; it is reload-entry validation only.

### Unload

1. Take **`Unloading`** token at Unload entry (cleared by `A_DoPBWeaponAction` when done).
2. Prefer **`PB_UnloadMag(mag, pool, giveReserve, takeMag, maxSize, goal, spawnActor)`** over manual `RemoveBullets` loops.
3. Set **`PB_SetMagUnloaded(true)`** when the mag is physically out; pair with per-weapon unload token / `PB_JumpIfMagUnloaded` on reload.

### Exemptions (defer full reload migration)

| Category | Reason |
|---|---|
| VietDoom durability / multi-stage reload trees | Custom `PB_Viet*` ammo + condition tokens — Select/Ready pass only until ammo refactor |
| Duke / Karnage clip-token weapons (`DukePistolAmmo`, `Rainmakerclip`, Karnage clips) | Non-PB mag actors — keep legacy reload until model unified |
| Weapons with animated per-round insert where loop **is** the animation | Keep loop or refactor individually; still add `PB_CheckReload` at entry + flags after fill |
| `ACR.dec` legacy Select | Inline token list + no `SelectFirstPersonLegs` — migrate individually |
| Melee / equipment / energy projectile weapons | Select token only where `PB_WeaponBase`; skip mag reload pattern |

### Non-fire checklist (per weapon touch)

- [ ] `SelectContinue`: `PB_WeaponRaise` + `PB_WeapTokenSwitch`
- [ ] `PB_RespectIfNeeded` on ready/select path when `RespectItem` defined
- [ ] `A_DoPBWeaponAction` on all Ready/Ready3 loops
- [ ] Reload entry: `PB_CheckReload` + animated `DoReload` → `PB_AmmoIntoMag` + flag resets
- [ ] Unload: `PB_UnloadMag` where mag+reserve model matches PB pools
- [ ] Refire: `A_CheckReload` or mag-count jump (not `PB_CheckReload`)

---

## State Machine Conventions

PB weapons do not use the standard `Ready` state as a true idle. The typical flow:

```
Select → SelectFirstPersonLegs → SelectContinue → SelectAnimation → Ready/Ready3
```

- `Ready` / `Ready3`: Main idle loop. Always calls `A_DoPBWeaponAction()`.
- `Fire`: Check barrels first (`PB_jumpIfHasBarrel`), then check execution (`PB_Execute`), then fire logic.
- `AltFire`: Secondary fire mode — often mode-dependent via `invoker.SecondaryFire` bool or `invoker.specialmode` int/enum.
- `Reload`: Use `PB_CheckReload()` at entry, `PB_AmmoIntoMag()` for the transfer.
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
- **Legacy fire FX on migrated weapons:** Do not add new `GunFireSmoke`, `GunSmokeSpawner`, `RifleCaseSpawn`, or `*CasingSpawner` missile calls on ballistic fire states — use the PB Staging helpers documented in **PB Staging Fire-State Standards**. VietDoom `SmokeSpawner` on reload poses is not the same as muzzle smoke.
- **Legacy non-fire patterns:** Do not add manual `A_TakeInventory("*Selected")` lists on `SelectContinue` — use `PB_WeapTokenSwitch`. Do not use `PB_CheckReload` on auto-fire refire paths (keep `A_CheckReload` or mag-count jumps). After `PB_AmmoIntoMag`, always clear `PB_SetChamberEmpty/MagEmpty/MagUnloaded(false)` on mag-fed weapons. Bulk Select injection: `tools/Apply-PBWP-NonFireSelectPass.ps1` (re-run after adding weapons with `SelectContinue`).
- **Case sensitivity in ZScript:** ZScript is case-sensitive. There is a known issue in `PB_UnloadMag` where `maxsize` (lowercase) is used on lines 1828–1829 instead of the parameter name `maxSize`. Be careful with casing when referencing parameters.
- **Lump-path collisions with PB Staging:** PBWP overrides three PB Staging files by having identically-pathed files that the engine loads instead (last pk3 wins). When PB Staging adds new functions or changes logic in any of these files, those changes must be manually synced into PBWP's copies or the add-on will fail to load. The colliding files are: `zscript/Weapons/BaseWeapon_Functions.zsc`, `zscript/Weapons/BaseWeapon_Melee.zsc`, `zscript/Weapons/BaseWeapon_Equipment.zsc`. These overrides exist because PBWP needed to patch API signatures and add extension code that chains into PBWP-specific includes.
