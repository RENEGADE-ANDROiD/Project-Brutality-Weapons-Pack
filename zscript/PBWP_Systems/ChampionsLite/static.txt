enum cl_Traits
	{
	trait_Bulwark,
	trait_Brute,
	trait_Swift,
	trait_Volatile,
	trait_Toxic,
	trait_Blink,
	trait_Stalker,
	trait_Splitter,
	trait_Veteran,
	trait_Captain,
	}

enum cl_Mutations
	{
	mutation_None,
	mutation_Giant,
	mutation_Spectral,
	mutation_Rampage,
	};

class cl_Static
	{
	static bool cl_ActorIsUsable(Actor mob)
		{
		if (!mob)
			return false;
		if (!mob.bISMONSTER)
			return false;
		if (mob.health <= 0)
			return false;
		return true;
		}

	static bool cl_CapsEnabled()
		{
		let c = CVar.FindCVar("cl_cap_enabled");
		return c == null || c.GetBool();
		}

	static int cl_GetMapCap()
		{
		if (!cl_CapsEnabled())
			return 99999;

		int total = level.total_monsters;
		int mediumAt = cl_ReturnCVAR("cl_cap_medium_count");
		int largeAt = cl_ReturnCVAR("cl_cap_large_count");

		if (total >= largeAt)
			return cl_ReturnCVAR("cl_cap_large");
		if (total >= mediumAt)
			return cl_ReturnCVAR("cl_cap_medium");
		return cl_ReturnCVAR("cl_cap_small");
		}

	static bool cl_VisibilityFXEnabled()
		{
		let c = CVar.FindCVar("cl_fx_visibility");
		return c == null || c.GetBool();
		}

	static bool cl_PlayerCanSeeActor(Actor mo)
		{
		if (!mo)
			return false;

		for (int i = 0; i < MAXPLAYERS; i++)
			{
			if (!playeringame[i])
				continue;
			let p = players[i].mo;
			if (!p)
				continue;
			if (mo.Distance2D(p) <= 384)
				return true;
			}
		return false;
		}

	static bool cl_CosmeticFXVisible(Actor mo)
		{
		if (!cl_ActorIsUsable(mo))
			return false;
		if (!cl_VisibilityFXEnabled())
			return true;
		return cl_PlayerCanSeeActor(mo);
		}

	static bool cl_IsFireDamage(Name damageType)
		{
		return damageType == 'Fire'
			|| damageType == 'Burn'
			|| damageType == 'Flame'
			|| damageType == 'HellFire'
			|| damageType == 'Heat'
			|| damageType == 'Lava';
		}

	static bool cl_IsExplosionDamage(Name damageType)
		{
		return damageType == 'Explosion'
			|| damageType == 'Radius'
			|| damageType == 'Crush'
			|| damageType == 'Blast';
		}

	static bool cl_OwnerResistsToxic(Actor mo)
		{
		if (!mo)
			return false;
		if (mo.CountInv("PowerIronFeet"))
			return true;
		if (mo.CountInv("PowerMask"))
			return true;
		return false;
		}

	static const class<inventory> cl_Tokens[] =
		{
		"cl_BulwarkToken", "cl_BruteToken", "cl_SwiftToken", "cl_VolatileToken",
		"cl_ToxicToken", "cl_BlinkToken", "cl_StalkerToken", "cl_SplitterToken",
		"cl_VeteranToken", "cl_CaptainToken"
		};

	static int cl_ReturnCVAR(name c)
		{
		cvar cv = CVar.FindCVar(c);
		if (cv) { return cv.GetInt(); }
		return 0;
		}

	static double cl_ReturnCVARFloat(name c)
		{
		cvar cv = CVar.FindCVar(c);
		if (cv) { return cv.GetFloat(); }
		return 0;
		}
	}

class cl_Sounds play
	{
	static void PlayPickup(Actor mo, double volume = 1.0, double pitch = 1.0)
		{
		if (gameinfo.gametype == GAME_Heretic)
			mo.A_StartSound("heretic/pickup", CHAN_BODY, CHANF_NOPAUSE, volume, ATTN_NORM, pitch);
		else if (gameinfo.gametype == GAME_Hexen)
			mo.A_StartSound("hexen/pickup", CHAN_BODY, CHANF_NOPAUSE, volume, ATTN_NORM, pitch);
		else
			mo.A_StartSound("misc/pickup", CHAN_BODY, CHANF_NOPAUSE, volume, ATTN_NORM, pitch);
		}

	static void PlayExplosion(Actor mo)
		{
		if (gameinfo.gametype == GAME_Heretic)
			mo.A_StartSound("heretic/wandhit", CHAN_AUTO);
		else if (gameinfo.gametype == GAME_Hexen)
			mo.A_StartSound("hexen/spark1", CHAN_AUTO);
		else
			mo.A_StartSound("weapons/rocklx", CHAN_AUTO);
		}

	static void PlayArmorBreak(Actor mo, double volume = 1.0, double pitch = 1.0)
		{
		if (gameinfo.gametype == GAME_Heretic)
			mo.A_StartSound("heretic/gldhit", CHAN_BODY, CHANF_NOPAUSE, volume, ATTN_NORM, pitch);
		else if (gameinfo.gametype == GAME_Hexen)
			mo.A_StartSound("hexen/metalhit", CHAN_BODY, CHANF_NOPAUSE, volume, ATTN_NORM, pitch);
		else
			mo.A_StartSound("weapons/rocklx", CHAN_BODY, CHANF_NOPAUSE, volume, ATTN_NORM, pitch);
		}
	}
