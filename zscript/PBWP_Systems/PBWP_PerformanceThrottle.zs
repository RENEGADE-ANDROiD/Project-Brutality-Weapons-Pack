// PBWP cosmetic-FX throttle (pattern from PB 2022 killstreak / burn-FX throttles).
// Uses PDA's pb_performance_fire when present; pbwp_fx_throttle adds burst-combat gating.

enum PBWP_FXThrottleTune
{
	PBWP_FX_SOFT = 6,
	PBWP_FX_WINDOW_TICS = 105
};

class PBWP_FXThrottleHandler : StaticEventHandler
{
	// NOTE: UZDoom 4.14 doesn't allow `static` member fields here, and `clearscope`
	// helpers cannot mutate instance state. So we keep instance fields and only use
	// play-scope methods (no `clearscope`) for read/write.
	int eventCount[MAXPLAYERS];
	int windowStartTic[MAXPLAYERS];

	static PBWP_FXThrottleHandler Get()
	{
		return PBWP_FXThrottleHandler(StaticEventHandler.Find("PBWP_FXThrottleHandler"));
	}

	static bool PerformanceFireEnabled()
	{
		let c = CVar.GetCVar("pb_performance_fire");
		return c && c.GetBool();
	}

	static bool ThrottleEnabled()
	{
		let c = CVar.GetCVar("pbwp_fx_throttle");
		return c == null || c.GetBool();
	}

	void ResetAll()
	{
		for (int i = 0; i < MAXPLAYERS; i++)
		{
			eventCount[i] = 0;
			windowStartTic[i] = 0;
		}
	}

	override void WorldLoaded(WorldEvent e)
	{
		ResetAll();
	}

	void RegisterEvent(int pnum)
	{
		if (pnum < 0 || pnum >= MAXPLAYERS)
			return;
		if (level.maptime - windowStartTic[pnum] > PBWP_FX_WINDOW_TICS)
		{
			eventCount[pnum] = 0;
			windowStartTic[pnum] = level.maptime;
		}
		eventCount[pnum]++;
	}

	int DensityLevel(int pnum)
	{
		int n = eventCount[pnum];
		int soft = PBWP_FX_SOFT;
		if (n < soft + 1)
			return 0;
		if (n < soft + 4)
			return 1;
		if (n < soft + 8)
			return 2;
		return 3;
	}

	static bool PassDensityGate(int lvl)
	{
		if (lvl >= 3)
			return random(0, 3) == 0;
		if (lvl >= 2)
			return random(0, 1) == 0;
		if (lvl >= 1)
			return random(0, 3) != 3;
		return true;
	}

	static int PlayerNumFromActor(Actor mo)
	{
		let p = PlayerPawn(mo);
		if (!p)
			return -1;
		return p.PlayerNumber();
	}

	static void RegisterCombatEvent(Actor mo)
	{
		if (!ThrottleEnabled())
			return;
		let h = Get();
		if (h) h.RegisterEvent(PlayerNumFromActor(mo));
	}

	static bool ShouldSpawnCosmeticFX(Actor context = null)
	{
		if (PerformanceFireEnabled())
			return false;
		if (!ThrottleEnabled())
			return true;
		let h = Get();
		if (!h)
			return true;
		int pnum = PlayerNumFromActor(context);
		if (pnum < 0)
			return PassDensityGate(0);
		return PassDensityGate(h.DensityLevel(pnum));
	}

	static bool ShouldSpawnCasingSmoke()
	{
		if (PerformanceFireEnabled())
			return false;
		let cheap = CVar.GetCVar("pb_cheapcasings");
		if (cheap && cheap.GetBool())
			return false;
		return ShouldSpawnCosmeticFX();
	}
}
