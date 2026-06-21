// Master enable/disable for multi-weapon addon packs (netevent PBWP_Enable* / PBWP_Disable*).
class PBWP_WeaponPackPresets : StaticEventHandler
{
	private static void SetSpawn(String cvarName, bool on)
	{
		let c = CVar.FindCVar(cvarName);
		if (c) c.SetBool(on);
	}

	private static void SetPackToggle(String cvarName, bool on)
	{
		let c = CVar.FindCVar(cvarName);
		if (c) c.SetBool(on);
	}

	private static void SyncAllPackToggles(bool on)
	{
		SetPackToggle("PBWP_Pack_All", on);
		SetPackToggle("PBWP_Pack_GodComplex", on);
		SetPackToggle("PBWP_Pack_Karnage", on);
		SetPackToggle("PBWP_Pack_IN", on);
		SetPackToggle("PBWP_Pack_DTECH", on);
		SetPackToggle("PBWP_Pack_SCHISM", on);
		SetPackToggle("PBWP_Pack_RO", on);
		SetPackToggle("PBWP_Pack_D2016", on);
		SetPackToggle("PBWP_Pack_Duke", on);
		SetPackToggle("PBWP_Pack_PB30", on);
		SetPackToggle("PBWP_Pack_VietDoom", on);
		SetPackToggle("PBWP_Pack_Freezer", on);
		SetPackToggle("PBWP_Pack_Cyberaugumented", on);
	}

	private static void SetMonsterDrop(String cvarName, bool on)
	{
		let c = CVar.FindCVar(cvarName);
		if (c) c.SetBool(on);
	}

	// Map spawns off; monster-drop toggles on (salvage weapons are drop-only).
	private static void SetMonsterDropWeapons(bool on)
	{
		SetMonsterDrop("PBSpawnPaingiverDrop", on);
		SetMonsterDrop("PBSpawnMSSGDrop", on);
		SetMonsterDrop("PBSpawnMancFlameCannonDrop", on);
		SetMonsterDrop("PBSpawnCryoRifleDrop", on);
		SetMonsterDrop("PBSpawnThunderCrossbowDrop", on);
		SetMonsterDrop("PBSpawnStormcastDrop", on);
		SetMonsterDrop("PBSpawnBioAcidLauncherDrop", on);
	}

	static void SetGodComplex(bool on)
	{
		SetSpawn("PBSpawnDevastador", on);
		SetSpawn("PBSpawnEnragedLegendaryBFG", on);
		SetSpawn("PBSpawnGodEnragedBFG", on);
		SetSpawn("PBSpawnLegendaryAssaultShotgun", on);
		SetSpawn("PBSpawnLegendaryChainsaw", on);
		SetSpawn("PBSpawnLegendaryPlasmaticRifle", on);
		SetSpawn("PBSpawnNemesisBFG", on);
		SetSpawn("PBSpawnNemesisLMG", on);
		SetSpawn("PBSpawnLegendaryBFG10K", on);
		SetPackToggle("PBWP_Pack_GodComplex", on);
	}

	static void SetKarnage(bool on)
	{
		SetSpawn("PBSpawnKarnageHandgunG2", on);
		SetSpawn("PBSpawnKarnageMP55", on);
		SetSpawn("PBSpawnKarnageShotgunV1", on);
		SetSpawn("PBSpawnKarnageRainmaker", on);
		SetSpawn("PBSpawnKarnageSSVXAR", on);
		SetSpawn("PBSpawnKarnageGrenadeLauncher", on);
		SetSpawn("PBSpawnKarnagePlasmastinger", on);
		SetPackToggle("PBWP_Pack_Karnage", on);
	}

	static void SetInsanitysNightmare(bool on)
	{
		SetSpawn("PBSpawnHellPistoler", on);
		SetSpawn("PBSpawnIN_Beretta", on);
		SetSpawn("PBSpawnW_SMG", on);
		SetSpawn("PBSpawnRotationalSG", on);
		SetSpawn("PBSpawnHASG", on);
		SetSpawn("PBSpawnAK47", on);
		SetSpawn("PBSpawnAssaultR1", on);
		SetSpawn("PBSpawnBlack_DMR", on);
		SetSpawn("PBSpawnAdv_MaskMan_Rifle", on);
		SetSpawn("PBSpawnMaskMan_Rifle", on);
		SetSpawn("PBSpawnM1X", on);
		SetSpawn("PBSpawnDark_Fate", on);
		SetSpawn("PBSpawnMagnumSniperRifle", on);
		SetSpawn("PBSpawnINNailGun", on);
		SetSpawn("PBSpawnINMiniGun", on);
		SetSpawn("PBSpawnApocalypseKiller", on);
		SetSpawn("PBSpawnChthonicRifle", on);
		SetSpawn("PBSpawnFallen_Hawk", on);
		SetSpawn("PBSpawnSuperGrenadeLauncher", on);
		SetSpawn("PBSpawnPlasmaRifleAssault", on);
		SetSpawn("PBSpawnExtinction_Ray", on);
		SetSpawn("PBSpawnThunderCarrierTI", on);
		SetSpawn("PBSpawnSatan_Scream", on);
		SetMonsterDrop("PBSpawnBioAcidLauncherDrop", on);
		SetSpawn("PBSpawnPB_CalamityBlade", on);
		SetSpawn("PBSpawnIon_Heavy", on);
		SetPackToggle("PBWP_Pack_IN", on);
	}

	static void SetDemonTech(bool on)
	{
		SetSpawn("PBSpawnHellPistol", on);
		SetSpawn("PBSpawnDTShotgun", on);
		SetSpawn("PBSpawnTechBlaster", on);
		SetSpawn("PBSpawnDemonTechMinigun", on);
		SetSpawn("PBSpawnPhaseEradicatorBFG", on);
		SetPackToggle("PBWP_Pack_DTECH", on);
	}

	static void SetSchismFireIce(bool on)
	{
		SetSpawn("PBSpawnBattleAxe", on);
		SetSpawn("PBSpawnFire_and_IceDragonSlayer", on);
		SetMonsterDrop("PBSpawnStormcastDrop", on);
		SetMonsterDrop("PBSpawnThunderCrossbowDrop", on);
		SetPackToggle("PBWP_Pack_SCHISM", on);
	}

	static void SetFreezer(bool on)
	{
		SetMonsterDrop("PBSpawnCryoRifleDrop", on);
		SetSpawn("PBSpawnPB_CryoShotgun", on);
		SetSpawn("SpawnFreezeNade", on);
		SetSpawn("FreezebotSpawn", on);
		SetPackToggle("PBWP_Pack_Freezer", on);
	}

	static void SetRussianOverkill(bool on)
	{
		SetSpawn("PBSpawnRazorjack", on);
		SetSpawn("PBSpawnPowerOverwhelming", on);
		SetPackToggle("PBWP_Pack_RO", on);
	}

	static void SetDoom2016(bool on)
	{
		SetSpawn("PBSpawnPB_Doom2016Shotgun", on);
		SetSpawn("PBSpawnD4Machinegun", on);
		SetSpawn("PBSpawnD4RocketLauncher", on);
		SetSpawn("PBSpawnD4PlasmaGun", on);
		SetSpawn("PBSpawnD4VortexRifle", on);
		SetPackToggle("PBWP_Pack_D2016", on);
	}

	static void SetDuke(bool on)
	{
		SetSpawn("PBSpawnDukeNukemRipper", on);
		SetSpawn("PBSpawnDevastator", on);
		SetSpawn("PBSpawnDukePistol", on);
		SetSpawn("PBSpawnDukeShotgun", on);
		SetSpawn("PBSpawnDukeRPG", on);
		SetSpawn("PBSpawnDukePipebomb", on);
		SetPackToggle("PBWP_Pack_Duke", on);
	}

	static void SetPB30Folded(bool on)
	{
		SetSpawn("PBSpawnX12Shotgun", on);
		SetSpawn("PBSpawnM45Shotgun", on);
		SetSpawn("PBSpawnBFG9500", on);
		SetSpawn("PBSpawnMP12", on);
		SetSpawn("PBSpawnTacticalNailgun", on);
		SetPackToggle("PBWP_Pack_PB30", on);
	}

	static void SetVietDoom(bool on)
	{
		SetSpawn("PBSpawnVietDoom", on);
		SetSpawn("PBSpawnVietM1911", on);
		SetSpawn("PBSpawnVietM3A1", on);
		SetSpawn("PBSpawnVietThompson", on);
		SetSpawn("PBSpawnVietMAT49", on);
		SetSpawn("PBSpawnVietPPSh", on);
		SetSpawn("PBSpawnVietIthaca", on);
		SetSpawn("PBSpawnVietM16", on);
		SetSpawn("PBSpawnVietM14", on);
		SetSpawn("PBSpawnVietXM21", on);
		SetSpawn("PBSpawnVietAK47", on);
		SetSpawn("PBSpawnVietSKS", on);
		SetSpawn("PBSpawnVietMosin", on);
		SetSpawn("PBSpawnVietM60", on);
		SetSpawn("PBSpawnVietBAR", on);
		SetSpawn("PBSpawnVietRPD", on);
		SetSpawn("PBSpawnVietStoner", on);
		SetSpawn("PBSpawnVietRPG", on);
		SetSpawn("PBSpawnVietM79", on);
		SetSpawn("PBSpawnVietMachete", on);
		SetPackToggle("PBWP_Pack_VietDoom", on);
	}

	static void SetCyberaugumented(bool on)
	{
		SetSpawn("PBSpawnPBWP_Warbringer", on);
		SetSpawn("PBSpawnPBWP_Nightfall", on);
		SetSpawn("PBSpawnPBWP_Intervention", on);
		SetSpawn("PBSpawnPBWP_Caduceus", on);
		SetSpawn("PBSpawnPBWP_AmnesiaProtonPhaser", on);
		SetSpawn("PBSpawnPBWP_Liquidation", on);
		SetSpawn("PBSpawnPBWP_Deracinator", on);
		SetSpawn("PBSpawnPBWP_Dismantler", on);
		SetSpawn("PBSpawnPBWP_CinerealOrdnance", on);
		SetPackToggle("PBWP_Pack_Cyberaugumented", on);
	}

	static void SetAllPBWP(bool on)
	{
		SetGodComplex(on);
		SetKarnage(on);
		SetInsanitysNightmare(on);
		SetDemonTech(on);
		SetSchismFireIce(on);
		SetRussianOverkill(on);
		SetDoom2016(on);
		SetDuke(on);
		SetPB30Folded(on);
		SetVietDoom(on);
		SetCyberaugumented(on);
		SetFreezer(on);
		SetMonsterDropWeapons(on);

		SetSpawn("PBSpawnPB_BeamKatana", on);
		SetSpawn("PBSpawnPB_ArgentSith", on);
		SetSpawn("PBSpawnVorpalBlade", on);
		SetSpawn("PBSpawn44PDW", on);
		SetSpawn("PBSpawnB92S", on);
		SetSpawn("PBSpawnDoomBlaster", on);
		SetSpawn("PBSpawnUZI", on);
		SetSpawn("PBSpawnTHMagnum", on);
		SetSpawn("PBSpawnRiotShield", on);
		SetSpawn("PBSpawnPB_CryoShotgun", on);
		SetSpawn("PBSpawnHexaLionShotgun", on);
		SetSpawn("PBSpawnM1887", on);
		SetSpawn("PBSpawnRotatingDoubleBarrel", on);
		SetSpawn("PBSpawnPB_BoltRifle", on);
		SetSpawn("PBSpawnM41A", on);
		SetSpawn("PBSpawnAutoCannon", on);
		SetSpawn("PBSpawnSuperNailgun", on);
		SetSpawn("PBSpawnPB_GaussCannon", on);
		SetSpawn("PBSpawnLegacyUnmaker", on);
		SetSpawn("PBSpawnPhaseEradicatorBFG", on);
		SetSpawn("PBSpawnAncientCrossbow", on);
		SetSpawn("PBSpawnKar98k", on);
		SetSpawn("PBSpawnDukePistol", on);
		SetSpawn("PBSpawnDukeShotgun", on);
		SetSpawn("PBSpawnDukeRPG", on);
		SetSpawn("PBSpawnDukePipebomb", on);
		SyncAllPackToggles(on);
	}

	override void NetworkProcess(ConsoleEvent e)
	{
		let n = e.Name;
		if (n ~== "PBWP_EnableGodComplex")       SetGodComplex(true);
		else if (n ~== "PBWP_DisableGodComplex")  SetGodComplex(false);
		else if (n ~== "PBWP_EnableKarnage")      SetKarnage(true);
		else if (n ~== "PBWP_DisableKarnage")     SetKarnage(false);
		else if (n ~== "PBWP_EnableIN")           SetInsanitysNightmare(true);
		else if (n ~== "PBWP_DisableIN")          SetInsanitysNightmare(false);
		else if (n ~== "PBWP_EnableDTECH")        SetDemonTech(true);
		else if (n ~== "PBWP_DisableDTECH")       SetDemonTech(false);
		else if (n ~== "PBWP_EnableSCHISM")      SetSchismFireIce(true);
		else if (n ~== "PBWP_DisableSCHISM")     SetSchismFireIce(false);
		else if (n ~== "PBWP_EnableRO")           SetRussianOverkill(true);
		else if (n ~== "PBWP_DisableRO")          SetRussianOverkill(false);
		else if (n ~== "PBWP_EnableD2016")       SetDoom2016(true);
		else if (n ~== "PBWP_DisableD2016")      SetDoom2016(false);
		else if (n ~== "PBWP_EnableDuke")         SetDuke(true);
		else if (n ~== "PBWP_DisableDuke")        SetDuke(false);
		else if (n ~== "PBWP_EnablePB30")         SetPB30Folded(true);
		else if (n ~== "PBWP_DisablePB30")        SetPB30Folded(false);
		else if (n ~== "PBWP_EnableVietDoom")    SetVietDoom(true);
		else if (n ~== "PBWP_DisableVietDoom")   SetVietDoom(false);
		else if (n ~== "PBWP_EnableCyberaugumented")    SetCyberaugumented(true);
		else if (n ~== "PBWP_DisableCyberaugumented")   SetCyberaugumented(false);
		else if (n ~== "PBWP_EnableFreezer")      SetFreezer(true);
		else if (n ~== "PBWP_DisableFreezer")     SetFreezer(false);
		else if (n ~== "PBWP_EnableAll")          SetAllPBWP(true);
		else if (n ~== "PBWP_DisableAll")         SetAllPBWP(false);
	}
}
