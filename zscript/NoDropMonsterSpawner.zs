//By Warcarlsson
class NoDrop_PB_CarbineZombieDrop : PB_CarbineZombieDrop replaces PB_CarbineZombieDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_HighCalMag";
		PB_MonsterDropBase.upgradeDrop "";
		PB_MonsterDropBase.ammoDrop "PB_HighCalMag";
		PB_MonsterDropBase.weaponCvar "DisablePB_Carbine";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_PlasmaZombieDrop : PB_PlasmaZombieDrop replaces PB_PlasmaZombieDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "";
		PB_MonsterDropBase.upgradeDrop "PB_Cell";
		PB_MonsterDropBase.ammoDrop "PB_Cell";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_ZombieManDrop1 : PB_ZombieManDrop1 replaces PB_ZombieManDrop1
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_HighCalMag";
		PB_MonsterDropBase.upgradeDrop "PB_D16SGBurstUpgrade";
		PB_MonsterDropBase.ammoDrop "PB_HighCalMag";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_ShotgunGuyDrop1 : PB_ShotgunGuyDrop1 replaces PB_ShotgunGuyDrop1
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_Shell";
		PB_MonsterDropBase.upgradeDrop "MSSGUpgrade";
		PB_MonsterDropBase.ammoDrop "PB_Shell";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_ChaingunGuyDrop1 : PB_ChaingunGuyDrop1 replaces PB_ChaingunGuyDrop1
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_HighCalMag";
		PB_MonsterDropBase.upgradeDrop "";
		PB_MonsterDropBase.ammoDrop "PB_HighCalMag";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_ASGGuyDrop : PB_ASGGuyDrop replaces PB_ASGGuyDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_Shell";
		PB_MonsterDropBase.upgradeDrop "HASGdrum";
		PB_MonsterDropBase.ammoDrop "PB_Shell";
		PB_MonsterDropBase.weaponCvar "DisablePB_Autoshotgun";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_CultistDrop : PB_CultistDrop replaces PB_CultistDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_DTech";
		PB_MonsterDropBase.upgradeDrop "";
		PB_MonsterDropBase.ammoDrop "PB_DTech";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}


Class NoDrop_PB_WolfSSdrop : PB_WolfSSdrop replaces PB_WolfSSdrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_LowCalMag";
		PB_MonsterDropBase.upgradeDrop "";
		PB_MonsterDropBase.ammoDrop "PB_LowCalMag";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_NailgunGuydrop : PB_NailgunGuydrop replaces PB_NailgunGuydrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_HighCalMag";
		PB_MonsterDropBase.upgradeDrop "";
		PB_MonsterDropBase.ammoDrop "PB_HighCalMag";
		PB_MonsterDropBase.weaponCvar "DisablePB_Nailgun";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_QSGZombieDrop : PB_QSGZombieDrop replaces PB_QSGZombieDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_Shell";
		PB_MonsterDropBase.upgradeDrop "PB_Shell";
		PB_MonsterDropBase.ammoDrop "PB_Shell";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "DisablePB_QuadSG";
	}
}

Class NoDrop_PB_RocketZombieDrop : PB_RocketZombieDrop replaces PB_RocketZombieDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "";
		PB_MonsterDropBase.upgradeDrop "PB_RocketAmmo";
		PB_MonsterDropBase.ammoDrop "PB_RocketAmmo";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_PyroGuyDrop : PB_PyroGuyDrop replaces PB_PyroGuyDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_Fuel";
		PB_MonsterDropBase.upgradeDrop "PB_D16SGExplosiveUpgrade";
		PB_MonsterDropBase.ammoDrop "PB_Fuel";
		PB_MonsterDropBase.weaponCvar "DisablePB_Flamer";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_ZSpecSMGDrop : PB_ZSpecSMGDrop replaces PB_ZSpecSMGDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_LowCalMag";
		PB_MonsterDropBase.upgradeDrop "";
		PB_MonsterDropBase.ammoDrop "PB_LowCalMag";
		PB_MonsterDropBase.weaponCvar "DisablePB_SMG";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_ScientistAxeDrop : PB_ScientistAxeDrop replaces PB_ScientistAxeDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "";
		PB_MonsterDropBase.upgradeDrop "";
		PB_MonsterDropBase.ammoDrop "";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_ScientistSAWDrop : PB_ScientistSAWDrop replaces PB_ScientistSAWDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_Fuel";
		PB_MonsterDropBase.upgradeDrop "";
		PB_MonsterDropBase.ammoDrop "PB_Fuel";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}

Class NoDrop_PB_PistolGuyDrop : PB_PistolGuyDrop replaces PB_PistolGuyDrop
{
	default
	{
		PB_MonsterDropBase.weaponDrop "PB_LowCalMag";
		PB_MonsterDropBase.upgradeDrop "";
		PB_MonsterDropBase.ammoDrop "PB_LowCalMag";
		PB_MonsterDropBase.weaponCvar "";
		PB_MonsterDropBase.UpgradeCvar "";
	}
}