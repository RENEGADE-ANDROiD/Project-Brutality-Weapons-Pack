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

**Minimal stack:** Map → PB Staging → **PBWP** loads and runs. PBWP shadows Staging `BaseWeapon_*` lumps and must stay **after** Staging.

---

## Requirements

| Addon | Required? | What you lose without it |
|-------|-----------|--------------------------|
| **Project Brutality Staging** | **Yes** | Everything — player, HUD base, spawners, PDA hooks |
| **Glory Kills** | No | Glory-kill finisher path; PB `PB_Execute()` fatalities still work |

## Load-order notes

- **PBWP must load after PB Staging** so weapon-base patches apply.
- **Glory Kills** is probed at map load (`isGKLoaded`); GKCompat weapon states and glory-kill achievements activate only when detected. Load the Glory Kills pk3 for the GK ability HUD overlay (provided by that mod, not PBWP).

## Features & Systems

| System | What it does |
|--------|----------------|
| **132 weapons** | Per-weapon spawn toggles for custom playthroughs (firearms + melee) |
| **Weapon pack presets** | One-click enable/disable for whole sets (God Complex, Karnage, IN, Schism/F&I, Freezer, VietDoom, Duke, etc.) |
| **PDA** | Weapon codex, monster log, combat shop — press **P** |
| **Experience economy** | Kill XP, 25 ranks, floating damage numbers, reward spin |
| **Experience shop** | Buy gear from the in-game menu or PDA shop tab |
| **Achievements (VUAS)** | PDA browse tab + toast unlocks |
| **Killstreaks** | PB-Pand Edition streak rewards (includes **Hyperweapon Rig** — see below) |
| **Melee weapon wheel** | 12+ melee options with durability |
| **Gadgets & equipment** | 22 equipment-wheel items + melee wheel, Meat Hook, Shieldsaw, and more |
| **Champions Lite** | Universal champion variants |
| **Item magnet** | Buy from XP shop; bind **Toggle PBWP Item Magnet** (default `M`) |
| **Screen tilt / weapon sway** | PBWP Options → Screen Tilt / Weapon Visual Settings |
| **Tactical weapon motion** | PB 2022 strafe tilt, movement lowering, and lean — **PBWP Options → Tactical Weapon Motion** |
| **Random weapon switcher** | Optional interval randomizer |
| **Doorbuster** | Optional door-breach mechanic |
| **Pickup polish** | Helmet drops, floating cruelty bonuses, armor mutators, pickup variations |
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
| **PBWP Options** | Fatalities, killstreaks, magnet, tilt, tactical weapon motion, and more |
| **PB War Pack → God Complex Extras** | Master toggle + Rune-Lite, complex ammo, BFG replacer, sphere/chalice spawns |
| **Weapon Spawn Settings → God Complex** | Per-GC-weapon spawn toggles (also links to God Complex Extras) |
| **PB War Pack → Monster Drop Settings** | Salvage weapons from specific enemies (see below) |

---

## Monster weapon drops

These weapons **do not spawn on weapon pads**. You get them by killing the right enemy with drops enabled.

**Where to turn them on:** `PB Options → Addon Options → PB War Pack → Monster Drop Settings`  
**Quick presets:** `Weapon Spawn Settings` pack buttons also flip drop toggles — e.g. **Enable Schism / Fire & Ice** turns on Stormcast and Thunder Crossbow drops; **Enable Freezer** turns on Cryo Rifle drops; **Enable IN** turns on Bio-Acid Launcher drops.

### Drop chart

| Weapon | Enemy that drops it | Notes |
|--------|---------------------|-------|
| **Marauder SSG** | Marauder | May also spawn Meat Hook + MSSG upgrade packs |
| **Paingiver** | Hell Trooper | |
| **Mancubus Flame Cannon** | Mancubus (arm gas on death) | First pickup |
| **Dual Flame Cannons** | Mancubus (arm gas) | Second pickup while you hold the single cannon |
| **Cryo Rifle** | Frost Dark Imp / Volcabus | Freezer preset |
| **Thunder Crossbow** | Revenant family | |
| **Stormcast** | Arch-vile / Hellion | Schism preset |
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

**VietDoom firearms** can use the same style of wear-and-tear when **VietDoom weapon durability** is on (**PB War Pack → Weapon Spawn Settings**, VietDoom section). Toggle off for classic PB behavior without jam/clean/inspect loops.

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
| **Schism / Fire & Ice** | Battle Axe and Shield |
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
| **Insanity's Nightmare** | Plasma Annihilator Pistol, Beretta92 Harmony, Holy Bastard (W-SMG) |
| **Demon-Tech** | Demon-Tech Pistol |
| **PB 2022** | Demon-Tech Pistol (Hell Pistoler — shrink beam + weapon wheel) |
| **Karnage Legacy** | Handgun G2, MP-55 |
| **VietDoom (BD v22)** | M1911A1, M3 Grease Gun, Thompson M1A1, MAT-49, PPSh-41 |
| **Duke Nukem 3D** | Pistol (dual-wield) |
| **PB3.0 weapons** | UAC-12a Automat (IBMP-12), UAC-33 Ballistic Shield (Riot Shield) |

### Slot 3 — Shotguns

| Weapon | Notes |
|--------|-------|
| Hexa-Lion Shotgun | Hexa-Soyboy |
| M1887 Winchester Lever-Action | |
| Marauder SSG | *Monster drop only — Marauder* |
| **PB 2022** | Marauder SSG (alt-fire shotgun blast; hook on weapon special) |
| Rotating Double Barrel | |
| **God Complex** | Legendary Assault Shotgun |
| **Freezer** | Cryo Shotgun |
| **PB 2022** | Cryo Shotgun (5 fire modes + weapon wheel) |
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
| **God Complex** | Nemesis LMG (Nemesis Explosive Rifle) |
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
| **Schism / Fire & Ice** | Fire and Ice DragonSlayer |
| **VietDoom (BD v22)** | M60, M1918 BAR, RPD, Stoner 63 |
| **Duke Nukem 3D** | Ripper Chaingun |
| **Cyberaugumented** | Nightfall Augumented |
| **PB3.0 weapons** | Tactical Nailgun (Stroggos SGP-331) |

### Slot 6 — Explosives

| Weapon | Notes |
|--------|-------|
| Paingiver | *Monster drop only — Hell Trooper* |
| Totenheim Integridar Nuke | Hellbound Tactical Nuke Launcher |
| **Insanity's Nightmare** | Chthonic Rifle, Fallen Hawk, Super Grenade Launcher (Samantha) |
| **Doom 2016** | Doom 2016 Rocket Launcher |
| **Karnage Legacy** | PA Grenade Launcher, RPG-7 |
| **VietDoom (BD v22)** | RPG-7, M79 Grenade Launcher |
| **Duke Nukem 3D** | RPG, Devastator |
| **Cyberaugumented** | Intervention Y0, Caduceus |

### Slot 7 — Energy Rifles

| Weapon | Notes |
|--------|-------|
| Ancient Crossbow | |
| Gauss Cannon | |
| **God Complex** | Legendary Plasmatic Rifle |
| **Doom 2016** | Doom 2016 Plasma Gun, Doom 2016 Vortex Rifle |
| **Cyberaugumented** | Amnesia Proton Phaser, Liquidation |

### Slot 8 — Special Energy

| Weapon | Notes |
|--------|-------|
| **God Complex** | Devastador (UAC-Prototype BFG) |
| **Freezer** | Cryo Rifle (Freeze Thrower) |
| **Insanity's Nightmare** | Extinction Ray (Argent Fury), Ion Rifle, Plasma Assault Rifle, Thunder Carrier (Type A) |
| **PB 2022** | UAC Prototype Dark Matter Rifle |
| **Legacy of Rust (LoR)** | Calamity Blade |
| **Demon-Tech** | Tech Blaster |
| **Schism / Fire & Ice** | Thunder Crossbow |
| **Karnage Legacy** | Plasmastinger |
| **Cyberaugumented** | Deracinator, Dismantler |

> Cryo Rifle and Thunder Crossbow are **monster drops only** (Frost Dark Imp / Volcabus and Revenant) — enable via Freezer / Schism presets or Monster Drop Settings.

### Slot 9 — BFG Tier

| Weapon | Notes |
|--------|-------|
| Legacy Unmaker | |
| Mancubus Flame Cannon | *Monster drop only — Mancubus arm gas* |
| **PB 2022** | Mancubus Flame Cannon (salvage durability) |
| Dual Mancubus Flame Cannons | *Monster drop only — second Mancubus pickup upgrades single cannon* |
| **God Complex** | Enraged Legendary BFG, God Enraged BFG, Nemesis BFG, Legendary BFG 10K |
| **Demon-Tech** | Demon-Tech Minigun, Phase Eradicator BFG |
| **Schism / Fire & Ice** | Stormcast |
| **Insanity's Nightmare** | Bio-Acid Launcher, Calamity Blade, Satan Scream (Unmaker variant) |
| **PB3.0 weapons** | BFG9500 |
| **Cyberaugumented** | Cinereal Ordnance |

> Stormcast and Bio-Acid Launcher are **monster drops only** (Arch-vile / Hellion and Cacodemon).

### Pack preset quick reference

| Preset | Weapons / systems covered |
|--------|---------------------------|
| **God Complex** | 10 weapons — slots 1, 3, 4, 7, 8, 9 (+ God Complex Extras menu) |
| **Karnage Legacy** | 8 weapons — slots 2, 3, 4, 6, 8 |
| **Insanity's Nightmare (IN)** | 25+ IN weapons across slots 0, 2–6, 8, 9 + Bio-Acid drop (includes IN Calamity Blade) |
| **Legacy of Rust (LoR)** | Calamity Blade (slot 8) |
| **Demon-Tech (DTECH)** | Demon-Tech Pistol, Demon-Tech Shotgun, Tech Blaster, Demon-Tech Minigun, Phase Eradicator BFG |
| **Schism / Fire & Ice** | Battle Axe, DragonSlayer + 2 monster-drop weapons (Thunder Crossbow, Stormcast) |
| **Freezer** | Cryo Shotgun spawn + Cryo Rifle drop (+ freeze grenade / freezebot spawns) |
| **Russian Overkill (RO)** | Razorjack, Power Overwhelming |
| **Doom 2016 (D2016)** | D2016 Shotgun, Machinegun, Rocket Launcher, Plasma Gun, Vortex Rifle |
| **Duke Nukem 3D** | 5 weapons + pipebomb equipment — slots 2, 3, 5, 6 |
| **PB3.0 weapons** | X12, M45, IBMP-12, Riot Shield, Tactical Nailgun, Kar98k, BFG9500 |
| **VietDoom (BD v22)** | 21 weapons across slots 1–6 and 8; optional **VietDoom weapon durability** toggle in Weapon Spawn Settings |
| **Cyberaugumented** | 9 weapons across slots 4–9 (Warbringer through Cinereal Ordnance) |

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
| **Schism / Fire & Ice** | Shield Saw |

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
| Legacy of Rust (Calamity Blade) | xxHeavySwagxx / Not So Vanilla LoR pack |
| Schism weapons | Schism authors |
| Russian Overkill weapons | Russian Overkill authors |
| Demon-Tech weapons | Demon-Tech authors |
| Duke 3D weapons | Duke addon authors (Pistol, Shotgun, RPG, Pipebombs, Ripper, Devastator) |
| Doom 2016 weapon pack | D4 pack authors |
| God Complex weapons | God Complex authors |
| Realm667 powerups | Realm667 authors |

Permissions were gathered for included content where possible. If you are a contributor and want a credit line updated, open an issue or reach out to the maintainers.
