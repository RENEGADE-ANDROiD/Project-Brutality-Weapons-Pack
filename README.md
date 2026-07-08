# Project Brutality Weapons Pack (PBWP)

A community weapons and systems addon for [Project Brutality Staging](https://github.com/Project-Brutality/Project-Brutality). PBWP bundles dozens of firearm addons into one loadable pack with spawn toggles, progression, gadgets, and a built-in PDA.

---

## Quick Start

1. Click the green **Code** button on GitHub → **Download ZIP**
2. Load the zip as a **pk3** mod in GZDoom / UZDoom
3. Recommended load order:

| Order | Addon | Required? |
|------:|-------|-----------|
| 1 | Your map WAD (optional) | No |
| 2 | [Project Brutality Staging](https://github.com/Project-Brutality/Project-Brutality) | **Yes** |
| 3 | [Glory Kills](https://github.com/thedoctorofdoom/glorykills) | Optional |
| 4 | **PBWP** | **Yes** (this pack) |
| 5+ | **PBX stack** (optional) | No — see below |

**Minimal stack:** Map → PB Staging → **PBWP**. PBWP shadows Staging `BaseWeapon_*` lumps and must stay **after** Staging.

**Optional PBX stack** (load **after** PBWP, in this order):

| Order | Addon | Role |
|------:|-------|------|
| 5 | `PBX-Core-main.zip` | Shared HUD, upgrades, maths (`PBXCore_*`) |
| 6 | `PBX-Weapons-main.zip` | Replaces legacy PBWP weapons (CSSG, NeoHMG, Ballista, Demon Ext, etc.) |
| 7 | `PBX-Armors-main.zip` | Armor system |
| 8 | `PBX-Items-main.zip` | Powerups / item spawners |
| 9 | `PBX-Addons-main.zip` | Helmet drops, damage indicators, hit feedback, smart scavenger, backpack reload |

PBWP does **not** require PBX. When PBX is loaded, PBWP skips duplicate systems (helmet drops, directional damage indicators, PBX weapon spawns) so the two packs do not fight.

---

## Requirements

| Addon | Required? | What you lose without it |
|-------|-----------|--------------------------|
| **Project Brutality Staging** | **Yes** | Everything — player, HUD base, spawners, PDA hooks |
| **Glory Kills** | No | Glory-kill finisher path; PB `PB_Execute()` fatalities still work |
| **PBX stack** | No | Extra weapons (CSSG, NeoHMG, Ballista, …), helmet drops, damage indicators — use PBX zips after PBWP |

## Load-order notes

- **PBWP must load after PB Staging** so weapon-base patches apply.
- **PBWP loads before PBX** when using the optional PBX stack (`PBX-Core` → `PBX-Weapons` → … → `PBX-Addons`).
- **Glory Kills** is probed at map load (`isGKLoaded`); GKCompat weapon states and glory-kill achievements activate only when detected. Load the Glory Kills pk3 for the GK ability HUD overlay (provided by that mod, not PBWP).

## Features & Systems

| System | What it does |
|--------|----------------|
| **127+ weapons** | Per-weapon spawn toggles for custom playthroughs (firearms + melee) |
| **Weapon pack presets** | One-click enable/disable for whole sets (God Complex, Karnage, IN, Schism/F&I, Freezer, VietDoom, Duke, etc.) |
| **PDA** | Weapon codex, monster log, combat shop — press **P** |
| **Experience economy** | Kill XP, 25 ranks, floating damage numbers, reward spin |
| **Experience shop** | Buy gear from the in-game menu or PDA shop tab |
| **Achievements (VUAS)** | PDA browse tab + toast unlocks |
| **Killstreaks** | PB-Pand Edition streak rewards (includes **Hyperweapon Rig** — see below) |
| **Melee weapon wheel** | 12+ melee options with durability |
| **Gadgets & equipment** | 22 equipment-wheel items + melee wheel, Meat Hook, Shieldsaw, and more |
| **Monster Enhancement Settings** | Built-in Champions Lite — champion traits/mutations on any monster pack (PB Options → Addon Options → PB War Pack) |
| **Item magnet** | Buy from XP shop; bind **Toggle PBWP Item Magnet** (default `M`) |
| **Screen tilt / weapon sway** | PBWP Options → Screen Tilt / Weapon Visual Settings |
| **Random weapon switcher** | Optional interval randomizer |
| **Doorbuster** | Optional door-breach mechanic |
| **Pickup polish** | Floating cruelty bonuses, armor mutators, pickup variations (helmet drops: **PBX-Addons**) |
| **God Complex Extras** | Optional gameplay layer for GC weapons: Rune-Lite buffs, complex ammo drops, BFG-tier weapon replacer, shield/leg sphere and chalice pickups, and alt-fire modes via the Gearbox wheel (no extra keys) |

### PDA quick reference

- **P** — open weapon codex
- Grid shows pickup sprites for logged weapons (Staging, PBWP, and PBX when loaded)
- Hover a weapon for the detail panel; **PgUp / PgDn** to scroll
- Shop and achievement tabs live in the same PDA

### Hyperweapon Rig (killstreak reward)

Earned from killstreak milestones when killstreaks are enabled. Grants **30 seconds** of the slot-9 **Hyperweapon Rig** — five weapons fire in a staggered volley (outer wings → inners → center hero → inners → outer wings).

| Input | Action |
|-------|--------|
| **Fire** | Full five-gun volley (unlimited ammo while power is active) |
| **Alt-fire** | Cycle loadout: **Ballistic** → **Energy** → **Heavy** → **Exotic** (HUD message + switch sound) |

When the timer expires, overlays clear and your previous weapon is restored automatically. First select plays a short respect animation (PB standard).

### Configuration menus

| Path | Purpose |
|------|---------|
| **PB Options → Addon Options → PB War Pack** | Main PBWP hub |
| **PB War Pack → Weapon Spawn Settings** | Full per-weapon spawn list + **pack preset buttons** (Enable/Disable Karnage, IN, VietDoom, Duke, etc.) |
| **Addon Options → Configure Spawns → Weapons** | Quick weapon-tier toggles |
| **PBWP Options** | Fatalities, killstreaks, magnet, and more |
| **PB War Pack → God Complex Extras** | Master toggle + Rune-Lite, complex ammo, BFG replacer, sphere/chalice spawns |
| **Weapon Spawn Settings → God Complex** | Per-GC-weapon spawn toggles (also links to God Complex Extras) |
| **PB War Pack → Monster Drop Settings** | Salvage weapons from specific enemies (see below) |

---

## Monster weapon drops

These weapons are **primarily** obtained by killing the right enemy with drops enabled. Several also appear on map weapon spawners when their spawn toggles are on (see notes in the chart).

**Where to turn them on:** `PB Options → Addon Options → PB War Pack → Monster Drop Settings`  
**Quick presets:** `Weapon Spawn Settings` pack buttons also flip drop toggles — e.g. **Enable Schism / Fire & Ice** turns on Stormcast (Schism) and Thunder Crossbow (Fire & Ice) drops; **Enable Freezer** turns on Cryo Rifle map spawns and drops; **Enable IN** turns on Bio-Acid Launcher drops.

### Drop chart

| Weapon | Enemy that drops it | Notes |
|--------|---------------------|-------|
| **Marauder SSG** | Marauder | May also spawn Meat Hook + MSSG upgrade packs; rare **shotgun spawner** T3/T4 pickup |
| **Mancubus Flame Cannon** | Mancubus (arm gas on death) | First pickup |
| **Dual Flame Cannons** | Mancubus (arm gas) | Second pickup while you hold the single cannon |
| **Cryo Rifle** | Frost Dark Imp / Volcabus | Freezer preset — optional drop refills ammo; also spawns on **plasma rifle spawns** T3/T4 |
| **Thunder Crossbow** | Revenant family | Fire & Ice — optional drop refills cells; also spawns on **plasma rifle spawns** T2–T4 |
| **Stormcast** | Arch-vile / Hellion | Schism — also **BFG spawner** T3/T4 when enabled |
| **Bio-Acid Launcher** | Cacodemon | IN preset |
| **Cyberdemon RL** | Cyberdemon gun wreck | PBX weapon — toggle in same menu |
| **Mastermind Chaingun** | Spider Mastermind | PBX weapon — toggle in same menu |

### Salvage durability (PBX-style)

Monster-drop gear is **salvaged**, not factory-fresh:

1. **First pickup** — full durability pool (varies by weapon, roughly 30–60 uses).
2. **Each shot or swing** — spends 1 durability point (in addition to normal ammo/fuel).
3. **At zero** — weapon breaks (metal shards + break sound) and is removed.
4. **Repeat drop** — refills partial durability and some ammo instead of giving a duplicate gun.

PBX monster weapons (Cyberdemon RL, Mastermind Chaingun) use their own durability pools from PBX-Weapons.

---

## Weapon Roster

Weapons below ship in PBWP lumps. Toggle each in **Weapon Spawn Settings**, or flip whole sets with the **pack preset** buttons (God Complex, Karnage, IN, Demon-Tech, Schism, Freezer, Russian Overkill, Doom 2016, Duke, PB3.0, VietDoom).

### Slot 1 — Melee

| Weapon | Notes |
|--------|-------|
| Energy Beam Katana | |
| Argent Sith Beam Katana | |
| **Insanity's Requiem Mk.2** | Vorpal Blade |
| **God Complex** | Legendary Chainsaw |
| **Schism** | Battle Axe and Shield |
| **Russian Overkill** | Razorjack |
| **VietDoom (BD v22)** | Machete |

### Slot 2 — Pistols / SMGs

| Weapon | Notes |
|--------|-------|
| 44 PDW | |
| Beretta 92 Silenced | |
| Doom Blaster | |
| Thanatos Magnum | |
| UZI SMG | |
| **LiTDoom** | LiT .500 Magnum Revolver |
| **Insanity's Nightmare** | Beretta92 Harmony, Holy Bastard (W-SMG) |
| **Demon-Tech** | Demon-Tech Pistol |
| **PB 2022** | Hell Pistoler (shrink beam + weapon wheel) |
| **Karnage Legacy** | Handgun G2, MP-55 |
| **VietDoom (BD v22)** | M1911A1, M3 Grease Gun, Thompson M1A1, MAT-49 |
| **Duke Nukem 3D** | Pistol (dual-wield) |
| **PB3.0 weapons** | UAC-12a Automat (IBMP-12), UAC-33 Ballistic Shield (Riot Shield) |

### Slot 3 — Shotguns

| Weapon | Notes |
|--------|-------|
| Hexa-Lion Shotgun | Hexa-Soyboy |
| M1887 Winchester Lever-Action | |
| Marauder SSG | Rare **shotgun spawner** T3/T4; also drops from Marauder |
| **PB 2022** | Marauder SSG (alt-fire shotgun blast; hook on weapon special) |
| Rotating Double Barrel | |
| **God Complex** | Legendary Assault Shotgun |
| **Insanity's Nightmare** | Rotational SG, HASG (Lady Golide) |
| **Demon-Tech** | Demon-Tech Shotgun |
| **Doom 2016** | Doom 2016 Shotgun |
| **Karnage Legacy** | Shotgun V1, Rainmaker |
| **VietDoom (BD v22)** | Ithaca 37 |
| **Duke Nukem 3D** | Shotgun |
| **PB3.0 weapons** | X12 Shotgun, M45 Halo 3 Shotgun |

### Slot 4 — Rifles

| Weapon | Notes |
|--------|-------|
| Bolt-Action Sniper | UAC 50B |
| **Insanity's Nightmare** | AK-47, Assault R1 (HAR), Black DMR, Advanced Mask Man Rifle, Mask Man Rifle, M1X, Dark Fate, Magnum Sniper Rifle |
| **Doom 2016** | Doom 2016 Machinegun |
| **Russian Overkill** | Power Overwhelming |
| **Karnage Legacy** | SSVX-AR |
| **VietDoom (BD v22)** | M16A1, M14, XM21 (M21), AK-47, SKS, Mosin-Nagant |
| **PB 2022** | Fusil |
| **Cyberaugumented** | Warbringer |
| **PB3.0 weapons** | Mauser Karabiner 98k |

### Slot 5 — Machine Guns / Nailguns

| Weapon | Notes |
|--------|-------|
| Auto Cannon | |
| UAC Super Nailgun | |
| UAC MACH-3 Type-B HYDRA | |
| **Insanity's Nightmare** | Gallery Nailgun, Insanity's Nightmare Minigun, Apocalypse Killer HAR |
| **VietDoom (BD v22)** | M60, M1918 BAR, RPD, Stoner 63 |
| **Duke Nukem 3D** | Ripper Chaingun |
| **Cyberaugumented** | Nightfall Augumented, X40-DK Legionnaire |
| **PB3.0 weapons** | Tactical Nailgun (Stroggos SGP-331) |

### Slot 6 — Explosives

| Weapon | Notes |
|--------|-------|
| Totenheim Integridar Nuke | Hellbound Tactical Nuke Launcher |
| **Insanity's Nightmare** | Chthonic Rifle, Fallen Hawk, Super Grenade Launcher (Samantha) |
| **Doom 2016** | Doom 2016 Rocket Launcher |
| **Karnage Legacy** | PA Grenade Launcher |
| **VietDoom (BD v22)** | RPG-7, M79 Grenade Launcher |
| **Duke Nukem 3D** | RPG, Devastator |
| **Cyberaugumented** | Intervention Y0, Caduceus, Dispatcher of Delusions |

### Slot 7 — Energy Rifles

| Weapon | Notes |
|--------|-------|
| Ancient Crossbow | |
| Gauss Cannon | |
| **God Complex** | Legendary Plasmatic Rifle |
| **Doom 2016** | Doom 2016 Plasma Gun, Doom 2016 Vortex Rifle |
| **Cyberaugumented** | Amnesia Proton Phaser, Liquidation, Sirius Crisis Roscoe |

### Slot 8 — Special Energy

| Weapon | Notes |
|--------|-------|
| **God Complex** | Devastador (UAC-Prototype BFG) |
| **Freezer** | Cryo Rifle (Freeze Thrower) — **plasma spawner** T3/T4 + Frost Imp / Volcabus drop |
| **Insanity's Nightmare** | Extinction Ray (Argent Fury), Ion Rifle, Plasma Assault Rifle, Thunder Carrier (Type A) |
| **PB 2022** | UAC Prototype Dark Matter Rifle |
| **Demon-Tech** | Tech Blaster |
| **Fire & Ice** | Thunder Crossbow (4 fire modes + storm shield alt-fire) |
| **Karnage Legacy** | Plasmastinger |
| **Legacy of Rust (LoR)** | Calamity Blade |
| **Cyberaugumented** | Deracinator, Dismantler |

> **Plasma-tier map spawns (T3/T4):** Cryo Rifle (Freezer) and Thunder Crossbow (Fire & Ice, T2–T4) inject into PB plasma rifle spawners when their spawn toggles are on. Cryo Rifle and Thunder Crossbow no longer use salvage durability gates — monster drops remain optional bonuses (ammo/cell refills).

### Slot 9 — BFG Tier

| Weapon | Notes |
|--------|-------|
| Legacy Unmaker | |
| Mancubus Flame Cannon | *Monster drop only — Mancubus arm gas* |
| **PB 2022** | Mancubus Flame Cannon (salvage durability) |
| Dual Mancubus Flame Cannons | *Monster drop only — second Mancubus pickup upgrades single cannon* |
| **God Complex** | Enraged Legendary BFG, God Enraged BFG, Nemesis BFG |
| **Demon-Tech** | Demon-Tech Minigun, Phase Eradicator BFG |
| **Schism** | Stormcast |
| **Insanity's Nightmare** | Bio-Acid Launcher, Satan Scream (Unmaker variant) |
| **PB3.0 weapons** | BFG9500 |
| **Cyberaugumented** | Cinereal Ordnance |

> Stormcast and Bio-Acid Launcher are **monster drops only** (Arch-vile / Hellion and Cacodemon).

### Pack preset quick reference

| Preset | Weapons / systems covered |
|--------|---------------------------|
| **God Complex** | 7 weapons — slots 1, 3, 7, 8, 9 (+ God Complex Extras menu) |
| **Karnage Legacy** | 8 weapons — slots 2, 3, 4, 6, 8 |
| **Insanity's Nightmare (IN)** | 24+ IN weapons across slots 0, 2–6, 8, 9 + Bio-Acid drop |
| **Demon-Tech (DTECH)** | Demon-Tech Pistol, Demon-Tech Shotgun, Tech Blaster, Demon-Tech Minigun, Phase Eradicator BFG |
| **Schism / Fire & Ice** | **Schism:** Battle Axe, Stormcast drop. **Fire & Ice:** Thunder Crossbow (plasma spawner + Revenant drop) |
| **Freezer** | Cryo Rifle (plasma spawner T3/T4 + drop), freeze grenades, freeze bots |
| **Russian Overkill (RO)** | Razorjack, Power Overwhelming |
| **Doom 2016 (D2016)** | D2016 Shotgun, Machinegun, Rocket Launcher, Plasma Gun, Vortex Rifle |
| **Duke Nukem 3D** | 5 weapons + pipebomb equipment — slots 2, 3, 5, 6 |
| **PB3.0 weapons** | X12, M45, IBMP-12, Riot Shield, Tactical Nailgun, Kar98k, BFG9500 |
| **VietDoom (BD v22)** | 20 weapons across slots 1–6 and 8 |
| **Cyberaugumented** | 11 weapons across slots 4–9 (Warbringer through Cinereal Ordnance; includes Legionnaire, Dispatcher, Sirius Crisis) |

---

## Equipment Roster

Equipment below is selected from the **Gearbox equipment wheel** (not weapon slots). Pick up an item once to unlock it on the wheel, then hold the equipment key to choose it and press **Use Equipment** to deploy.

Toggle world spawns in **PB Options → Addon Options → Configure Spawns → Equipments** (and **God Complex** for GC sphere/chalice pickups). Pack preset buttons also flip some equipment spawns — e.g. **Enable Freezer** turns on freeze grenades and freeze bots; **Enable Duke** turns on Duke pipebomb pickups.

### Wheel Slot 0 — Misc

| Equipment | Notes |
|-----------|-------|
| Leech | Life-drain beam; uses **PB_DTech** as ammo |
| Meat Hook | Grapple / mobility — no ammo |
| **God Complex** | Demonic Chalice (alt-fire consumable via wheel) |

### Wheel Slot 1 — Damage

| Equipment | Notes |
|-----------|-------|
| Frag Grenade | Core PB throwable |
| Quick Launcher | Auxiliary rocket launcher |
| Void Grenade | Gravity-collapse grenade |
| **Freezer** | Freeze Grenade |

### Wheel Slot 2 — Utility

| Equipment | Notes |
|-----------|-------|
| Caltrops | Ground spike trap |
| Proximity Mine | Timed proximity explosive |
| Stun Grenade | Shock / stagger burst |
| Electric Pod | Deployable turret pod |
| Shield Grenade | Protective bubble grenade |
| **Duke Nukem 3D** | Pipebombs & Detonator (throw, then detonate) |
| **God Complex** | GC Shield Sphere |

### Wheel Slot 3 — Remote Charges

Shared **detonator** — picking up any remote charge also grants `DetonatorAmmo`; use equipment again to trigger placed charges.

| Equipment | Notes |
|-----------|-------|
| Swarmer | Homing micro-missile swarm |
| Laser Charge | Remote laser charge |
| Acid Charge | Remote acid charge |

> Toggle all three spawns together: **Configure Spawns → Spawn Remote Charges**.

### Wheel Slot 4 — Friendlies

| Equipment | Notes |
|-----------|-------|
| Beacon | Summon / rally beacon |
| **Freezer** | Freeze Bot |

### Wheel Slot 5 — Throwables

| Equipment | Notes |
|-----------|-------|
| Throwing Axe | Also available on the **melee wheel** |
| Shurikens | Ninja stars |
| **Fire & Ice** | Shield Saw |

> Shield Saw has no ammo counter; equip and throw from the wheel once you own it.

### Related — Slot 0 gadget weapons

These still occupy **weapon slot 0** (gadget wheel) rather than the equipment wheel:

| Gadget | Notes |
|--------|-------|
| Satchel-Charge & Detonator | Timed throw + remote detonate (`Det_SatchelCharge`) |

### Equipment spawn quick reference

| Toggle / preset | Equipment affected |
|-----------------|-------------------|
| **Enable Freezer** | Freeze Grenade, Freeze Bot |
| **Enable Duke** | Duke Pipebombs |
| **God Complex Extras** | GC Shield Sphere, Demonic Chalice (separate spawn toggles under Configure Spawns → God Complex) |
| **Spawn Remote Charges** | Swarmer, Laser Charge, Acid Charge |
| **Configure Spawns → Equipments** | Shield Grenade, Void Grenade, Electric Pod, Caltrops, Shurikens, Beacon, Shield Saw, Meat Hook, Freeze Grenade |

Frag Grenades, Proximity Mines, Stun Grenades, Quick Launcher, and Leech ship with **Project Brutality Staging** progression — no separate PBWP spawn toggle.

---

## Team

| Member |
|--------|
| RENEGADE ANDROiD |
| BeefRice / LovecraftNeko |
| Warcarlsson |
| Doc |
| JhulkerCraft |
| Runner |

Originally assembled and currently maintained by **RENEGADE ANDROiD**. The project grew from Insanity's Nightmare, Demon-Tech, Gadgets & Equipments, Fire and Ice Power Fantasy, Project Survival, and years of community weapon addons from the Project Brutality Discord and former Brutal Repository. BeefRice (LovecraftNeko) implemented many of the core systems that tie the pack together.

---

## Credits

Attributions for included mods, systems, and assets. See the `CREDITS/` folder for per-addon detail files.

| Contribution | Credit |
|--------------|--------|
| PBWP assembly & maintenance | RENEGADE ANDROiD |
| Core systems (melee wheel, gadgets, progression hooks, and more) | BeefRice / LovecraftNeko |
| Zombie helmet drops & floating cruelty bonuses | Adryan |
| Armor mutators | Kineret.G |
| Pickup item variations | TDGuy, Runner & DarkShadow |
| Killstreaks (PB-Pand Edition) | John & Kole |
| Melee weapon wheel source | ThePopeOfDope — Project Survival |
| Item Magnet (re-branded from Dragon Sector for map compat.) | Dragon Sector |
| Universal champion enemies | Mikk- | Lite version by RENEGADE ANDROiD
| Instant Random Weapon switcher | BROS_ETT_311 |
| Doorbuster | Brutal Doom Platinum |
| Experience economy (PB 2022 basis) | Project Brutality community |
| Achievements (VUAS) | VUAS authors |
| PB3.0 weapon packs | Community authors (X12, M45, BFG9500K, Karnage Legacy, IBMP-12, Tactical Nailgun, Vorpal Blade, Riot Shield, Mauser Kar98k, etc.) |
| UAC / LiT weapon packs | LiT Revolver, Totenheim Integridar Nuke, Phase Eradicator BFG, 50B Bolt-Action Sniper, Legacy Unmaker, MACH-3 HYDRA, Hexa-Soyboy Shotgun |
| VietDoom v22 | Sgt Mark & Thorir |
| Insanity's Nightmare weapons | Insanity's Nightmare authors |
| Schism weapons | Schism authors (Battle Axe, Stormcast) |
| Fire & Ice weapons | Brutal Hexen / Fire & Ice authors (Thunder Crossbow, Shield Saw) |
| Russian Overkill weapons | Russian Overkill authors |
| Demon-Tech weapons | Demon-Tech authors |
| Duke 3D weapons | Duke addon authors (Pistol, Shotgun, RPG, Pipebombs, Ripper, Devastator) |
| Doom 2016 weapon pack | D4 pack authors |
| God Complex weapons | God Complex authors |
| Realm667 powerups | Realm667 authors |

Permissions were gathered for included content where possible. If you are a contributor and want a credit line updated, open an issue or reach out to the maintainers.
