// Folded PB3.0 weapon pack spawners (X12, M45, BFG9500, Karnage, IBMP-12, Tactical Nailgun)

class X12ShotgunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnX12Shotgun)
		{
			handler.InjectSpawn('PB_ShotSpawnerT1', 'X12Shotgun', 255, 3);
			handler.InjectSpawn('PB_ShotSpawnerT2', 'X12Shotgun', 255, 3);
			handler.InjectSpawn('PB_ShotSpawnerT3', 'X12Shotgun', 255, 3);
			handler.InjectSpawn('PB_ShotSpawnerT4', 'X12Shotgun', 255, 3);
		}
	}
}

class M45ShotgunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnM45Shotgun)
		{
			handler.InjectSpawn('PB_ShotSpawnerT1', 'M45Shotgun', 255, 2);
			handler.InjectSpawn('PB_ShotSpawnerT2', 'M45Shotgun', 255, 2);
			handler.InjectSpawn('PB_ShotSpawnerT3', 'M45Shotgun', 255, 2);
			handler.InjectSpawn('PB_ShotSpawnerT4', 'M45Shotgun', 255, 2);
		}
	}
}

class BFG9500SpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnBFG9500)
		{
			handler.InjectSpawn('PB_BFGSpawnerT2', 'BFG9500', 255, 1);
			handler.InjectSpawn('PB_BFGSpawnerT3', 'BFG9500', 255, 1);
			handler.InjectSpawn('PB_BFGSpawnerT4', 'BFG9500', 255, 1);
		}
	}
}

class KarnageHandgunG2SpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnKarnageHandgunG2)
		{
			handler.InjectSpawn('PB_PistolSpawnerT1', 'HandgunG2', 255, 2);
			handler.InjectSpawn('PB_PistolSpawnerT2', 'HandgunG2', 255, 2);
		}
	}
}

class KarnageMP55SpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnKarnageMP55)
		{
			handler.InjectSpawn('PB_PistolSpawnerT2', 'MP55', 255, 2);
			handler.InjectSpawn('PB_PistolSpawnerT3', 'MP55', 255, 2);
		}
	}
}

class KarnageShotgunV1SpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnKarnageShotgunV1)
		{
			handler.InjectSpawn('PB_ShotSpawnerT1', 'ShotgunV1', 255, 2);
			handler.InjectSpawn('PB_ShotSpawnerT2', 'ShotgunV1', 255, 2);
		}
	}
}

class KarnageRainmakerSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnKarnageRainmaker)
		{
			handler.InjectSpawn('PB_ShotSpawnerT3', 'Rainmaker', 255, 2);
			handler.InjectSpawn('PB_ShotSpawnerT4', 'Rainmaker', 255, 2);
		}
	}
}

class KarnageSSVXARSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnKarnageSSVXAR)
		{
			handler.InjectSpawn('PB_MGSpawnerT2', 'SSVXAR', 255, 2);
			handler.InjectSpawn('PB_MGSpawnerT3', 'SSVXAR', 255, 2);
			handler.InjectSpawn('PB_MGSpawnerT4', 'SSVXAR', 255, 2);
		}
	}
}

class KarnageGrenadeLauncherSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnKarnageGrenadeLauncher)
		{
			handler.InjectSpawn('PB_RLSpawnerT2', 'PAGrenadelauncher', 255, 2);
			handler.InjectSpawn('PB_RLSpawnerT3', 'PAGrenadelauncher', 255, 2);
		}
	}
}

class KarnagePlasmastingerSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnKarnagePlasmastinger)
		{
			handler.InjectSpawn('PB_PlasSpawnerT2', 'Plasmastinger', 255, 2);
			handler.InjectSpawn('PB_PlasSpawnerT3', 'Plasmastinger', 255, 2);
			handler.InjectSpawn('PB_PlasSpawnerT4', 'Plasmastinger', 255, 2);
		}
	}
}

class MP12SpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnMP12)
		{
			handler.InjectSpawn('PB_PistolSpawnerT1', 'MP12', 255, 2);
			handler.InjectSpawn('PB_PistolSpawnerT2', 'MP12', 255, 2);
			handler.InjectSpawn('PB_PistolSpawnerT3', 'MP12', 255, 2);
			handler.InjectSpawn('PB_UpgradeSpawnerT3', 'MP12A', 255, 1);
			handler.InjectSpawn('PB_UpgradeSpawnerT4', 'MP12A', 255, 1);
		}
	}
}

class TacticalNailgunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnTacticalNailgun)
		{
			handler.InjectSpawn('PB_MGSpawnerT2', 'Tactical_Nail_Gun', 255, 2);
			handler.InjectSpawn('PB_MGSpawnerT3', 'Tactical_Nail_Gun', 255, 2);
			handler.InjectSpawn('PB_MGSpawnerT4', 'Tactical_Nail_Gun', 255, 2);
		}
	}
}

class LiTRevolverSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnLiTRevolver)
		{
			handler.InjectSpawn('PB_PistolSpawnerT3', 'LiTRevolver', 255, 2);
			handler.InjectSpawn('PB_PistolSpawnerT4', 'LiTRevolver', 255, 2);
		}
	}
}

class PB_TotenheimSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPB_Totenheim)
		{
			handler.InjectSpawn('PB_RLSpawnerT1', 'PB_Totenheim', 255, 1);
			handler.InjectSpawn('PB_RLSpawnerT2', 'PB_Totenheim', 255, 1);
			handler.InjectSpawn('PB_RLSpawnerT3', 'PB_Totenheim', 255, 1);
			handler.InjectSpawn('PB_RLSpawnerT4', 'PB_Totenheim', 255, 1);
		}
	}
}

class PB_HYDRASpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPB_HYDRA)
		{
			handler.InjectSpawn('PB_MGSpawnerT1', 'PB_HYDRA', 255, 1);
			handler.InjectSpawn('PB_MGSpawnerT2', 'PB_HYDRA', 255, 1);
			handler.InjectSpawn('PB_MGSpawnerT3', 'PB_HYDRA', 255, 1);
			handler.InjectSpawn('PB_MGSpawnerT4', 'PB_HYDRA', 255, 1);
		}
	}
}

class PBWP_WarbringerSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_Warbringer)
		{
			handler.InjectSpawn('PB_MGSpawnerT2', 'PBWP_Warbringer', 255, 2);
			handler.InjectSpawn('PB_MGSpawnerT3', 'PBWP_Warbringer', 255, 2);
			handler.InjectSpawn('PB_MGSpawnerT4', 'PBWP_Warbringer', 255, 2);
		}
	}
}

class PBWP_NightfallSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_Nightfall)
		{
			handler.InjectSpawn('PB_MGSpawnerT2', 'PBWP_Nightfall', 255, 2);
			handler.InjectSpawn('PB_MGSpawnerT3', 'PBWP_Nightfall', 255, 2);
			handler.InjectSpawn('PB_MGSpawnerT4', 'PBWP_Nightfall', 255, 2);
		}
	}
}

class PBWP_InterventionSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_Intervention)
		{
			handler.InjectSpawn('PB_RLSpawnerT2', 'PBWP_Intervention', 255, 2);
			handler.InjectSpawn('PB_RLSpawnerT3', 'PBWP_Intervention', 255, 2);
		}
	}
}

class PBWP_CaduceusSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_Caduceus)
		{
			handler.InjectSpawn('PB_PlasSpawnerT2', 'PBWP_Caduceus', 255, 2);
			handler.InjectSpawn('PB_PlasSpawnerT3', 'PBWP_Caduceus', 255, 2);
			handler.InjectSpawn('PB_PlasSpawnerT4', 'PBWP_Caduceus', 255, 2);
		}
	}
}

class PBWP_AmnesiaProtonPhaserSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_AmnesiaProtonPhaser)
		{
			handler.InjectSpawn('PB_BFGSpawnerT2', 'PBWP_AmnesiaProtonPhaser', 255, 1);
			handler.InjectSpawn('PB_BFGSpawnerT3', 'PBWP_AmnesiaProtonPhaser', 255, 1);
		}
	}
}

class PBWP_LiquidationSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_Liquidation)
		{
			handler.InjectSpawn('PB_BFGSpawnerT3', 'PBWP_Liquidation', 255, 1);
			handler.InjectSpawn('PB_BFGSpawnerT4', 'PBWP_Liquidation', 255, 1);
		}
	}
}

class PBWP_DeracinatorSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_Deracinator)
		{
			handler.InjectSpawn('PB_PlasSpawnerT3', 'PBWP_Deracinator', 255, 1);
			handler.InjectSpawn('PB_PlasSpawnerT4', 'PBWP_Deracinator', 255, 1);
		}
	}
}

class PBWP_DismantlerSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_Dismantler)
		{
			handler.InjectSpawn('PB_PlasSpawnerT4', 'PBWP_Dismantler', 255, 1);
			handler.InjectSpawn('PB_BFGSpawnerT4', 'PBWP_Dismantler', 255, 1);
		}
	}
}

class PBWP_CinerealOrdnanceSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_CinerealOrdnance)
		{
			handler.InjectSpawn('PB_BFGSpawnerT4', 'PBWP_CinerealOrdnance', 255, 1);
		}
	}
}

class PBWP_DispatcherSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_Dispatcher)
		{
			handler.InjectSpawn('PB_PlasSpawnerT1', 'PBWP_Dispatcher', 255, 2);
			handler.InjectSpawn('PB_PlasSpawnerT2', 'PBWP_Dispatcher', 255, 2);
			handler.InjectSpawn('PB_PlasSpawnerT3', 'PBWP_Dispatcher', 255, 2);
		}
	}
}

class PBWP_SiriusCrisisSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPBWP_SiriusCrisis)
		{
			handler.InjectSpawn('PB_BFGSpawnerT3', 'PBWP_SiriusCrisis', 255, 1);
			handler.InjectSpawn('PB_BFGSpawnerT4', 'PBWP_SiriusCrisis', 255, 1);
		}
	}
}
