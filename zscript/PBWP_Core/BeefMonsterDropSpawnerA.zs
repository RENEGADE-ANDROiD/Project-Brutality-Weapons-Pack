// This is what the Mosnter Drops from the BeefHandler, called SpawnerA
// Each SpawnerA has 4 tiers and can be customizable
// Each tier will spawn SpawnerB, that is where the things are actually spawned

// Marauder SSG
Class MarauderDropSpawner : PBWP_Spawner 
{
	default
	{
		scale 0.45;
		-COUNTKILL; 
		+NOTIMEFREEZE;
		-ISMONSTER;
		Species "PBWPSpawner";
	}
	States
	{
		Spawn:
		GivePermanentThings:
			TNT1 A 0 A_print("Succesfully Initialized GivePermanent");
			TNT1 A 0 A_Jumpif(PlayerAlreadyHas("AlreadyHaveMeatHook"),"GiveNoHook"); 
            TNT1 A 0 PB_SpawnerSpawn("HookGiverSpawner");
			TNT1 A 0 PB_SpawnerSpawn("MarauderSSGSpawner");
			Goto StartChoose; //ALWAYS GO TO THIS AFTER REPLACING SPAWN:
		GiveNoHook:
			TNT1 A 0 A_print("Succesfully Checked Inventory");
			TNT1 A 0 PB_SpawnerSpawn("MarauderSSGSpawner");
			Goto StartChoose;
		Tier4:
			TNT1 A 0;
			TNT1 A 0 PB_SpawnerSpawn("PB_MSSGSpawnerT4");
			Stop;
		Tier3:
			TNT1 A 0;
			TNT1 A 0 PB_SpawnerSpawn("PB_MSSGSpawnerT3");
			Stop;
		Tier2:
			TNT1 A 0;
			TNT1 A 0 PB_SpawnerSpawn("PB_MSSGSpawnerT2");
			Stop;
		Tier1:
			TNT1 A 0;
			TNT1 A 0 PB_SpawnerSpawn("PB_MSSGSpawnerT1");
			Stop;
		Death:
			TNT1 A 0;
			Goto Spawn;
	}
}

// MasterMind
Class MastermindCGSpawner : PBWP_Spawner
{
    Default
    {
        scale 0.45;
		-COUNTKILL; 
		+NOTIMEFREEZE;
		-ISMONSTER;
		Species "PBWPSpawner";
    }
    States
	{
		Tier4:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_MMCGSpawnerT4");
			Stop;
		Tier3:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_MMCGSpawnerT3");
			Stop;
		Death:
			TNT1 A 0;
			Goto Spawn;
	}
}

// Paingiver
Class PainGiverSpawner : PB_SpawnerBase
{
    Default
    {
        scale 0.45;
		-COUNTKILL; 
		+NOTIMEFREEZE;
		-ISMONSTER;
		Species "PBWPSpawner";
    }
    States
	{
		Tier4:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_PainGiverSpawnerT4");
			Stop;
		Tier3:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_PainGiverSpawnerT3");
			Stop;
		Death:
			TNT1 A 0;
			Goto Spawn;
	}
}

// DemonTech Spawner
Class DTechSpawner : PB_SpawnerBase
{
    Default
    {
        scale 0.45;
		-COUNTKILL; 
		+NOTIMEFREEZE;
		-ISMONSTER;
		Species "PBWPSpawner";
    }
    States
	{
		Tier4:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_DTechAllGRSpawnerT4");
			Stop;
		Tier3:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_DTechAllGRSpawnerT3");
			Stop;
		Tier2:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_DTechAllGRSpawnerT2");
			Stop;
		Tier1:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_DTechAllGRSpawnerT1");
			Stop;
		Death:
			TNT1 A 0;
			Goto Spawn;
	}
}

// Shield Grenade
Class ShieldGrenadeDrop : PB_SpawnerBase
{
    Default
    {
        scale 0.45;
		-COUNTKILL; 
		+NOTIMEFREEZE;
		-ISMONSTER;
		Species "PBWPSpawner";
    }
    States
	{
		Tier4:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_ShieldGRSpawnerT4");
			Stop;
		Tier3:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_ShieldGRSpawnerT3");
			Stop;
		Tier2:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_ShieldGRSpawnerT2");
			Stop;
		Tier1:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_ShieldGRSpawnerT1");
			Stop;
		Death:
			TNT1 A 0;
			Goto Spawn;
	}
}