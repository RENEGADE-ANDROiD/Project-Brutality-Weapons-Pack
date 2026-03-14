//Monster Spawner =======================================================================================
/*
class PBWP_EyeTurretSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(EyeTurretSpawn)
		{
		// Eye Turret
		// handler.InjectSpawn('PB_ImpSpawner_T2', 'DoomEyeTurret', 255, 1);
		handler.InjectSpawn('PB_ImpSpawner_T3', 'DoomEyeTurret', 255, 1);
		handler.InjectSpawn('PB_ImpSpawner_T4', 'DoomEyeTurret', 255, 1);
		}
	}
}
*/
class PBWP_CyberdemonBossSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(CyberdemonBossSpawn)
		{
		// Cyberdemon 2016 Boss
		// handler.InjectSpawn('PB_CyberDSpawner_T1', 'CyberdemonBoss', 255, 1);
		// handler.InjectSpawn('PB_CyberDSpawner_T2', 'CyberdemonBoss', 255, 1);
		handler.InjectSpawn('PB_CyberDSpawner_T3', 'CyberdemonBoss', 255, 1);
		handler.InjectSpawn('PB_CyberDSpawner_T4', 'CyberdemonBoss', 255, 1);
		}
	}
}

class PBWP_EBossCellSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(EBossCellSpawn)
		{
		// EBoss Cell
		handler.InjectSpawn('PB_MasterSpawner_T3', 'EBossCell', 255, 1);
		handler.InjectSpawn('PB_MasterSpawner_T4', 'EBossCell', 255, 1);
		}
	}
}

class PBWP_DeepOneSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(DeepOneSpawn)
		{
		//DeepOne
		handler.InjectSpawn('PB_PinkySpawner_T2', 'DeepOne', 255, 1);
		handler.InjectSpawn('PB_PinkySpawner_T3', 'DeepOne', 255, 1);
		handler.InjectSpawn('PB_PinkySpawner_T4', 'DeepOne', 255, 1);
		}
	}
}

class PBWP_PaingiverTrooperSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(PainTrooperSpawn)
		{
		// Paingiver Trooper
		handler.InjectSpawn('PB_ChainGuySpawner_T3', 'HellTrooperPaingiver', 255, 1);
		handler.InjectSpawn('PB_ChainGuySpawner_T4', 'HellTrooperPaingiver', 255, 1); 
		}
	}
}

