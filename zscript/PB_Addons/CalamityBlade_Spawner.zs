class CalamityBladeInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnCalamityBlade == 1)
		{
		handler.InjectSpawn('PB_BFGSpawnerT1', 'PB_CalamityBlade', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT2', 'PB_CalamityBlade', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT3', 'PB_CalamityBlade', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT3', 'PB_CalamityBlade', 255, 1);
		}
	}
}