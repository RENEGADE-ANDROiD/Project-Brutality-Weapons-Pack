class AlreadyHaveArgentSith : inventory {}

Class BeamKatanaSpawner : PBWP_Spawner 
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
            TNT1 A 0;
            TNT1 A 0 A_JumpIf(players[consoleplayer].mo.CountInv("AlreadyHaveArgentSith") == 1,"GiveNoKatana"); 
			Goto StartChoose; //ALWAYS GO TO THIS AFTER REPLACING SPAWN:
		GiveNoKatana:
        Tier3:
        Tier4:
            TNT1 A 0;
			TNT1 A 0 PB_SpawnerSpawn("ArgentSithAmmoSpawner");
			Stop;
		Tier2:
		Tier1:
			TNT1 A 0;
			TNT1 A 0 PB_SpawnerSpawn("PB_BeamKatanaSpawner");
			Stop;
		Death:
			TNT1 A 0;
			Goto Spawn;
	}
}

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