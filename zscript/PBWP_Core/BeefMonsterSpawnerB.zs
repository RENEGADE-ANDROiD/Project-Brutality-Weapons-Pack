// This is SpawnerB, this is what SpawnerA spawns
// This is the place if you want to add more tiers or more things to spawn

// MELEE
class PB_MeleeDropSpawnerT1 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "ShockBaton", 255, 1;
        Dropitem "Crowbar", 255, 1;
        Dropitem "Wrench", 255, 1;
        Dropitem "KatanaPickup", 255, 1;
    }
}
class PB_MeleeDropSpawnerT2 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "ShockBaton", 255, 1;
        Dropitem "PickAxePickup", 255, 1;
        Dropitem "Crowbar", 255, 1;
        Dropitem "Wrench", 255, 1;
        Dropitem "KatanaPickup", 255, 1;
    }
}
class PB_MeleeDropSpawnerT3 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "ShockBaton", 255, 1;
        Dropitem "PickAxePickup", 255, 1;
        Dropitem "SentinelHammerChargePickup", 255, 1;
        Dropitem "ClawChargesPickup", 255, 1;
        Dropitem "DemonicSword", 255, 1;
    }
}
class PB_MeleeDropSpawnerT4 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "ShockBaton", 255, 1;
        Dropitem "ImpactorChargesPickup", 255, 1;
        Dropitem "JohnnyHandsPickup", 255, 1;
        Dropitem "SentinelHammerChargePickup", 255, 1;
        Dropitem "ClawChargesPickup", 255, 1;
        Dropitem "DemonicSword", 255, 1;
    }
}

// Marauder SSG
class HookGiverSpawner : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "HookGiver", 255, 1;
    }
}
class MarauderSSGSpawner : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "MarauderSSG", 255, 1;
    }
}

class PB_MSSGSpawnerT1 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "MSSGUpgrade", 255, 1;
        //Dropitem "ColdKeeperUpgrade", 255, 1;
        Dropitem "PB_Shell", 255, 9;
    }
}
class PB_MSSGSpawnerT2 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "MSSGUpgrade", 255, 2;
        //Dropitem "ColdKeeperUpgrade", 255, 1;
        Dropitem "PB_Shell", 255, 8;
    }
}

class PB_MSSGSpawnerT3 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "MSSGUpgrade", 255, 1;
        Dropitem "ColdKeeperUpgrade", 255, 1;
        Dropitem "PB_Shell", 255, 1;
    }
}

class PB_MSSGSpawnerT4 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "MSSGUpgrade", 255, 1;
        Dropitem "ColdKeeperUpgrade", 255, 1;
    }
}

// Mastermind Chaingun
class PB_MMCGSpawner : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "MastermindChaingun", 255, 1;
    }
}

// PainGiver
class PB_PainGiverSpawner : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "Paingiver", 255, 1;
    }
}

// DemonTech All
class PB_DTechAllGRSpawnerT1 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "HellPistol", 255, 1;
        Dropitem "PB_Demontech", 255, 2;
    }
}

class PB_DTechAllGRSpawnerT2 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "HellPistol", 255, 2;
        Dropitem "TechBlaster", 255, 3;
        Dropitem "PB_Demontech", 255, 4;
        Dropitem "TechBlasterUpgrade", 255, 1;
    }
}

class PB_DTechAllGRSpawnerT3 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "HellPistol", 255, 10;
        Dropitem "TechBlaster", 255, 20;
        Dropitem "DemonTechMinigun", 255, 15;
        Dropitem "DemonTechShotgunGiver", 255, 20;
        Dropitem "TechBlasterUpgrade", 255, 15;
    }
}

class PB_DTechAllGRSpawnerT4 : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "HellPistol", 255, 1;
        Dropitem "TechBlaster", 255, 1;
        Dropitem "DemonTechMinigun", 255, 2;
        Dropitem "DemonTechShotgunGiver", 255, 2;
        Dropitem "TechBlasterUpgrade", 255, 2;
    }
}

// ShieldGrenade
class PB_ShieldGRSpawner : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "ShieldGrenade", 255, 1;
    }
}

// Beam Katana Stuff
class ArgentSithAmmoSpawner : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "PB_DTechLarge", 255, 1;
    }
}

class PB_BeamKatanaSpawner : PB_WeaponSpawner 
{
    Default
    {
        Dropitem "PB_BeamKatana", 255, 2;
    }
}