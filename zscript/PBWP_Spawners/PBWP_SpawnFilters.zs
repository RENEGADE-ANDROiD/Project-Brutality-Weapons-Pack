// PBWP tier-menu spawn filters (PB Addon Options → Weapons).
// Full list still uses PBSpawn* bools in WeaponPackSpawnSettings.
// A weapon spawns only when PBSpawn* is true AND its tier filter bit is clear.

enum PBWP_eSawSpawns
{
	DisablePBWP_BeamKatana          = 1 << 0,
	DisablePBWP_BattleAxe           = 1 << 1,
	DisablePBWP_LegendaryChainsaw   = 1 << 2,
	DisablePBWP_ArgentSith          = 1 << 3,
	DisablePBWP_DragonSlayer        = 1 << 4,
	DisablePBWP_VorpalBlade         = 1 << 5,
}

enum PBWP_ePistolSpawns
{
	DisablePBWP_UZI                 = 1 << 0,
	DisablePBWP_44PDW               = 1 << 1,
	DisablePBWP_HellPistol          = 1 << 2,
	DisablePBWP_W_SMG               = 1 << 3,
	DisablePBWP_RiotShield          = 1 << 4,
}

enum PBWP_eSSGSpawns
{
	DisablePBWP_MarauderSSG          = 1 << 0,
	DisablePBWP_Doom2016Shotgun     = 1 << 1,
	DisablePBWP_HASG                = 1 << 2,
	DisablePBWP_LegendaryASG        = 1 << 3,
	DisablePBWP_DTShotgun           = 1 << 4,
}

enum PBWP_eChaingunSpawns
{
	DisablePBWP_M41A                = 1 << 0,
	DisablePBWP_BoltRifle           = 1 << 1,
	DisablePBWP_NemesisLMG          = 1 << 2,
	DisablePBWP_D4Machinegun        = 1 << 3,
	DisablePBWP_DukeRipper          = 1 << 4,
	DisablePBWP_SuperNailgun        = 1 << 5,
}

enum PBWP_eRocketLauncherSpawns
{
	DisablePBWP_D4RocketLauncher    = 1 << 0,
	DisablePBWP_SuperGL             = 1 << 1,
}

enum PBWP_ePlasmaRifleSpawns
{
	DisablePBWP_GaussCannon         = 1 << 1,
	DisablePBWP_PlasmaAssault       = 1 << 2,
	DisablePBWP_LegendaryPlasmatic  = 1 << 3,
	DisablePBWP_GCDevastador        = 1 << 4,
	DisablePBWP_ThunderCrossbow     = 1 << 5,
	DisablePBWP_CryoRifle           = 1 << 6,
}

enum PBWP_eBFGSpawns
{
	DisablePBWP_LegacyUnmaker       = 1 << 0,
	DisablePBWP_Stormcast           = 1 << 1,
	DisablePBWP_NemesisBFG          = 1 << 2,
	DisablePBWP_EnragedLegendaryBFG = 1 << 3,
	DisablePBWP_LegendaryBFG10K     = 1 << 4,
}

class PBWP_SpawnFilters
{
	clearscope static bool MaySpawn(bool pbSpawnEnabled, int filter, int disableBit)
	{
		return pbSpawnEnabled && !(filter & disableBit);
	}
}
