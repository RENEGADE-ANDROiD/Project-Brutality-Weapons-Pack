// VietDoom v22 folded weapons — PB Staging spawner injections
class VietDoomSpawnerInjector : PBInjector
{
	private void Pistol(PB_EventHandler handler, String pickup, bool enabled)
	{
		if (!enabled) return;
		handler.InjectSpawn('PB_PistolSpawnerT2', pickup, 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', pickup, 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', pickup, 255, 1);
	}

	private void Rifle(PB_EventHandler handler, String pickup, bool enabled)
	{
		if (!enabled) return;
		handler.InjectSpawn('PB_MGSpawnerT2', pickup, 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', pickup, 255, 1);
	}

	private void Heavy(PB_EventHandler handler, String pickup, bool enabled)
	{
		if (!enabled) return;
		handler.InjectSpawn('PB_MGSpawnerT3', pickup, 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', pickup, 255, 1);
	}

	private void Shotgun(PB_EventHandler handler, String pickup, bool enabled)
	{
		if (!enabled) return;
		handler.InjectSpawn('PB_SSGSpawnerT2', pickup, 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT3', pickup, 255, 1);
	}

	private void Rocket(PB_EventHandler handler, String pickup, bool enabled)
	{
		if (!enabled) return;
		handler.InjectSpawn('PB_RLSpawnerT2', pickup, 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT3', pickup, 255, 1);
	}

	override void Init(PB_EventHandler handler)
	{
		Pistol(handler, 'M1911PickUp', PBSpawnVietM1911);
		Pistol(handler, 'M3PickUp', PBSpawnVietM3A1);
		Pistol(handler, 'ThompsonPickUp', PBSpawnVietThompson);
		Pistol(handler, 'MAT49PickUp', PBSpawnVietMAT49);
		Pistol(handler, 'PPShPickUp', PBSpawnVietPPSh);

		Shotgun(handler, 'IthacaPickUp', PBSpawnVietIthaca);

		Rifle(handler, 'M16PickUp', PBSpawnVietM16);
		Rifle(handler, 'M14PickUp', PBSpawnVietM14);
		Rifle(handler, 'M21PickUp', PBSpawnVietXM21);
		Rifle(handler, 'AK47PickUp', PBSpawnVietAK47);
		Rifle(handler, 'SKSPickUp', PBSpawnVietSKS);
		Rifle(handler, 'MosinPickUp', PBSpawnVietMosin);

		Heavy(handler, 'M60PickUp', PBSpawnVietM60);
		Heavy(handler, 'BARPickUp', PBSpawnVietBAR);
		Heavy(handler, 'RPDPickUp', PBSpawnVietRPD);
		Heavy(handler, 'StonerPickUp', PBSpawnVietStoner);

		Rocket(handler, 'RPGPickUp', PBSpawnVietRPG);
		if (PBSpawnVietM79)
		{
			handler.InjectSpawn('PB_RLSpawnerT2', 'M79PickUp', 255, 1);
		}

		if (PBSpawnVietMachete)
		{
			handler.InjectSpawn('PB_SawSpawnerT2', 'MachetePickUp', 255, 1);
		}
	}
}
