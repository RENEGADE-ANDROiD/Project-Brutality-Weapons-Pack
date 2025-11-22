class DukeNukemRipperInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_MGSpawnerT1', 'DukeNukemRipper', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT2', 'DukeNukemRipper', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'DukeNukemRipper', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'DukeNukemRipper', 255, 1);
	}
}

class DevastatorInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_PlasSpawnerT1', 'Devastator', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT2', 'Devastator', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT3', 'Devastator', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'Devastator', 255, 1);
	}
}