// PBWP cosmetic-FX throttle (pattern from PB 2022 killstreak / burn-FX throttles).
// Uses PDA's pb_performance_fire when present; pbwp_fx_throttle adds burst-combat gating.
// State lives in PBWP_FXThrottleCore (via BaseWeapon_Functions.zsc in the shared weapon TU).

class PBWP_FXThrottleHandler : StaticEventHandler
{
	clearscope static PBWP_FXThrottleHandler Get()
	{
		return PBWP_FXThrottleHandler(StaticEventHandler.Find("PBWP_FXThrottleHandler"));
	}

	static bool PerformanceFireEnabled()
	{
		return PBWP_FXThrottleCore.PerformanceFireEnabled();
	}

	static bool ThrottleEnabled()
	{
		return PBWP_FXThrottleCore.ThrottleEnabled();
	}

	override void WorldLoaded(WorldEvent e)
	{
		PBWP_FXThrottleCore.ResetAll();
	}

	static void RegisterCombatEvent(Actor mo)
	{
		PBWP_FXThrottleCore.RegisterCombatEvent(mo);
	}

	static bool ShouldSpawnCosmeticFX(Actor context = null)
	{
		return PBWP_FXThrottleCore.ShouldSpawnCosmeticFX(context);
	}

	static bool ShouldSpawnCasingSmoke(Actor context = null)
	{
		return PBWP_FXThrottleCore.ShouldSpawnCasingSmoke(context);
	}
}
