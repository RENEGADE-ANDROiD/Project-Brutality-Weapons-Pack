class ArgentSithKatanaInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if ( PBSpawnArgentSith == 1)
		{
		handler.InjectSpawn('PB_SawSpawnerT3', 'PB_ArgentSith', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'PB_ArgentSith', 255, 1);
		}
	}
}