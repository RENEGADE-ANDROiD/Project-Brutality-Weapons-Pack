/*=================================================
This file lists all spawn ZSCRIPT injectors for the weapons 
GLOSSARY:
* IN = Insanity's Brutality
* DTECH = Demon Tech Weapons Pack
* SCHISM & F&I = Schism / Fire & Ice
* D2016 = Doom 2016 Weapon's Pack
* ProSurv = Project Survival
=================================================*/

//UNUSED
/*
class KatanaSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_SawSpawnerT1', 'Katana', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT2', 'Katana', 255, 1);
	}
}

class Unmaker64SpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		handler.InjectSpawn('PB_BFGSpawnerT1', 'Unmaker64', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT2', 'Unmaker64', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT3', 'Unmaker64', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT4', 'Unmaker64', 255, 1);
	}
}
*/

// PB_PackSpawnerT1 and PB_PackSpawnerT2 are now defined in PB Staging itself

//GOD COMPLEX =====================================================================================
class DevastadorSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnDevastador, pbwp_plasmarifle_filter, DisablePBWP_GCDevastador))
		{
		handler.InjectSpawn('PB_PlasSpawnerT4', 'Devastador', 255, 1);
		}
	}
}
class EnragedLegendaryBFGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnEnragedLegendaryBFG, pbwp_bfg_filter, DisablePBWP_EnragedLegendaryBFG))
		{
		handler.InjectSpawn('PB_BFGSpawnerT4', 'EnragedLegendaryBFG', 255, 1);
		}
	}
}
class GodEnragedBFGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnGodEnragedBFG)
		{
		handler.InjectSpawn('PB_BFGSpawnerT4', 'GodEnragedBFG', 255, 1);
		}
	}
}
class LegendaryAssaultShotgunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnLegendaryAssaultShotgun, pbwp_ssg_filter, DisablePBWP_LegendaryASG))
		{
		handler.InjectSpawn('PB_SSGSpawnerT3', 'LegendaryAssaultShotgun', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT4', 'LegendaryAssaultShotgun', 255, 1);
		}
	}
}
class LegendaryChainsawSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnLegendaryChainsaw, pbwp_saw_filter, DisablePBWP_LegendaryChainsaw))
		{
		handler.InjectSpawn('PB_SawSpawnerT2', 'LegendaryChainsaw', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT3', 'LegendaryChainsaw', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'LegendaryChainsaw', 255, 1);
		}
	}
}
class LegendaryPlasmaticRifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnLegendaryPlasmaticRifle, pbwp_plasmarifle_filter, DisablePBWP_LegendaryPlasmatic))
		{
		handler.InjectSpawn('PB_PlasSpawnerT4', 'LegendaryPlasmaticRifle', 255, 1);
		}
	}
}
class NemesisBFGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnNemesisBFG, pbwp_bfg_filter, DisablePBWP_NemesisBFG))
		{
		handler.InjectSpawn('PB_BFGSpawnerT4', 'NemesisBFG', 255, 1);
		}
	}
}
class NemesisLMGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnNemesisLMG, pbwp_chaingun_filter, DisablePBWP_NemesisLMG))
		{
		handler.InjectSpawn('PB_MGSpawnerT3', 'NemesisLMG', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'NemesisLMG', 255, 1);
		}
	}
}
class LegendaryBFG10KSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBWP_SpawnFilters.MaySpawn(PBSpawnLegendaryBFG10K, pbwp_bfg_filter, DisablePBWP_LegendaryBFG10K))
		{
			handler.InjectSpawn('PB_BFGSpawnerT4', 'LegendaryBFG10K', 255, 1);
		}
	}
}

//SLOT 0 ===================================================================================== 0 ==
//Ancient Crossbow
class AncientCrossbowSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnAncientCrossbow)
		{
		handler.InjectSpawn('PB_BFGSpawnerT1', 'AncientCrossbow', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT2', 'AncientCrossbow', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT3', 'AncientCrossbow', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT4', 'AncientCrossbow', 255, 1);
		}
	}
}

//Demon Atomizer - DTECH
class TechBlasterSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnTechBlaster)
		{
		//handler.InjectSpawn('PB_PlasSpawnerT1', 'TechBlaster', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT2', 'TechBlaster', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT3', 'TechBlaster', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'TechBlaster', 255, 1);

		//It's Upgrade
		handler.InjectSpawn('PB_PackSpawnerT2', 'TechBlasterUpgrade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'TechBlasterUpgrade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'TechBlasterUpgrade', 255, 1);
		}
	}
}

// Demon Exterminator — provided by PBX-Weapons (PBX_DemonExt)
class DEX_Injector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//Demon Minigun - DTECH
class DemonTechMinigunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnDemonTechMinigun)
		{
		//handler.InjectSpawn('PB_PlasSpawnerT1', 'DemonTechMinigun', 255, 1);
		//handler.InjectSpawn('PB_PlasSpawnerT2', 'DemonTechMinigun', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT3', 'DemonTechMinigun', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'DemonTechMinigun', 255, 1);
		}
	}
}

//Phase Eradicator
class PhaseEradicatorBFGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnPhaseEradicatorBFG)
		{
		handler.InjectSpawn('PB_BFGSpawnerT3', 'PhaseEradicatorBFG', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT4', 'PhaseEradicatorBFG', 255, 1);
		}
	}
}

//SLOT 1 ===================================================================================== 1 ==
//Energy Beam Katana
class PB_BeamKatanaSpawnerInjector : PBInjector
{
	override void init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnPB_BeamKatana, pbwp_saw_filter, DisablePBWP_BeamKatana))
		{
		handler.InjectSpawn("PB_SawSpawnerT1", "BeamKatanaSpawner", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT2", "BeamKatanaSpawner", 255, 1);
		}
	}
}

//Argent Sith Katana
class PB_ArgentSithSpawnerInjector : PBInjector
{
	override void init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnPB_ArgentSith, pbwp_saw_filter, DisablePBWP_ArgentSith))
		{
		handler.InjectSpawn("PB_SawSpawnerT3", "PB_ArgentSith", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT4", "PB_ArgentSith", 255, 1);
		}
	}
}

//Battle Axe - SCHISM & F&I
class BattleAxeSpawnerInjector : PBInjector
{
	override void init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnBattleAxe, pbwp_saw_filter, DisablePBWP_BattleAxe))
		{
		handler.InjectSpawn("PB_SawSpawnerT1", "BattleAxe", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT2", "BattleAxe", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT3", "BattleAxe", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT4", "BattleAxe", 255, 1);
		}
	}
}

//Razorjack - RO
class RazorjackSpawnerInjector : PBInjector
{
	override void init(PB_EventHandler handler)
	{
	if (PBSpawnRazorjack)
		{
		handler.InjectSpawn("PB_SawSpawnerT1", "Razorjack", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT2", "Razorjack", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT3", "Razorjack", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT4", "Razorjack", 255, 1);
		}
	}
}

// Vorpal Blade — Insanity's Requiem Mk.2 (Tiberium's Soulblade)
class VorpalBladeSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnVorpalBlade, pbwp_saw_filter, DisablePBWP_VorpalBlade))
		{
		handler.InjectSpawn("PB_SawSpawnerT1", "VorpalBlade", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT2", "VorpalBlade", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT3", "VorpalBlade", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT4", "VorpalBlade", 255, 1);
		}
	}
}

//SLOT 2 ===================================================================================== 2 ==

//Beretta92 Silenced - IN
class B92SSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnB92S)
		{
		handler.InjectSpawn('PB_PistolSpawnerT1', 'B92S', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT2', 'B92S', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', 'B92S', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'B92S', 255, 1);
		}
	}
}

//Beretta92 Harmony (IN_Beretta) - IN
class IN_BerettaSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnIN_Beretta)
		{
		handler.InjectSpawn('PB_PistolSpawnerT2', 'IN_Beretta', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', 'IN_Beretta', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'IN_Beretta', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'BerettaTypSpawner', 255, 1);
		}
	}
}

//Doom Blaster
class DoomblasterSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnDoomblaster)
		{
		handler.InjectSpawn('PB_PistolSpawnerT1', 'Doomblaster', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT2', 'Doomblaster', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', 'Doomblaster', 255, 3);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'Doomblaster', 255, 3);
		}
	}
}

//DemonPistol - DTECH
class HellPistolSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnHellPistol, pbwp_pistol_filter, DisablePBWP_HellPistol))
		{
		handler.InjectSpawn('PB_PistolSpawnerT2', 'HellPistol', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', 'HellPistol', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'HellPistol', 255, 1);
		}
	}
}

//Plasma Annihilator - IN
class HellPistolerSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnHellPistoler)
		{
		handler.InjectSpawn('PB_PistolSpawnerT3', 'HellPistoler', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'HellPistoler', 255, 1);
		}
	}
}

//Holy Bastard - IN
class W_SMGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnW_SMG, pbwp_pistol_filter, DisablePBWP_W_SMG))
		{
		handler.InjectSpawn('PB_PistolSpawnerT1', 'W_SMG', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT2', 'W_SMG', 255, 1);
		}
	}
}

//W_SMG Upgrade Blood Stains
class P_SMGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnW_SMG, pbwp_pistol_filter, DisablePBWP_W_SMG))
		{
		handler.InjectSpawn('PB_PistolSpawnerT3', 'P_SMG', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'P_SMG', 255, 1);
		}
	}
}

//UZI//
class UZISpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnUZI, pbwp_pistol_filter, DisablePBWP_UZI))
		{
		handler.InjectSpawn('PB_PistolSpawnerT1', 'PB_UZI', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT2', 'PB_UZI', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', 'PB_UZI', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'PB_UZI', 255, 1);
		}
	}
}

//Riot Shield//
class RiotShieldSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnRiotShield, pbwp_pistol_filter, DisablePBWP_RiotShield))
		{
		handler.InjectSpawn('PB_PistolSpawnerT2', 'RiotShieldPickup', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', 'RiotShieldPickup', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'RiotShieldPickup', 255, 1);
		}
	}
}

//44 PDW//
class PB_44PDWSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawn44PDW, pbwp_pistol_filter, DisablePBWP_44PDW))
		{
		//handler.InjectSpawn('PB_PistolSpawnerT1', '44PDW', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT2', '44PDW', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', '44PDW', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', '44PDW', 255, 1);
		}
	}
}

//Thanatos Magnum//
class THMagnumSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnTHMagnum)
		{
		//handler.InjectSpawn('PB_PistolSpawnerT1', 'THMagnum', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT2', 'THMagnum', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT3', 'THMagnum', 255, 1);
		handler.InjectSpawn('PB_PistolSpawnerT4', 'THMagnum', 255, 1);
		}
	}
}

//SLOT 3 ===================================================================================== 3 ==

// Prosurv LeverAction — PBX_Prosurv_LeverAction
class LeverActionSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//2016 Shotgun
class PB_Doom2016ShotgunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnPB_Doom2016Shotgun, pbwp_ssg_filter, DisablePBWP_Doom2016Shotgun))
		{
		handler.InjectSpawn('PB_SSGSpawnerT2', 'PB_Doom2016Shotgun', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT3', 'PB_Doom2016Shotgun', 255, 1);
		//handler.InjectSpawn('PB_SSGSpawnerT4', 'PB_Doom2016Shotgun', 255, 1);
		
		//handler.InjectSpawn('PB_PackSpawnerT2', 'PB_D16SGBurstUpgrade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'PB_D16SGExplosiveUpgrade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'PB_D16SGBurstUpgrade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'PB_D16SGExplosiveUpgrade', 255, 1);
		}
	}
}

//CryoShotgun
class PB_CryoShotgunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnPB_CryoShotgun, pbwp_plasmarifle_filter, DisablePBWP_CryoShotgun))
		{
		//handler.InjectSpawn('PB_PlasSpawnerT1', 'PB_CryoShotgun', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT2', 'PB_CryoShotgun', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT3', 'PB_CryoShotgun', 255, 1);
		//handler.InjectSpawn('PB_PlasSpawnerT4', 'PB_CryoShotgun', 255, 1);
		}
	}
}

// Commander SSG — PBX_CSSG (upgrades spawned by PBX)
class CSSG_Injector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//GatlingShotgun - IN
class RotationalSGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnRotationalSG)
		{
		//handler.InjectSpawn('PB_SSGSpawnerT1', 'RotationalSG', 255, 1);
		//handler.InjectSpawn('PB_SSGSpawnerT2', 'RotationalSG', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT3', 'RotationalSG', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT4', 'RotationalSG', 255, 1);
		}
	}
}

//HASG - IN
class HASGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnHASG, pbwp_ssg_filter, DisablePBWP_HASG))
		{
		handler.InjectSpawn('PB_SSGSpawnerT2', 'HASG', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT3', 'HASG', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT4', 'HASG', 255, 1);
		
		//handler.InjectSpawn('PB_PackSpawnerT2', 'HASGDrum', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'HASGDrum', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'HASGDrum', 255, 1);
		}
	}
}

//HellShotgun - DTECH 
class DemonTechShotgunGiverSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnDTShotgun, pbwp_ssg_filter, DisablePBWP_DTShotgun))
		{
		handler.InjectSpawn('PB_SSGSpawnerT3', 'DemonTechShotgunGiver', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT4', 'DemonTechShotgunGiver', 255, 1);
		}
	}
}

// Hexa Shotgun
class HexaLionShotgunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnHexaLionShotgun)
		{
		handler.InjectSpawn('PB_SSGSpawnerT1', 'HexaLionShotgun', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT2', 'HexaLionShotgun', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT3', 'HexaLionShotgun', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT4', 'HexaLionShotgun', 255, 1);
		}
	}
}

//Lever-Action
class M1887SpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnM1887)
		{
		handler.InjectSpawn('PB_ShotSpawnerT1', 'M1887', 255, 1);
		handler.InjectSpawn('PB_ShotSpawnerT2', 'M1887', 255, 1);
		}
	}
}

// MSSG weapon is monster-drop only; map spawners inject upgrades only.
class MarauderSSGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnMarauderSSG, pbwp_ssg_filter, DisablePBWP_MarauderSSG))
		{
		handler.InjectSpawn('PB_PackSpawnerT2', 'PBWP_MSSGUpgrade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'PBWP_MSSGUpgrade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'PBWP_MSSGUpgrade', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'ColdKeeperUpgrade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'ColdKeeperUpgrade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'ColdKeeperUpgrade', 255, 1);
		}
	}
}

//RotatingDoubleBarrel
class RotatingDoubleBarrelSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnRotatingDoubleBarrel)
		{
//		handler.InjectSpawn('PB_SSGSpawnerT1', 'RotatingDoubleBarrel', 255, 1);
//		handler.InjectSpawn('PB_SSGSpawnerT2', 'RotatingDoubleBarrel', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT3', 'RotatingDoubleBarrel', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT4', 'RotatingDoubleBarrel', 255, 1);
		}
	}
}

//SLOT 4 ===================================================================================== 4 ==

// ProSurv Ballista crossbow — PBX_Prosurv_Ballista
class BallistaSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//AK-47 - IN
class PB_AK47SpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnAK47)
		{
		handler.InjectSpawn('PB_MGSpawnerT1', 'AK-47', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT2', 'AK-47', 255, 1);
		//handler.InjectSpawn('PB_MGSpawnerT3', 'AK-47', 255, 1);
		//handler.InjectSpawn('PB_MGSpawnerT4', 'AK-47', 255, 1);
		}
	}
}

//Assault R1 (HAR) - IN
class AssaultR1SpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnAssaultR1)
		{
		handler.InjectSpawn('PB_MGSpawnerT2', 'AssaultR1', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'AssaultR1', 255, 1);
		}
	}
}

//Black DMR - IN
class Black_DMRSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnBlack_DMR)
		{
		handler.InjectSpawn('PB_MGSpawnerT2', 'Black_DMR-RKX', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'Black_DMR-RKX', 255, 1);
		}
	}
}

//Advanced Mask Man Rifle - IN
class Adv_MaskMan_RifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnAdv_MaskMan_Rifle)
		{
		handler.InjectSpawn('PB_MGSpawnerT3', 'Adv_MaskMan_Rifle', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'Adv_MaskMan_Rifle', 255, 1);
		}
	}
}

//Mask Man Rifle - IN
class MaskMan_RifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnMaskMan_Rifle)
		{
		handler.InjectSpawn('PB_MGSpawnerT2', 'MaskMan_Rifle', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'MaskMan_Rifle', 255, 1);
		}
	}
}

//M1X - IN
class M1XSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnM1X)
		{
		handler.InjectSpawn('PB_MGSpawnerT3', 'M1X', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'M1X', 255, 1);
		}
	}
}

//Bolt Action Sniper
class PB_BoltRifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnPB_BoltRifle, pbwp_chaingun_filter, DisablePBWP_BoltRifle))
		{
		//handler.InjectSpawn('PB_MGSpawnerT1', 'PB_BoltRifle', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT2', 'PB_BoltRifle', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'PB_BoltRifle', 255, 1);
		//handler.InjectSpawn('PB_MGSpawnerT4', 'PB_BoltRifle', 255, 1);
		}
	}
}

//Dark Fate - IN
class Dark_FateSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnDark_Fate)
		{
		handler.InjectSpawn('PB_MGSpawnerT2', 'Dark_Fate', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'Dark_Fate', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'Dark_Fate', 255, 1);
		}
	}
}

//Heavy Sniper - IN
// Heavy Sniper — PBX_MetalSniper
class PB_HeavySniperRifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//Magnum Sniper -IN
class PB_MagnumSniperRifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnMagnumSniperRifle)
		{
		//handler.InjectSpawn('PB_MGSpawnerT1', 'MagnumSniperRifle', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT2', 'MagnumSniperRifle', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'MagnumSniperRifle', 255, 1);
		//handler.InjectSpawn('PB_MGSpawnerT4', 'MagnumSniperRifle', 255, 1);
		}
	}
}

// Pulse Rifle — PBX-Weapons (PBX_NormalRifle / PBX_BattleRifle)
class M41ASpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}



// OverWhelming - RO
class PowerOverwhelmingSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnPowerOverwhelming)
		{
		//handler.InjectSpawn('PB_MGSpawnerT1', 'PowerOverwhelming', 255, 3);
		handler.InjectSpawn('PB_MGSpawnerT2', 'PowerOverwhelming', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'PowerOverwhelming', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'PowerOverwhelming', 255, 1);
		}
	}
}

//SLOT 5 ===================================================================================== 5 ==
//AutoCannon//
class AutoCannonSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnAutoCannon)
		{
		//handler.InjectSpawn('PB_MGSpawnerT1', 'AutoCannon', 255, 3);
		handler.InjectSpawn('PB_MGSpawnerT2', 'AutoCannon', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'AutoCannon', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'AutoCannon', 255, 1);
		}
	}
}

//Dragon Slayer - SCHISM & F&I
class Fire_and_IceDragonSlayerSpawnerInjector : PBInjector
{
	override void init(PB_EventHandler handler)
	{
	if (PBSpawnFire_and_IceDragonSlayer)
		{
		handler.InjectSpawn("PB_SawSpawnerT3", "Fire_and_Ice-DragonSlayer", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT4", "Fire_and_Ice-DragonSlayer", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT3", "Fire_and_Ice-DragonSlayer", 255, 1);
		handler.InjectSpawn("PB_SawSpawnerT4", "Fire_and_Ice-DragonSlayer", 255, 1);
		}
	}
}

//Gallary - IN
class INNailGunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnINNailGun)
		{
		//handler.InjectSpawn('PB_MGSpawnerT1', 'INNailGun', 255, 3);
		handler.InjectSpawn('PB_MGSpawnerT2', 'INNailGun', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'INNailGun', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'INNailGun', 255, 1);
		}
	}
}

// Neo HMG — PBX_NeoHMG
class NeoHMGSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//Machinegun - D2016
class D4MachinegunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnD4Machinegun, pbwp_chaingun_filter, DisablePBWP_D4Machinegun))
		{
		//handler.InjectSpawn('PB_MGSpawnerT1', 'D4Machinegun', 255, 3);
		handler.InjectSpawn('PB_MGSpawnerT2', 'D4Machinegun', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'D4Machinegun', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'D4Machinegun', 255, 1);
		}
	}
}
class MachineGunUpgradeSpawnerInjector : PBInjector //Upgrade Injector
{
	override void Init(PB_EventHandler handler)
	{
		//this adds the machine gun upgrade to the invulnerability sphere spawner
        handler.InjectSpawn('PB_InvulSpawnerT1', 'UpgradeBot', 255, 3);
        //this adds the machine gun upgrade to the pack spawner
        handler.InjectSpawn('PB_PackSpawnerT1', 'UpgradeBot', 255, 2);
        handler.InjectSpawn('PB_PackSpawnerT2', 'UpgradeBot', 255, 1);
        handler.InjectSpawn('PB_UpgradeSpawnerT3', 'UpgradeBot', 255, 1);
        handler.InjectSpawn('PB_UpgradeSpawnerT4', 'UpgradeBot', 255, 1);
	}
}

//Minigun - IN
class INMiniGunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnINMiniGun)
		{
		handler.InjectSpawn('PB_MGSpawnerT2', 'INMiniGun', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'INMiniGun', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'INMiniGun', 255, 1);
        	handler.InjectSpawn('PB_PackSpawnerT2', 'MGExplosiveUpgrade', 255, 1);
        	handler.InjectSpawn('PB_UpgradeSpawnerT3', 'MGExplosiveUpgrade', 255, 1);
        	handler.InjectSpawn('PB_UpgradeSpawnerT4', 'MGExplosiveUpgrade', 255, 1);
		}
	}
}

//Apocalypse Killer HAR - IN
class ApocalypseKillerSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnApocalypseKiller)
		{
		handler.InjectSpawn('PB_MGSpawnerT3', 'ApocalypseKiller', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'ApocalypseKiller', 255, 1);
		}
	}
}

//Ripper Chaingun - Duke
class DukeNukemRipperInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnDukeNukemRipper, pbwp_chaingun_filter, DisablePBWP_DukeRipper))
		{
		//handler.InjectSpawn('PB_MGSpawnerT1', 'DukeNukemRipper', 255, 1);
		//handler.InjectSpawn('PB_MGSpawnerT2', 'DukeNukemRipper', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT3', 'DukeNukemRipper', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'DukeNukemRipper', 255, 1);
		}
	}
}

//Super Nailgun
class SuperNailgunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnSuperNailgun, pbwp_chaingun_filter, DisablePBWP_SuperNailgun))
		{
		handler.InjectSpawn('PB_MGSpawnerT3', 'SuperNailgun', 255, 1);
		handler.InjectSpawn('PB_MGSpawnerT4', 'SuperNailgun', 255, 1);
		}
	}
}

//SLOT 6 ===================================================================================== 6 ==
//ChthonicRifle - IN
class ChthonicRifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnChthonicRifle)
		{
		handler.InjectSpawn('PB_RLSpawnerT3', 'ChthonicRifle', 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT4', 'ChthonicRifle', 255, 1);
		}
	}
}

//Fallen Hawk sniper - IN
class Fallen_HawkSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnFallen_Hawk)
		{
		handler.InjectSpawn('PB_RLSpawnerT3', 'Fallen_Hawk', 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT4', 'Fallen_Hawk', 255, 1);
		}
	}
}

// Cyberdemon RL — PBX_CyberdemonRL
class CyberdemonsMissileLauncherSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//Dual Devastator - Duke
class DevastatorInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnDevastator)
		{
		//handler.InjectSpawn('PB_PlasSpawnerT1', 'Devastator', 255, 1);
		//handler.InjectSpawn('PB_PlasSpawnerT2', 'Devastator', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT3', 'Devastator', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'Devastator', 255, 1);
		}
	}
}


// Excavator — PBX_Excavator
class PBExcavatorInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

// Mastermind Chaingun — PBX_MastermindChaingun
class MastermindChaingunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

// Paingiver — monster-drop only (Hell Trooper)
class PaingiverSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//Rocket Launcher - D2016
class D4RocketLauncherSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnD4RocketLauncher, pbwp_rocketlauncher_filter, DisablePBWP_D4RocketLauncher))
		{
		//handler.InjectSpawn('PB_RLSpawnerT1', 'D4RocketLauncher', 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT2', 'D4RocketLauncher', 255, 1);
		//handler.InjectSpawn('PB_RLSpawnerT3', 'D4RocketLauncher', 255, 1);
		//handler.InjectSpawn('PB_RLSpawnerT4', 'D4RocketLauncher', 255, 1);
		}
	}
}

//SGL - IN
class SuperGrenadeLauncherSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnSuperGrenadeLauncher, pbwp_rocketlauncher_filter, DisablePBWP_SuperGL))
		{
		handler.InjectSpawn('PB_RLSpawnerT2', 'SuperGrenadeLauncher', 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT3', 'SuperGrenadeLauncher', 255, 1);
		handler.InjectSpawn('PB_RLSpawnerT4', 'SuperGrenadeLauncher', 255, 1);
		}
	}
}

//SLOT 7 ===================================================================================== 7 ==

//Heavy Plasma - IN
class PlasmaRifleAssaultSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnPlasmaRifleAssault, pbwp_plasmarifle_filter, DisablePBWP_PlasmaAssault))
		{
		handler.InjectSpawn('PB_PlasSpawnerT3', 'PlasmaRifleAssault', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'PlasmaRifleAssault', 255, 1);
		}
	}
}

//Plasma Gun - D2016
class D4PlasmaGunSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnD4PlasmaGun)
		{
		//handler.InjectSpawn('PB_PlasSpawnerT1', 'D4PlasmaGun', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT2', 'D4PlasmaGun', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT3', 'D4PlasmaGun', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'D4PlasmaGun', 255, 1);
		}
	}
}

//Thunder Carrier - IN
class ThunderCarrierTISpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnThunderCarrierTI)
		{
		handler.InjectSpawn('PB_PlasSpawnerT3', 'ThunderCarrierTI', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'ThunderCarrierTI', 255, 1);
		}
	}
}

//Vortex Rifle - D2016
class D4VortexRifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnD4VortexRifle)
		{
		//handler.InjectSpawn('PB_PlasSpawnerT1', 'D4VortexRifle', 255, 1);
		//handler.InjectSpawn('PB_PlasSpawnerT2', 'D4VortexRifle', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT3', 'D4VortexRifle', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'D4VortexRifle', 255, 1);
		}
	}
}

//SLOT 8 ===================================================================================== 8 ==

//Argent Fury - IN
class Extinction_RaySpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnExtinction_Ray)
		{
		handler.InjectSpawn('PB_PlasSpawnerT3', 'Extinction_Ray', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'Extinction_Ray', 255, 1);
		}
	}
}

//Calamity Blade
class CalamityBladeSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnCalamityBlade)
		{
		handler.InjectSpawn('PB_BFGSpawnerT1', 'LoRCalamityBlade', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT2', 'LoRCalamityBlade', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT3', 'LoRCalamityBlade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'LoRCalamityBlade', 255, 1);
		}
	if (PBSpawnPB_CalamityBlade)
		{
		handler.InjectSpawn('PB_BFGSpawnerT1', 'PB_CalamityBlade', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT2', 'PB_CalamityBlade', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT3', 'PB_CalamityBlade', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'PB_CalamityBlade', 255, 1);
		}
	}
}

//Gauss Cannon
class PB_GaussCannonSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnPB_GaussCannon, pbwp_plasmarifle_filter, DisablePBWP_GaussCannon))
		{
		//handler.InjectSpawn('PB_PlasSpawnerT1', 'PB_GaussCannon', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT2', 'PB_GaussCannon', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT3', 'PB_GaussCannon', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'PB_GaussCannon', 255, 1);
		}
	}
}

//Ion Rifle - IN
class Ion_HeavySpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnIon_Heavy)
		{
		handler.InjectSpawn('PB_PlasSpawnerT3', 'Ion_Heavy', 255, 1);
		handler.InjectSpawn('PB_PlasSpawnerT4', 'Ion_Heavy', 255, 1);
		}
	}
}


// Mancubus Flame Cannon — monster-drop only
class PB_MancubusFlameCannonSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//SLOT 9 ===================================================================================== 9 ==

// Bio-Acid Launcher — monster-drop only (Cacodemon)
class BioAcidLauncherSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

// Ballista — PBX_Prosurv_Ballista (PBWP Ballistagun removed)
class BallistaInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//Legacy Unmaker
class PB_LegacyUnmakerSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBWP_SpawnFilters.MaySpawn(PBSpawnLegacyUnmaker, pbwp_bfg_filter, DisablePBWP_LegacyUnmaker))
		{
		//handler.InjectSpawn('PB_BFGSpawnerT1', 'PB_LegacyUnmaker', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT2', 'PB_LegacyUnmaker', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT3', 'PB_LegacyUnmaker', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT4', 'PB_LegacyUnmaker', 255, 1);
		}
	}
}

//Satan Scream (Unmaker variant) - IN
class Satan_ScreamSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (PBSpawnSatan_Scream)
		{
		handler.InjectSpawn('PB_BFGSpawnerT2', 'Satan_Scream', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT3', 'Satan_Scream', 255, 1);
		handler.InjectSpawn('PB_BFGSpawnerT4', 'Satan_Scream', 255, 1);
		}
	}
}

// Stormcast — monster-drop only (Arch-vile)
class StormcastSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

// Thunder Crossbow — monster-drop only (Revenant)
class ThunderCrossbowSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler) {}
}

//Misc=======================================================================================
// Do we even need this??? I just moved it from the zscript file
// There's not even a CVAR for it
// class PB_DemontechRifleSpawnerInjector : PBInjector
// {
// 	override void Init(PB_EventHandler handler)
// 	{
// 		handler.InjectSpawn('PB_MGSpawnerT3', 'PB_Demontech', 255, 1);
// 	}
// }

//RazorJack Ammo
class BladeAmmo_Injector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(PBSpawnRazorjack)
		{
		handler.InjectSpawn('PB_PackSpawnerT1', 'BladeAmmo', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'BladeAmmo', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'BladeAmmo', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'BladeAmmo', 255, 1);
		}
	}
}

// PB 2022 — Fusil (slot 4)
class PB_FusilSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPB_Fusil)
		{
			handler.InjectSpawn('PB_MGSpawnerT2', 'PB_Fusil', 255, 1);
			handler.InjectSpawn('PB_MGSpawnerT3', 'PB_Fusil', 255, 1);
		}
	}
}

// PB 2022 — UAC Prototype Dark Matter Rifle (slot 8)
class PB_DarkMatterRifleSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		if (PBSpawnPB_DarkMatterRifle)
		{
			handler.InjectSpawn('PB_PlasSpawnerT2', 'PB_DarkMatterRifle', 255, 1);
			handler.InjectSpawn('PB_PlasSpawnerT3', 'PB_DarkMatterRifle', 255, 1);
			handler.InjectSpawn('PB_PlasSpawnerT4', 'PB_DarkMatterRifle', 255, 1);
		}
	}
}
