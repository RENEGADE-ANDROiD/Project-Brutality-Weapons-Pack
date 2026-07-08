// PBWP Mega Rig — five-weapon bottom arc (center hero + inner pair + outer wings).
// Layering: inner pair behind; center + outers in front.

enum EMegaRigAttack
{
	MRG_ATK_NONE = 0,
	MRG_ATK_PROJ_556,
	MRG_ATK_PROJ_762,
	MRG_ATK_PROJ_9MM,
	MRG_ATK_PROJ_SHOTGUN,
	MRG_ATK_PROJ_NAIL,
	MRG_ATK_MISSILE_ROCKET,
	MRG_ATK_MISSILE_ENERGY,
	MRG_ATK_MISSILE_PLASMA,
	MRG_ATK_MISSILE_BFG,
	MRG_ATK_MISSILE_GAUSS
}

enum EMegaRigLayout
{
	MRG_CATALOG_ENTRIES = 24,
	MRG_SLOT_COUNT = 5,
	MRG_LOADOUT_COUNT = 4,
	MRG_SLOT_OUTER_L = 0,
	MRG_SLOT_INNER_L = 1,
	MRG_SLOT_CENTER = 2,
	MRG_SLOT_INNER_R = 3,
	MRG_SLOT_OUTER_R = 4,
	MRG_OVERLAY_LAYER_MIN = -875,
	MRG_OVERLAY_LAYER_MAX = -870
}

struct MegaRigCatalogEntry
{
	Name sourceClass;
	Name spritePrefix;
	Name fireSpritePrefix;
	Sound fireSound;
	int readyFrame;
	int fireFrame;
	int fireFrameCount;
	int volleyHoldTics;
	double recoilKickX;
	double recoilKickY;
	double muzzleSide;
	double muzzleHeight;
	double muzzleForward;
	EMegaRigAttack attack;
	double spread;
	double pitch;
	bool isTall;
	bool isHero;
}

struct MegaRigSlotAnchor
{
	double offsetX;
	double offsetY;
	double roll;
	double scale;
}

class PB_MegaRigCatalog
{
	static int LayerForSlot(int slot)
	{
		// Less-negative layers draw in front. Inner pair sits behind center + wings.
		switch (slot)
		{
			case MRG_SLOT_INNER_L: return -875;
			case MRG_SLOT_INNER_R: return -874;
			case MRG_SLOT_CENTER:  return -871;
			case MRG_SLOT_OUTER_L: return -872;
			default:               return -870; // MRG_SLOT_OUTER_R
		}
	}

	// Tight bottom cluster — positive offsetY hides grips below the HUD band.
	// Inners sit under center + wings to conceal duplicate hand sprites.
	static void GetAnchor(int slot, out MegaRigSlotAnchor a)
	{
		switch (slot)
		{
			case MRG_SLOT_OUTER_L:
				a.offsetX =  -88; a.offsetY = 44; a.roll = 18;  a.scale = 0.74; break;
			case MRG_SLOT_INNER_L:
				a.offsetX =  -36; a.offsetY = 40; a.roll =  6;  a.scale = 0.64; break;
			case MRG_SLOT_CENTER:
				a.offsetX =    0; a.offsetY = 38; a.roll =  0;  a.scale = 0.86; break;
			case MRG_SLOT_INNER_R:
				a.offsetX =   36; a.offsetY = 40; a.roll = -6;  a.scale = 0.64; break;
			default: // MRG_SLOT_OUTER_R
				a.offsetX =   88; a.offsetY = 44; a.roll = -18; a.scale = 0.74; break;
		}
	}

	static bool IsHeavyAttack(EMegaRigAttack attack)
	{
		return attack == MRG_ATK_MISSILE_ROCKET
			|| attack == MRG_ATK_MISSILE_ENERGY
			|| attack == MRG_ATK_MISSILE_PLASMA
			|| attack == MRG_ATK_MISSILE_BFG
			|| attack == MRG_ATK_MISSILE_GAUSS
			|| attack == MRG_ATK_PROJ_NAIL;
	}

	static bool SlotIsCenter(int slot)
	{
		return slot == MRG_SLOT_CENTER;
	}

	static bool SlotIsCenterpiece(int loadoutSet, int slot, int catalogIndex)
	{
		return slot == MRG_SLOT_CENTER && catalogIndex == GetCenterpieceIndex(loadoutSet);
	}

	static int GetCenterpieceIndex(int loadoutSet)
	{
		switch (loadoutSet)
		{
			case 0: return 1;  // IN Minigun (large, minimal grip)
			case 1: return 9;  // Gauss Cannon
			case 2: return 15; // Demon-Tech Minigun
			default: return 22; // Satan Scream
		}
	}

	// Presets: no melee, RPG/rockets, BFG, or Stormcast. Center = hero weapon.
	static int GetPresetEntry(int loadoutSet, int slot)
	{
		switch (loadoutSet)
		{
			case 0: // ballistic — minigun hero
				switch (slot)
				{
					case MRG_SLOT_OUTER_L: return 2;  // UZI (left hand)
					case MRG_SLOT_INNER_L: return 0;  // Assault Rifle
					case MRG_SLOT_CENTER:  return 1;  // IN Minigun
					case MRG_SLOT_INNER_R: return 5;  // Marauder SSG
					default:               return 3;  // Kar98k (right hand)
				}
			case 1: // energy + gauss
				switch (slot)
				{
					case MRG_SLOT_OUTER_L: return 7;  // Hell Pistoler
					case MRG_SLOT_INNER_L: return 8;  // Plasmastinger
					case MRG_SLOT_CENTER:  return 9;  // Gauss Cannon
					case MRG_SLOT_INNER_R: return 6;  // M60
					default:               return 2;  // UZI
				}
			case 2: // heavy automatics
				switch (slot)
				{
					case MRG_SLOT_OUTER_L: return 20; // Rotational SG
					case MRG_SLOT_INNER_L: return 14; // Hell Pistol
					case MRG_SLOT_CENTER:  return 15; // Demon-Tech Minigun
					case MRG_SLOT_INNER_R: return 5;  // Marauder SSG
					default:               return 19; // Dual UZI
				}
			default: // exotic mix
				switch (slot)
				{
					case MRG_SLOT_OUTER_L: return 17; // M1887
					case MRG_SLOT_INNER_L: return 13; // Nail Gun
					case MRG_SLOT_CENTER:  return 22; // Satan Scream
					case MRG_SLOT_INNER_R: return 14; // Hell Pistol
					default:               return 7;  // Hell Pistoler
				}
		}
	}

	static void InitEntry(out MegaRigCatalogEntry e)
	{
		e.spread = 2.0;
		e.pitch = 0;
		e.isTall = false;
		e.isHero = false;
		e.fireSpritePrefix = 'None';
		e.fireSound = "";
		e.fireFrameCount = 1;
		e.volleyHoldTics = 3;
		e.recoilKickX = 0;
		e.recoilKickY = -3;
		e.muzzleSide = 0;
		e.muzzleHeight = 4;
		e.muzzleForward = 0;
	}

	static void ApplyFireProfile(out MegaRigCatalogEntry e, int frameCount, int holdTics,
		double recoilY, double recoilX = 0, double mSide = 0, double mHeight = 4, double mForward = 0)
	{
		e.fireFrameCount = max(1, frameCount);
		e.volleyHoldTics = max(2, holdTics);
		e.recoilKickY = recoilY;
		e.recoilKickX = recoilX;
		e.muzzleSide = mSide;
		e.muzzleHeight = mHeight;
		e.muzzleForward = mForward;
	}

	// Map overlay anchor positions to approximate muzzle spawn offsets for attacks.
	static void GetMuzzleOffsets(int slot, int loadoutSet, int catalogIndex, MegaRigCatalogEntry entry,
		out double side, out double height, out double forward)
	{
		MegaRigSlotAnchor a;
		GetAnchor(slot, a);

		double scale = a.scale;
		if (SlotIsCenterpiece(loadoutSet, slot, catalogIndex))
			scale += 0.10;

		side = a.offsetX * 0.40 + entry.muzzleSide;
		height = entry.muzzleHeight - (a.offsetY - 36) * 0.13;
		forward = entry.muzzleForward;

		if (entry.isHero)
		{
			height -= 1.5;
			forward += 3;
		}
		if (entry.isTall)
		{
			height -= 1;
			forward += 2;
		}

		// Slight barrel yaw from wing tilt so outer slots lead their tracers.
		if (slot == MRG_SLOT_OUTER_L || slot == MRG_SLOT_OUTER_R)
			side += a.roll * 0.08;
	}

	static void ApplyDefaultFireSound(out MegaRigCatalogEntry e)
	{
		if (e.fireSound)
			return;
		switch (e.attack)
		{
			case MRG_ATK_PROJ_556:      e.fireSound = "Fire/MSKAR2"; break;
			case MRG_ATK_PROJ_762:      e.fireSound = "DSMINIGV"; break;
			case MRG_ATK_PROJ_9MM:       e.fireSound = "Fire/FaDD"; break;
			case MRG_ATK_PROJ_SHOTGUN:   e.fireSound = "Shotgun/Fire"; break;
			case MRG_ATK_PROJ_NAIL:      e.fireSound = "weapons/nailgun/fire"; break;
			case MRG_ATK_MISSILE_ROCKET: e.fireSound = "weapons/rocket/fire"; break;
			case MRG_ATK_MISSILE_ENERGY: e.fireSound = "weapons/plasma/fire"; break;
			case MRG_ATK_MISSILE_PLASMA: e.fireSound = "weapons/plasma/fire"; break;
			case MRG_ATK_MISSILE_BFG:    e.fireSound = "BFG2704/Fire"; break;
			case MRG_ATK_MISSILE_GAUSS:  e.fireSound = "weapons/gauss/fire"; break;
			default:                     e.fireSound = "Fire/FaDD"; break;
		}
	}

	static String GetLoadoutDisplayName(int loadoutSet)
	{
		switch (loadoutSet % MRG_LOADOUT_COUNT)
		{
			case 0: return "Ballistic";
			case 1: return "Energy";
			case 2: return "Heavy";
			default: return "Exotic";
		}
	}

	static Sound GetLoadoutSwitchSound(int loadoutSet)
	{
		switch (loadoutSet % MRG_LOADOUT_COUNT)
		{
			case 0: return "MS_SLCT";
			case 1: return "weapons/plasma/select";
			case 2: return "HMGUP";
			default: return "BFG2704/Select";
		}
	}

	static int GetVolleyFireOrder(int step)
	{
		switch (step)
		{
			case 0: return MRG_SLOT_OUTER_L;
			case 1: return MRG_SLOT_INNER_L;
			case 2: return MRG_SLOT_CENTER;
			case 3: return MRG_SLOT_INNER_R;
			default: return MRG_SLOT_OUTER_R;
		}
	}

	static void GetEntry(int index, out MegaRigCatalogEntry e)
	{
		InitEntry(e);
		switch (index)
		{
			case 0: // Assault Rifle — MRKF flash strip
				e.sourceClass = 'AssaultR1'; e.spritePrefix = 'MRKR'; e.fireSpritePrefix = 'MRKF';
				e.readyFrame = 0; e.fireFrame = 0;
				e.attack = MRG_ATK_PROJ_556; e.spread = 1.5;
				ApplyFireProfile(e, 4, 3, -3, 0, 1, 5, 0);
				break;
			case 1: // IN Minigun — CGLF spin
				e.sourceClass = 'INMiniGun'; e.spritePrefix = 'CGLX'; e.fireSpritePrefix = 'CGLF';
				e.readyFrame = 0; e.fireFrame = 0;
				e.attack = MRG_ATK_PROJ_762; e.spread = 3.0; e.isTall = true; e.isHero = true;
				ApplyFireProfile(e, 4, 5, -5, 0, 0, 3, 0);
				break;
			case 2: // UZI
				e.sourceClass = 'INMiniGun'; e.spritePrefix = 'UZIF';
				e.readyFrame = 4; e.fireFrame = 0;
				e.attack = MRG_ATK_PROJ_9MM; e.spread = 2.5;
				ApplyFireProfile(e, 3, 2, -2, 0, 2, 4, 0);
				break;
			case 3: // Kar98k
				e.sourceClass = 'PB_Kar98k'; e.spritePrefix = 'ZK9G';
				e.readyFrame = 0; e.fireFrame = 1;
				e.attack = MRG_ATK_PROJ_762; e.spread = 0.4;
				ApplyFireProfile(e, 2, 4, -6, 0, 0, 6, 0);
				break;
			case 4:
				e.sourceClass = 'PB_HYDRA'; e.spritePrefix = 'J5GG';
				e.readyFrame = 0; e.fireFrame = 4;
				e.attack = MRG_ATK_MISSILE_ROCKET; e.spread = 1.0; e.isTall = true;
				ApplyFireProfile(e, 3, 4, -7, 0, 0, 5, 6);
				break;
			case 5: // Marauder SSG
				e.sourceClass = 'MarauderSSG'; e.spritePrefix = 'MXSG';
				e.readyFrame = 0; e.fireFrame = 2;
				e.attack = MRG_ATK_PROJ_SHOTGUN; e.spread = 5.0;
				ApplyFireProfile(e, 4, 4, -7, 0, 0, 4, 0);
				break;
			case 6: // M60 (Nemesis LMG removed)
				e.sourceClass = 'M60'; e.spritePrefix = 'M60G';
				e.readyFrame = 0; e.fireFrame = 7;
				e.attack = MRG_ATK_PROJ_762; e.spread = 2.0; e.isTall = true;
				ApplyFireProfile(e, 3, 4, -4, 0, 0, 4, 0);
				break;
			case 7: // Hell Pistoler
				e.sourceClass = 'HellPistoler'; e.spritePrefix = 'AMGL'; e.fireSpritePrefix = 'AMGF';
				e.readyFrame = 0; e.fireFrame = 3;
				e.attack = MRG_ATK_MISSILE_ENERGY; e.spread = 0.8;
				ApplyFireProfile(e, 6, 3, -3, 1, 4, 5, 1);
				break;
			case 8: // Plasmastinger
				e.sourceClass = 'Plasmastinger'; e.spritePrefix = 'STIN';
				e.readyFrame = 0; e.fireFrame = 1;
				e.attack = MRG_ATK_MISSILE_PLASMA; e.spread = 0.6;
				ApplyFireProfile(e, 3, 3, -3, 0, 0, 4, 2);
				break;
			case 9: // Gauss Cannon
				e.sourceClass = 'PB_GaussCannon'; e.spritePrefix = 'GCSF';
				e.readyFrame = 0; e.fireFrame = 1;
				e.attack = MRG_ATK_MISSILE_GAUSS; e.spread = 0; e.isTall = true; e.isHero = true;
				ApplyFireProfile(e, 3, 6, -9, 0, 0, 2, 10);
				break;
			case 10:
				e.sourceClass = 'NemesisBFG'; e.spritePrefix = 'NMB8';
				e.readyFrame = 16; e.fireFrame = 17;
				e.attack = MRG_ATK_MISSILE_BFG; e.spread = 0; e.isTall = true;
				ApplyFireProfile(e, 2, 5, -8, 0, 0, 3, 4);
				break;
			case 11:
				e.sourceClass = 'Devastador'; e.spritePrefix = 'BF27';
				e.readyFrame = 0; e.fireFrame = 3;
				e.attack = MRG_ATK_MISSILE_BFG; e.spread = 0; e.isTall = true;
				ApplyFireProfile(e, 3, 5, -8, 0, 0, 3, 4);
				break;
			case 12:
				e.sourceClass = 'LegendaryAssaultShotgun'; e.spritePrefix = 'LMAG';
				e.readyFrame = 0; e.fireFrame = 1;
				e.attack = MRG_ATK_PROJ_SHOTGUN; e.spread = 4.0;
				ApplyFireProfile(e, 3, 3, -6, 0, 0, 4, 0);
				break;
			case 13: // Nail Gun
				e.sourceClass = 'Tactical_Nail_Gun'; e.spritePrefix = '7HRG'; e.fireSpritePrefix = '7HRN';
				e.readyFrame = 0; e.fireFrame = 1;
				e.attack = MRG_ATK_PROJ_NAIL; e.spread = 1.2;
				ApplyFireProfile(e, 2, 3, -3, 0, 0, 3, 0);
				break;
			case 14: // Hell Pistol
				e.sourceClass = 'HellPistol'; e.spritePrefix = 'DTPS';
				e.readyFrame = 0; e.fireFrame = 1;
				e.attack = MRG_ATK_MISSILE_ENERGY; e.spread = 1.0;
				ApplyFireProfile(e, 3, 2, -2, 1, 3, 5, 1);
				break;
			case 15: // Demon-Tech Minigun
				e.sourceClass = 'DemonTechMinigun'; e.spritePrefix = 'DTM1'; e.fireSpritePrefix = 'DTM0';
				e.readyFrame = 0; e.fireFrame = 0;
				e.attack = MRG_ATK_PROJ_762; e.spread = 3.5; e.isTall = true; e.isHero = true;
				ApplyFireProfile(e, 3, 5, -5, 0, 0, 3, 0);
				break;
			case 16:
				e.sourceClass = 'BFG9500'; e.spritePrefix = 'BF9G';
				e.readyFrame = 0; e.fireFrame = 3;
				e.attack = MRG_ATK_MISSILE_BFG; e.spread = 0; e.isTall = true;
				ApplyFireProfile(e, 3, 5, -8, 0, 0, 3, 4);
				break;
			case 17: // M1887
				e.sourceClass = 'M1887'; e.spritePrefix = 'M87G'; e.fireSpritePrefix = 'M87F';
				e.readyFrame = 0; e.fireFrame = 0;
				e.attack = MRG_ATK_PROJ_SHOTGUN; e.spread = 4.0;
				ApplyFireProfile(e, 2, 3, -6, 0, 0, 4, 0);
				break;
			case 18:
				e.sourceClass = 'Stormcast'; e.spritePrefix = 'CONE';
				e.readyFrame = 0; e.fireFrame = 2;
				e.attack = MRG_ATK_MISSILE_ROCKET; e.spread = 1.5; e.isTall = true;
				ApplyFireProfile(e, 3, 4, -7, 0, 0, 5, 6);
				break;
			case 19: // Dual UZI
				e.sourceClass = 'INMiniGun'; e.spritePrefix = 'UZI2';
				e.readyFrame = 4; e.fireFrame = 5;
				e.attack = MRG_ATK_PROJ_9MM; e.spread = 2.8;
				ApplyFireProfile(e, 3, 3, -3, 0, 0, 4, 0);
				break;
			case 20: // Rotational SG
				e.sourceClass = 'RotationalSG'; e.spritePrefix = 'CLGK'; e.fireSpritePrefix = 'CSLF';
				e.readyFrame = 0; e.fireFrame = 0;
				e.attack = MRG_ATK_PROJ_SHOTGUN; e.spread = 4.5;
				ApplyFireProfile(e, 3, 3, -6, 0, 0, 4, 0);
				break;
			case 21:
				e.sourceClass = 'PhaseEradicatorBFG'; e.spritePrefix = 'PRDC';
				e.readyFrame = 0; e.fireFrame = 3;
				e.attack = MRG_ATK_MISSILE_BFG; e.spread = 0; e.isTall = true;
				ApplyFireProfile(e, 3, 5, -8, 0, 0, 3, 4);
				break;
			case 22: // Satan Scream
				e.sourceClass = 'Satan_Scream'; e.spritePrefix = 'HG2G';
				e.readyFrame = 0; e.fireFrame = 7;
				e.attack = MRG_ATK_MISSILE_ENERGY; e.spread = 1.0; e.isTall = true; e.isHero = true;
				ApplyFireProfile(e, 4, 5, -7, 0, 0, 4, 3);
				break;
			default:
				e.sourceClass = 'AssaultR1'; e.spritePrefix = 'MRKR'; e.fireSpritePrefix = 'MRKF';
				e.readyFrame = 0; e.fireFrame = 0;
				e.attack = MRG_ATK_PROJ_556;
				ApplyFireProfile(e, 4, 3, -3, 0, 1, 5, 0);
				break;
		}
		ApplyDefaultFireSound(e);
	}
}
