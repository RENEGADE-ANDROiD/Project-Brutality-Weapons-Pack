// Runtime probes, optional PBX weapon slots, GK achievement hooks.
class PBWP_PBXWeaponSlotHandler : StaticEventHandler
{
	override void PlayerEntered(PlayerEvent e)
	{
		// PBX weapons declare Weapon.SlotNumber in their own classes; KEYCONF also
		// registers slot defaults. There is no PlayerPawn.AddSlotDefault in UZDoom 4.14.
	}
}

class PBWP_GKAchievementHandler : EventHandler
{
	override void NetworkProcess(ConsoleEvent e)
	{
		if (e.Name == "pbwp_glory_kill")
			PB_Achievements.OnGloryKill();
	}
}
