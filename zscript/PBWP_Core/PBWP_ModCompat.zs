// Runtime probes and GK achievement hooks.
class PBWP_GKAchievementHandler : EventHandler
{
	override void NetworkProcess(ConsoleEvent e)
	{
		if (e.Name == "pbwp_glory_kill")
			PB_Achievements.OnGloryKill();
	}
}
