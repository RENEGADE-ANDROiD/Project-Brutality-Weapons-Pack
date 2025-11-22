class IN_PistolSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_PistolSpawnerT1', 'BerettaTypSpawner', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT2', 'BerettaTypSpawner', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', 'W_SMG', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'P_SMG', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT3', 'B92S', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT3', 'P_SMG', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT4', 'HellPistoler', 255, 1);
	}
}

class IN_SGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_ShotSpawnerT2', 'BlackRemintong', 255, 1);
		handler.InjectSpawn('PB_ShotSpawnerT3', 'HASG', 255, 1);
		handler.InjectSpawn('PB_ShotSpawnerT4', 'RemintongRepeater', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT4', 'HASGDrum', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT4', 'RotationalSG', 255, 1);
	}
}

class IN_MGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_MGSpawnerT2', 'AssaultR1', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT2', 'AK-47', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT2', 'Dark_Fate', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'INMinigun', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'INNailgun', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'MaskMan_Rifle', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'Fallen_Hawk', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'ChthonicRifle', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'MagnumSniperRifle', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'HeavySniperRifle', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT3', 'Adv_MaskMan_Rifle', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT3', 'HeavySniperRifle', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT4', 'MGExplosiveUpgrade', 255, 1);
	}
}

class IN_PlasmaSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_PlasSpawnerT2', 'PlasmaRifleAssault', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT3', 'LightningGun', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'ThunderCarrierTI', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'Extinction_Ray', 255, 1);
	}
}

class IN_ExtraSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_SawSpawnerT2', 'B92S', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT3', 'Adv_MaskMan_Rifle', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'MGExplosiveUpgrade', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT3', 'HASGDrum', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'BioAcidLauncher', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT4', 'RotationalSG', 255, 1);
	}
}