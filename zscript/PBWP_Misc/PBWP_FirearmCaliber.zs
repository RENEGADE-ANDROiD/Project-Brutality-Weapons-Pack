// PBWP firearm caliber helpers — migrate legacy fire calls to PB_FireBullets.
// Projectile classes are defined in PB Staging (BulletDef.*.zsc); do not duplicate here.
//
// === Caliber roster (PBWP firearms) ===
// PB_9x19mm / PB_9x19mmHollowPoint — pistols, SMGs (Beretta, UZI, MP12, MAT49, PPS, RiotShield)
// PB_45ACP              — .45 SMGs/pistols (Thompson, M1911, M3A1)
// PB_500SW              — magnum handguns (44PDW, LiT Revolver)
// PB_556x45mm           — 5.56 rifles (M16, Stoner, ACR, Assault Rifle, Fusil, TacticalNailgun 556 mode)
// PB_762x51mm           — 7.62 battle/LMG (AK, SKS, RPD, M14, BAR, M60, HYDRA, IN Minigun)
// PB_762x51mmAP         — DMR/sniper (Mosin, Kar98k, Bolt Rifle, Fallen Hawk, XM21 ADS)
// PB_10x24mm            — caseless rifle (M41A)
// PB_12GAPellet         — 12ga buckshot (Ithaca, M45, X12, MarauderSSG, Apocalypse Killer)
// PB_10GAPellet         — 10ga double-barrel (SSG)
// PB_12GASlug           — 12ga slug (M79 slug, Lady Golide)
// PB_MGNail / PB_SMGNail* — nailguns (TacticalNailgun ADS, SuperNailgun — custom projectile classes)
//
// === Insanity's Nightmare (IN_*) -> PB caliber map ===
// IN_45ACPHarmony     -> PB_45ACP       (Berreta.dec)
// IN_9x35mmWSMG       -> PB_9x19mm      (W_SMG)
// IN_556x45mmRKX      -> PB_556x45mm    (BlackDMR)
// IN_556x45mmM1X      -> PB_556x45mm    (M1X)
// IN_556x80mmChthon   -> PB_762x51mmAP  (ChthonicRifle)
// IN_762x65mmHawk     -> PB_762x51mmAP  (Fallen Hawk FMJ; keep WallPenetrationHitscan)
// IN_105x68mmMagnum   -> PB_762x51mmAP  (Magnum Sniper Rifle)
// IN_105x68mmHAR      -> PB_762x51mm    (Demon Murderer HAR)
// IN_765x38mmDarkFate -> PB_762x51mm    (Dark Fate LMG)
//
// === Duke Nukem 3D -> PB caliber map ===
// Duke_9x19mm       -> PB_9x19mm       (Duke Pistol, Dual Duke)
// Duke_9x19mmRipper -> PB_762x51mm    (Ripper Chaingun)
// Duke_12GAPellet   -> PB_12GAPellet   (Duke Shotgun)
//
// === Karnage (KRG_*) -> PB caliber map ===
// KRG_9x19mm    -> PB_9x19mm
// KRG_9x19mmHP  -> PB_9x19mmHollowPoint
// KRG_500SW     -> PB_500SW
// KRG_556x45mm  -> PB_556x45mm
// Rainmaker       -> PB_12GAPellet (12-pellet burst; third barrel doubles fire call)
// Gallary (INNailGun) -> PB_MGNail (was IN_MGNail A_FireCustomMissile)
//
// === PB Staging state-call upgrades — see AGENTS.md "PB Staging Fire-State Standards" ===
// PB_GunSmoke(d1,d2,d3)         — replaces A_FireCustomMissile("GunFireSmoke"); CVar-gated, FX-throttled
// PB_GunSmoke_Deagle/Sniper/... — weapon-class smoke variants when stock puff is too weak/strong
// PB_SpawnCasing(class,x,y,z)   — replaces PistolCasingSpawner / RifleCaseSpawn missiles
// PB_GunShot(shot,mech,tailIn,tailOut) — combined shot + mech + tail + low-ammo warning
// PB_FireOffset()               — visual recoil spread before fire (rifles/SMGs)
// PB_LowAmmoSoundWarning(type)  — call on fire; type = "pistol"|"Shotgun"|"sniper"|etc.
// Keep A_RailAttack + PB_alttracer branches — PB_FireBullets handles damage tracers when CVar off
//
// === Exempt from PB_FireBullets (keep A_FireBullets / A_FireProjectile) ===
// PowerOverwhelming — FastProjectile tracers (OverwhelmingTracer), not hitscan
// AutoCannon        — guided laser (GuidedLaser puff via explicit-angle A_FireBullets)
// Extinction_Ray      — IN_LaserShot / IN_LaserRay energy (not ballistic)
// DTPISTOL            — Hellbullet energy projectiles (A_FireProjectile)
// BattleAxe+Shield  — melee shield blast (skipped)
// Equipment / grenades / melee wheels — not firearms

extend class PB_WeaponBase
{
	action void PBWP_Fire_9mm(int amount, double spread)
	{
		PB_FireBullets("PB_9x19mm", amount, spread, 0, 0, spread);
	}

	action void PBWP_Fire_9mmHP(int amount, double spread)
	{
		PB_FireBullets("PB_9x19mmHollowPoint", amount, spread, 0, 0, spread);
	}

	action void PBWP_Fire_45ACP(int amount, double spread)
	{
		PB_FireBullets("PB_45ACP", amount, spread, 0, 0, spread);
	}

	action void PBWP_Fire_500SW(int amount, double spread)
	{
		PB_FireBullets("PB_500SW", amount, spread, 0, 0, spread);
	}

	action void PBWP_Fire_556(int amount, double spread)
	{
		PB_FireBullets("PB_556x45mm", amount, spread, 0, 0, spread);
	}

	action void PBWP_Fire_762(int amount, double spread)
	{
		PB_FireBullets("PB_762x51mm", amount, spread, 0, 0, spread);
	}

	action void PBWP_Fire_762AP(int amount, double spread)
	{
		PB_FireBullets("PB_762x51mmAP", amount, spread, 0, 0, spread);
	}

	action void PBWP_Fire_10x24(int amount, double spread)
	{
		PB_FireBullets("PB_10x24mm", amount, spread, 0, 0, spread);
	}

	action void PBWP_Fire_12GABuckshot(int pellets, double spread)
	{
		PB_FireBullets("PB_12GAPellet", pellets, spread, 0, 0, spread);
	}

	action void PBWP_Fire_10GABuckshot(int pellets, double spread)
	{
		PB_FireBullets("PB_10GAPellet", pellets, spread, 0, 0, spread);
	}

	action void PBWP_Fire_12GASlug(int amount, double spread)
	{
		PB_FireBullets("PB_12GASlug", amount, spread, 0, 0, spread);
	}
}
