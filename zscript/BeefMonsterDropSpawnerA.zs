// This is what the Mosnter Drops from the BeefHandler, called SpawnerA
// Each SpawnerA has 4 tiers and can be customizable
// Each tier will spawn SpawnerB, that is where the things are actually spawned

// Marauder SSG
Class MarauderDropSpawner : PB_SpawnerBase 
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
		Tier4:
			TNT1 A 0;
			// This makes it so MarauderSSG and HookGiver will always spawn 
            TNT1 A 0 A_SpawnItemEx("MarauderSSG",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
            TNT1 A 0 A_SpawnItemEx("HookGiver",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			TNT1 A 0 A_SpawnItemEx("PB_MSSGSpawnerT4",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier3:
			TNT1 A 0;
            TNT1 A 0 A_SpawnItemEx("MarauderSSG",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
            TNT1 A 0 A_SpawnItemEx("HookGiver",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			TNT1 A 0 A_SpawnItemEx("PB_MSSGSpawnerT3",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier2:
			TNT1 A 0;
            TNT1 A 0 A_SpawnItemEx("MarauderSSG",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
            TNT1 A 0 A_SpawnItemEx("HookGiver",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			TNT1 A 0 A_SpawnItemEx("PB_MSSGSpawnerT2",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier1:
			TNT1 A 0;
            TNT1 A 0 A_SpawnItemEx("MarauderSSG",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
            TNT1 A 0 A_SpawnItemEx("HookGiver",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			TNT1 A 0 A_SpawnItemEx("PB_MSSGSpawnerT1",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Death:
			TNT1 A 0;
			Goto Spawn;
	}
}

// MasterMind
Class MastermindCGSpawner : PB_SpawnerBase
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
			TNT1 A 0 A_SpawnItemEx("PB_MMCGSpawnerT4",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier3:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_MMCGSpawnerT3",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
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
			TNT1 A 0 A_SpawnItemEx("PB_PainGiverSpawnerT4",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier3:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_PainGiverSpawnerT3",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
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
			TNT1 A 0 A_SpawnItemEx("PB_DTechAllGRSpawnerT4",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier3:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_DTechAllGRSpawnerT3",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier2:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_DTechAllGRSpawnerT2",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier1:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_DTechAllGRSpawnerT1",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
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
			TNT1 A 0 A_SpawnItemEx("PB_ShieldGRSpawnerT4",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier3:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_ShieldGRSpawnerT3",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier2:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_ShieldGRSpawnerT2",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Tier1:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("PB_ShieldGRSpawnerT1",flags:SXF_TRANSFERSPECIAL|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERPOINTERS|288,tid:tid);
			Stop;
		Death:
			TNT1 A 0;
			Goto Spawn;
	}
}