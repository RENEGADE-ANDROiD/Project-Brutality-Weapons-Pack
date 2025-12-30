////////////////////////////////////////////////// Equipments //////////////////////////////////////////////////
class ShieldGrenade_Injector : PBInjector   
{
    override void Init(PB_EventHandler handler) 
    {
		if(ShieldGrenadeSpawn)
		{
			handler.InjectSpawn('PB_PackSpawnerT1', 'ShieldGrenade', 255, 2);
			handler.InjectSpawn('PB_PackSpawnerT2', 'ShieldGrenade', 255, 2);
			handler.InjectSpawn('PB_UpgradeSpawnerT3', 'ShieldGrenade', 255, 2);
		}
	}
}

class VoidGrenade_Injector : PBInjector   
{
    override void Init(PB_EventHandler handler) 
    {
		if(VoidGrenadeSpawn)
		{
			handler.InjectSpawn('PB_UpgradeSpawnerT4', 'VoidGrenade', 255, 1);
			
		}
	}
}

class RemoteCharges_Injector : PBInjector   
{
    override void Init(PB_EventHandler handler) 
    {
		if(RemoteChargesSpawn)
		{
			// Acid Charge
			handler.InjectSpawn('PB_RocketBoxSpawnerT2', 'AcidCharge', 255, 1);
			handler.InjectSpawn('PB_RocketBoxSpawnerT3', 'AcidCharge', 255, 1);
			handler.InjectSpawn('PB_RocketBoxSpawnerT4', 'AcidCharge', 255, 1);

			// Laser Charge
			handler.InjectSpawn('PB_RocketBoxSpawnerT3', 'LaserCharge', 255, 1);
			handler.InjectSpawn('PB_RocketBoxSpawnerT4', 'LaserCharge', 255, 1);

			// SwarmCharge
			handler.InjectSpawn('PB_RocketBoxSpawnerT3', 'SwarmCharge', 255, 1);
			handler.InjectSpawn('PB_RocketBoxSpawnerT4', 'SwarmCharge', 255, 1);
		}
	}
}

class ElecPod_Injector : PBInjector   
{
    override void Init(PB_EventHandler handler) 
    {
		if(ElecPodSpawn)
		{
			handler.InjectSpawn('PB_UpgradeSpawnerT3', 'ElecPod', 255, 1);
			handler.InjectSpawn('PB_UpgradeSpawnerT4', 'ElecPod', 255, 1);
    	}
	}
}

class Caltrops_Injector : PBInjector   
{
    override void Init(PB_EventHandler handler) 
    {
		if(CaltropsSpawn)
		{
			handler.InjectSpawn('PB_SawSpawnerT1', 'CaltropsAmmoPack', 255, 1);
			handler.InjectSpawn('PB_SawSpawnerT2', 'CaltropsAmmoPack', 255, 1);

			handler.InjectSpawn('PB_PackSpawnerT1', 'CaltropsAmmoPack', 255, 1);
			handler.InjectSpawn('PB_PackSpawnerT2', 'CaltropsAmmoPack', 255, 1);
			
    	}
	}
}

class Shurikens_Injector : PBInjector   
{
    override void Init(PB_EventHandler handler) 
    {
		if(ShurikenSpawn)
		{
			handler.InjectSpawn('PB_SawSpawnerT1', 'ShurikenAmmoPack', 255, 1);
			handler.InjectSpawn('PB_SawSpawnerT2', 'ShurikenAmmoPack', 255, 1);

			handler.InjectSpawn('PB_PackSpawnerT1', 'ShurikenAmmoPack', 255, 1);
			handler.InjectSpawn('PB_PackSpawnerT2', 'ShurikenAmmoPack', 255, 1);

    	}
	}
}

class Beacon_Injector : PBInjector   
{
    override void Init(PB_EventHandler handler) 
    {
		if(BeaconSpawn)
		{
			handler.InjectSpawn('PB_PackSpawnerT1', 'Beacon', 255, 1);
			handler.InjectSpawn('PB_PackSpawnerT2', 'Beacon', 255, 1);
			handler.InjectSpawn('PB_UpgradeSpawnerT4', 'Beacon', 255, 1);
			handler.InjectSpawn('PB_UpgradeSpawnerT4', 'Beacon', 255, 1);
    	}
	}
}

class Freezebot_Injector : PBInjector   
{
    override void Init(PB_EventHandler handler) 
    {
		if(FreezebotSpawn)
		{
			handler.InjectSpawn('PB_UpgradeSpawnerT4', 'FreezeBotPickup', 255, 1);
    	}
	}
}

class Shielsawammo_Injector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnShieldSaw)
		{
		handler.InjectSpawn('PB_SawSpawnerT1', 'ShieldsawAmmo', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT2', 'ShieldsawAmmo', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT3', 'ShieldsawAmmo', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'ShieldsawAmmo', 255, 1);
		}	
	}
}

class MeatHook_Injector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnHookGiver)
		{
		handler.InjectSpawn('PB_SawSpawnerT1', 'HookGiver', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT2', 'HookGiver', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT3', 'HookGiver', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'HookGiver', 255, 1);
		}	
	}
}

class FreezeNade_Injector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnFreezeNade)
		{
		handler.InjectSpawn('PB_RocketBoxSpawnerT2', 'FreezenadePack', 255, 1);
		handler.InjectSpawn('PB_RocketBoxSpawnerT3', 'FreezenadePack', 255, 1);
		handler.InjectSpawn('PB_RocketBoxSpawnerT4', 'FreezenadePack', 255, 1);
		}	
	}
}
////////////////////////////////////////////////// Melees //////////////////////////////////////////////////
class KatanaSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if (KatanaSpawn)
		{
		// Katama
		handler.InjectSpawn('PB_SawSpawnerT1', 'KatanaPickup', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT2', 'KatanaPickup', 255, 1);

		handler.InjectSpawn('PB_PackSpawnerT1', 'KatanaPickup', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'KatanaPickup', 255, 1);

		// Demonic Sword (Katana Upgrade)
		handler.InjectSpawn('PB_SawSpawnerT3', 'DemonicSword', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'DemonicSword', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'DemonicSword', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'DemonicSword', 255, 1);
		}
	}
}

class PickaxeSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(PickaxeSpawn)
		{
		// Pickaxe
		handler.InjectSpawn('PB_SawSpawnerT1', 'PickAxePickup', 255, 1);
		}
	}
}

class ImpactorSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(ImpactorSpawn)
		{
		// Impactor
		handler.InjectSpawn('PB_SawSpawnerT3', 'ImpactorChargesPickup', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'ImpactorChargesPickup', 255, 1);

		handler.InjectSpawn('PB_PackSpawnerT1', 'ImpactorChargesPickup', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'ImpactorChargesPickup', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'ImpactorChargesPickup', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'ImpactorChargesPickup', 255, 1);
		}
	}
}

class ClawSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(ClawSpawn)
		{
		// Claw
		handler.InjectSpawn('PB_SawSpawnerT3', 'ClawChargesPickup', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'ClawChargesPickup', 255, 1);

		handler.InjectSpawn('PB_PackSpawnerT1', 'ClawChargesPickup', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'ClawChargesPickup', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'ClawChargesPickup', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'ClawChargesPickup', 255, 1);
		}
	}
}

class SentinelHammerSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SentinelHammerSpawn)
		{
		// SentinelHammer
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'SentinelHammerChargePickup', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'SentinelHammerChargePickup', 255, 1);
		}
	}
}

class JohnnyHandsSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(JohnnyHandsSpawn)
		{
		// Johnny Hands
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'JohnnyHandsPickup', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'JohnnyHandsPickup', 255, 1);
		}
	}
}

class WrenchSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(WrenchSpawn)
		{
		// Wrench
		handler.InjectSpawn('PB_SawSpawnerT1', 'Wrench', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT2', 'Wrench', 255, 1);

		handler.InjectSpawn('PB_PackSpawnerT1', 'Wrench', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'Wrench', 255, 1);
		}
	}
}

class CrowbarSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(CrowbarSpawn)
		{
		// Crowbar 
		handler.InjectSpawn('PB_SawSpawnerT1', 'Crowbar', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT2', 'Crowbar', 255, 1);

		handler.InjectSpawn('PB_PackSpawnerT1', 'Crowbar', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'Crowbar', 255, 1);
		}
	}
}

class SledgeHammerSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SledgeHammerSpawn)
		{
		// SLedgeHammer
		handler.InjectSpawn('PB_SawSpawnerT1', 'SledgeHammer', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT2', 'SledgeHammer', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT3', 'SledgeHammer', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'SledgeHammer', 255, 1);

		handler.InjectSpawn('PB_PackSpawnerT1', 'SledgeHammer', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'SledgeHammer', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'SledgeHammer', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'SledgeHammer', 255, 1);
		}
	}
}

class ShockBatonSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(ShockBatonSpawn)
		{
		// ShockBaton
		handler.InjectSpawn('PB_SawSpawnerT3', 'ShockBaton', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT4', 'ShockBaton', 255, 1);

		handler.InjectSpawn('PB_PackSpawnerT1', 'ShockBaton', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'ShockBaton', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT3', 'ShockBaton', 255, 1);
		handler.InjectSpawn('PB_UpgradeSpawnerT4', 'ShockBaton', 255, 1);
		}
	}
}

class MacheteSpawnerInjector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(MacheteSpawn)
		{
		// Machete
		handler.InjectSpawn('PB_SawSpawnerT1', 'Machete', 255, 1);
		handler.InjectSpawn('PB_SawSpawnerT2', 'Machete', 255, 1);

		handler.InjectSpawn('PB_PackSpawnerT1', 'Machete', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT2', 'Machete', 255, 1);
		}
	}
}

////////////////////////////////////////////////// Armor Spawner //////////////////////////////////////////////////
class PBWP_YellowArmorSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnYellowArmor)
		{
		handler.InjectSpawn('PB_GreenSpawnerT2', 'NarmorYellow', 255, 1);
		handler.InjectSpawn('PB_GreenSpawnerT3', 'NarmorYellow', 255, 1);
		handler.InjectSpawn('PB_GreenSpawnerT4', 'NarmorYellow', 255, 1);
		
		}
	}
}

class PBWP_PurpleArmorSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnPurpleArmor)
		{
		handler.InjectSpawn('PB_GreenSpawnerT3', 'NarmorPurple', 255, 1);
		handler.InjectSpawn('PB_GreenSpawnerT4', 'NarmorPurple', 255, 1);
		
		}
	}
}

class PBWP_BlackArmorSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnBlackArmor)
		{
		handler.InjectSpawn('PB_BlueSpawnerT1', 'NarmorBlack', 255, 1);
		handler.InjectSpawn('PB_BlueSpawnerT2', 'NarmorBlack', 255, 1);
		handler.InjectSpawn('PB_BlueSpawnerT3', 'NarmorBlack', 255, 1);
		
		}
	}
}

class PBWP_OrangeArmorSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnOrangeArmor)
		{
		handler.InjectSpawn('PB_BlueSpawnerT1', 'NarmorOrange', 255, 1);
		
		}
	}
}

class PBWP_WhiteArmorSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnWhiteArmor)
		{
		handler.InjectSpawn('PB_BlueSpawnerT1', 'NarmorWhite', 255, 1);
		handler.InjectSpawn('PB_BlueSpawnerT2', 'NarmorWhite', 255, 1);
		handler.InjectSpawn('PB_BlueSpawnerT3', 'NarmorWhite', 255, 1);
		handler.InjectSpawn('PB_BlueSpawnerT4', 'NarmorWhite', 255, 1);
		
		}
	}
}

class PBWP_RedArmorSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnRedArmor)
		{
		handler.InjectSpawn('PB_BlueSpawnerT2', 'NarmorRed', 255, 1);
		handler.InjectSpawn('PB_BlueSpawnerT3', 'NarmorRed', 255, 1);
		handler.InjectSpawn('PB_BlueSpawnerT4', 'NarmorRed', 255, 1);
		
		}
	}
}

class PBWP_CyanArmorSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnCyanArmor)
		{
		handler.InjectSpawn('PB_BlueSpawnerT4', 'NarmorCyan', 255, 1);
		
		}
	}
}

class PBWP_DemonArmorSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnDemonArmor)
		{
		handler.InjectSpawn('PB_BlueSpawnerT4', 'NarmorDemon', 255, 1);
		
		}
	}
}

////////////////////////////////////////////////// Powerups //////////////////////////////////////////////////
class TimeSphereSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnTimesphere)
		{
		handler.InjectSpawn('PB_SoulSphereSpawnerT3', 'TFST', 255, 1);
		handler.InjectSpawn('PB_SoulSphereSpawnerT4', 'TFST', 255, 1);
		
		}
	}
}

class ShrinkSphereSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnShrinksphere)
		{
		handler.InjectSpawn('PB_SoulSphereSpawnerT3', 'ShrinkSphere', 255, 1);
		handler.InjectSpawn('PB_SoulSphereSpawnerT4', 'ShrinkSphere', 255, 1);
		
		}
	}
}

class GuardSphereSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnGuardsphere)
		{
		handler.InjectSpawn('PB_SoulSphereSpawnerT2', 'GuardsphereST', 255, 1);
		handler.InjectSpawn('PB_SoulSphereSpawnerT3', 'GuardsphereST', 255, 1);
		
		}
	}
}

class RegenSphereSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnRegensphere)
		{
		handler.InjectSpawn('PB_SoulSphereSpawnerT3', 'RegenSphere', 255, 1);
		handler.InjectSpawn('PB_MegaSpawnerT1', 'RegenSphere', 255, 1);
		handler.InjectSpawn('PB_MegaSpawnerT2', 'RegenSphere', 255, 1);
		
		}
	}
}

class DeflectionSphereSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnDeflectionsphere)
		{
		handler.InjectSpawn('PB_SoulSphereSpawnerT1', 'DeflectionSphere', 255, 1);
		handler.InjectSpawn('PB_DoomSpawnerT1', 'DeflectionSphere', 255, 1);
		
		}
	}
}

class ElectricSphereSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnElectricsphere)
		{
		handler.InjectSpawn('PB_SoulSphereSpawnerT4', 'ElectricAuraSphere', 255, 1);
		handler.InjectSpawn('PB_MegaSpawnerT1', 'ElectricAuraSphere', 255, 1);
		handler.InjectSpawn('PB_MegaSpawnerT2', 'ElectricAuraSphere', 255, 1);
		handler.InjectSpawn('PB_MegaSpawnerT3', 'ElectricAuraSphere', 255, 1);
		handler.InjectSpawn('PB_MegaSpawnerT4', 'ElectricAuraSphere', 255, 1);
		
		}
	}
}

class LegendSphereSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnLegendsphere)
		{
		handler.InjectSpawn('PB_SoulSphereSpawnerT4', 'LegendSpher', 255, 1);
		handler.InjectSpawn('PB_InvulSpawnerT1', 'LegendSpher', 255, 1);
            
		}
	}
}

class LifeShieldSphereSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnLifeShieldSphere)
		{
		handler.InjectSpawn('PB_MegaSpawnerT1', 'LifeshieldSphere', 255, 1);
		handler.InjectSpawn('PB_MegaSpawnerT2', 'LifeshieldSphere', 255, 1);
		handler.InjectSpawn('PB_MegaSpawnerT3', 'LifeshieldSphere', 255, 1);
		handler.InjectSpawn('PB_MegaSpawnerT4', 'LifeshieldSphere', 255, 1);
		
		}
	}
}

class CrucifixSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnCrucifix)
		{
		handler.InjectSpawn('PB_HasteSpawnerT1', 'Crucifix', 255, 1);
		handler.InjectSpawn('PB_HasteSpawnerT2', 'Crucifix', 255, 1);
		
		}
	}
}

class FamiliarSpawner : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
	if(SpawnFamiliar)
		{
		handler.InjectSpawn('PB_MegaSpawnerT4', 'FamiliarSummon', 255, 1);
		
		}
	}
}