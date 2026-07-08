enum cl_FXThrottleTune
	{
	cl_FX_SOFT = 6,
	cl_FX_WINDOW_TICS = 105
	};

class cl_FXThrottleState : Thinker
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
		if (level.maptime - WindowStartTic[pnum] > cl_FX_WINDOW_TICS)
			{
			EventCount[pnum] = 0;
			WindowStartTic[pnum] = level.maptime;
			}
		EventCount[pnum]++;
		}

	int DensityLevel(int pnum)
		{
		int n = EventCount[pnum];
		int soft = cl_FX_SOFT;
		if (n < soft + 1)
			return 0;
		if (n < soft + 4)
			return 1;
		if (n < soft + 8)
			return 2;
		return 3;
		}
	}

class cl_FXThrottleCore play
	{
	static cl_FXThrottleState GetThinker()
		{
		ThinkerIterator it = ThinkerIterator.Create("cl_FXThrottleState");
		Thinker t;
		while (t = it.Next())
			{
			return cl_FXThrottleState(t);
			}
		return cl_FXThrottleState(new("cl_FXThrottleState"));
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
		// Optional: honor external TC performance CVARs when present (ignored if absent).
		let lite = CVar.FindCVar("cl_performance_lite");
		if (lite && lite.GetBool())
			return true;
		let ext = CVar.FindCVar("pb_performance_fire");
		return ext && ext.GetBool();
		}

	static bool ThrottleEnabled()
		{
		let c = CVar.FindCVar("cl_fx_throttle");
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
	}

class cl_FXThrottleHandler : StaticEventHandler
	{
	clearscope static cl_FXThrottleHandler Get()
		{
		return cl_FXThrottleHandler(StaticEventHandler.Find("cl_FXThrottleHandler"));
		}

	static bool PerformanceFireEnabled()
		{
		return cl_FXThrottleCore.PerformanceFireEnabled();
		}

	static bool ThrottleEnabled()
		{
		return cl_FXThrottleCore.ThrottleEnabled();
		}

	override void WorldLoaded(WorldEvent e)
		{
		cl_FXThrottleCore.ResetAll();
		}

	static void RegisterCombatEvent(Actor mo)
		{
		cl_FXThrottleCore.RegisterCombatEvent(mo);
		}

	static bool ShouldSpawnCosmeticFX(Actor context = null)
		{
		return cl_FXThrottleCore.ShouldSpawnCosmeticFX(context);
		}
	}
