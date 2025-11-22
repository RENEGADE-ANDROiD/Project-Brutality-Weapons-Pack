class PBExcavatorInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_RLSpawnerT3', 'PB_SuperGL', 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT3', 'PB_Excavator', 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT4', 'PB_Excavator', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT3', 'PB_Excavator', 255, 1);
	}
}