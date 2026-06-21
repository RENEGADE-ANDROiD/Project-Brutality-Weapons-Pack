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
	// Null-safe liveness check for Actor refs kept across ticks (pending rolls, controllers).
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

	static const class<inventory> cl_Tokens[] =
		{
		"cl_BulwarkToken", "cl_BruteToken", "cl_SwiftToken", "cl_VolatileToken",
		"cl_ToxicToken", "cl_BlinkToken", "cl_StalkerToken", "cl_SplitterToken",
		"cl_VeteranToken"
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
