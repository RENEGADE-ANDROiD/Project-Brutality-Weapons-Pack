// Duke Nukem Weapons Pack — spawners for weapons not already in PBWP (Ripper + Devastator exist).
class DukePistolSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (!PBSpawnDukePistol) return;
		handler.InjectSpawn('PB_PistolSpawnerT2', 'DukePistol', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', 'DukePistol', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'DukePistol', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'DualDukePistols', 255, 1);
	}
}

class DukeShotgunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (!PBSpawnDukeShotgun) return;
		handler.InjectSpawn('PB_SSGSpawnerT2', 'DukeShotgun', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT3', 'DukeShotgun', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT4', 'DukeShotgun', 255, 1);
	}
}

class DukeRPGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (!PBSpawnDukeRPG) return;
		handler.InjectSpawn('PB_RLSpawnerT2', 'DukeRPG', 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT3', 'DukeRPG', 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT4', 'DukeRPG', 255, 1);
	}
}

class DukePipebombSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (!PBSpawnDukePipebomb) return;
		handler.InjectSpawn('PB_PackSpawnerT1', 'Det_Pipebomb', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'Det_Pipebomb', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT3', 'Det_Pipebomb', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT4', 'Det_Pipebomb', 255, 1);
	}
}

class Kar98kSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (!PBSpawnKar98k) return;
		handler.InjectSpawn('PB_MGSpawnerT2', 'PB_Kar98k', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'PB_Kar98k', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'PB_Kar98k', 255, 1);
	}
}
