// Shared cosmetic-FX throttle state — included from PBWP ZSCRIPT.zc and lump-shadowed
// BaseWeapon_Functions.zsc (separate translation unit from PBWP handlers).
enum PBWP_FXThrottleTune
{
	PBWP_FX_SOFT = 6,
	PBWP_FX_WINDOW_TICS = 105
};

class PBWP_FXThrottleState : Thinker
{
	int EventCount[MAXPLAYERS];
	int WindowStartTic[MAXPLAYERS];

	void ResetAll()
	{
		for (int i = 0; i < MAXPLAYERS; i++)
		{
			EventCount[i] = 0;
			WindowStartTic[i] = 0;
		}
	}

	void RegisterEvent(int pnum)
	{
		if (pnum < 0 || pnum >= MAXPLAYERS)
			return;
		if (level.maptime - WindowStartTic[pnum] > PBWP_FX_WINDOW_TICS)
		{
			EventCount[pnum] = 0;
			WindowStartTic[pnum] = level.maptime;
		}
		EventCount[pnum]++;
	}

	int DensityLevel(int pnum)
	{
		int n = EventCount[pnum];
		int soft = PBWP_FX_SOFT;
		if (n < soft + 1)
			return 0;
		if (n < soft + 4)
			return 1;
		if (n < soft + 8)
			return 2;
		return 3;
	}
}

class PBWP_FXThrottleCore play
{
	static PBWP_FXThrottleState GetThinker()
	{
		foreach (t : ThinkerIterator.Create("PBWP_FXThrottleState"))
			return PBWP_FXThrottleState(t);
		return PBWP_FXThrottleState(new("PBWP_FXThrottleState"));
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

	static int PlayerNumFromActor(Actor mo)
	{
		let p = PlayerPawn(mo);
		if (!p)
			return -1;
		return p.PlayerNumber();
	}

	static void ResetAll()
	{
		let fxState = GetThinker();
		if (fxState)
			fxState.ResetAll();
	}

	static void RegisterCombatEvent(Actor mo)
	{
		if (!ThrottleEnabled())
			return;
		let fxState = GetThinker();
		if (fxState)
			fxState.RegisterEvent(PlayerNumFromActor(mo));
	}

	static bool ShouldSpawnCosmeticFX(Actor context = null)
	{
		if (PerformanceFireEnabled())
			return false;
		if (!ThrottleEnabled())
			return true;
		let fxState = GetThinker();
		if (!fxState)
			return true;
		int pnum = PlayerNumFromActor(context);
		if (pnum < 0)
			return PassDensityGate(0);
		return PassDensityGate(fxState.DensityLevel(pnum));
	}

	static bool ShouldSpawnCasingSmoke(Actor context = null)
	{
		if (PerformanceFireEnabled())
			return false;
		let cheap = CVar.GetCVar("pb_cheapcasings");
		if (cheap && cheap.GetBool())
			return false;
		return ShouldSpawnCosmeticFX(context);
	}
}
