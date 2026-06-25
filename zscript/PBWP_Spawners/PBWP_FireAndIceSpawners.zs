// Fire and Ice / Freezer folded weapons — Cryo Rifle plasma-tier map spawns.

class PB_CryoRifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBWP_SpawnFilters.MaySpawn(PBSpawnPB_CryoRifle, pbwp_plasmarifle_filter, DisablePBWP_CryoRifle))
		{
			handler.InjectSpawn('PB_PlasSpawnerT3', 'PB_CryoRifle', 255, 1);
			handler.InjectSpawn('PB_PlasSpawnerT4', 'PB_CryoRifle', 255, 1);
		}
	}
}
