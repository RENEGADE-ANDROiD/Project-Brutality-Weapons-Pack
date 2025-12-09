Class GoreNest2: Actor
{
PB_GlobalStats Stats;

int activated;
int exp;
int rw;
int MNum;
int ArenaRadius;
Array <Actor> MonstersArray;
Array <Actor> RuneBarrierArray;
Vector3 spawnpos;
Vector2 ofs;
string MonName;
int RandomIndex;
Actor Portal;
static const string ImpNames[] =
{
"PB_Imp1",
"DNImpVariant1",
"DNImpVariant2",
"DNImpVariant3"
};

static const string DarkImpNames[] =
{
"PB_DarkImpNami",
"PB_DarkImpNether",
"PB_DarkImpST",
"PB_DarkImpVoid",
"PB_InfectedImp"
};


static const string PinkyNames[] =
{
"PB_Demon",
"PB_MeanDemon",
"PB_MechDemon",
"PB_VoidSpectre"
};



static const string MancubusNames[] =
{
"PB_Mancubus1",
"PB_Daedabus",
"PB_Volcabus"
};

static const string ArchvileNames[] =
{
"PB_Archvile",
"PB_Hellion"
};

static const string BaronNames[] =
{
"PB_Baron1",
"PB_CyberBaron"
};

static const string RevenantNames[] =
{
"PB_Revenant",
"PB_BeamRev",
"PB_Draugr"
};


static const string RewardItems1[] =
{
"PBChainSawSpawner",
"PBPistolSpawner",
"PBShotgunSpawner",
"PBSSGSpawner",
"Backpack",
"PBChaingunSpawner",
"PBRocketLauncherSpawner",
"PBPlasmaRifleSpawner",
"PBBFGSpawner"
};

Default
{
  Tag "Gore nest";
  health 200;
  Height 44;
  Radius 12;
  Scale 0.8;
  DeathHeight 1;
  -Countkill;
  +FLOORCLIP;
  +SOLID;
  +Nevertarget;
  +SHOOTABLE;
  +DONTTHRUST;
  //+ISMONSTER;
  +EXTREMEDEATH;
  Activation THINGSPEC_Switch ; //can call Activate/Deactivate any number of times
  +USESPECIAL
  PainChance "inv", 256;
}

	override void Activate(Actor activator)
	{
	if (health > 0 && activated == 0)
		{
		bINVULNERABLE = 1;
		A_StartSound ("DSGORE",90, CHANF_OVERLAP,1.0);
		A_RemoveChildren(1,RMVF_EVERYTHING);
		ofs = activator.RotateVector((10, 0), activator.angle);
		spawnpos = activator.Vec3Offset(ofs.x, ofs.y, 45);
		portal = Spawn("DamnedSoul2", spawnpos);
		portal.master = self;
		spawnpos = activator.Vec3Offset(ofs.x, ofs.y, 5);
		activated = 1;
		if (GetCVar("nestbr") == 1)
			{
					ArenaRadius = GetCVar("nestar");
					SpawnRunicBarrier("GoreNestHolder2", ArenaRadius);
			}
		}
		A_StartSound("EYEPULL", 5, CHANF_OVERLAP);
		for (int i = 0; i < 5; i++)
		{
			A_SpawnProjectile ("Brutal_Blood", 16, 0, random (0, 360), 2, random (0, 160));
			A_SpawnProjectile ("Brutal_FlyingBlood", 16, 0, random (170, 190), 2, random (0, 40));
			A_SpawnProjectile ("Brutal_FlyingBloodFaster", 16, 0, random (170, 190), 2, random (0, 40));
		}
		SetState(FindState("IdleAct"));
	}


	Void SpawnMonsters(string MonName, vector3 sp, int count, int hm)
	{
		for (int i = 0; i < count; i++)
		{
			let mon = Spawn(MonName, sp, ALLOW_REPLACE);
			if (mon)
			{
				mon.master = Portal;
				mon.bNOINFIGHTING = true;
				mon.bNODAMAGETHRUST = true;
				mon.bDONTTHRUST = true;
				mon.bTHRUSPECIES = true;
				mon.bLOOKALLAROUND = true;
				mon.angle = random(0,360);
				mon.species = "GoreNest";
				mon.health = (mon.health*hm)/100;
				mon.A_SpawnItem("TeleportFog");
				MonstersArray.Push(mon);
			}
		}
	}


	Void SpawnReward(string RewardName, int p)
	{

			Vector3 RewardSpawnpos = Spawnpos;
			RewardSpawnpos.X = RewardSpawnpos.X + random(-15,15);
			RewardSpawnpos.Y = RewardSpawnpos.Y + random(-15,15);
			let reward = Spawn(RewardName, RewardSpawnpos, ALLOW_REPLACE);
			if (reward) {reward.A_SpawnItem("TeleportFog");}
	}


	Void SpawnRunicBarrier(string RuneName, int dist)
	{

		float cr = 2*3.14159*dist; //circumference
		float RCount = int(cr/40); //Total number of barriers. Еhe diameter of the barrier is 50
		float ang = 360/RCount;
		for (int i = 0; i < 360; i = i + ang)
		{
		Vector2 RuneOfs = RotateVector((dist, 0), self.angle + i);
		Vector3 RuneSpawnpos = Vec3Offset(RuneOfs.x, RuneOfs.y, 5);
		Actor rune = Spawn(RuneName, RuneSpawnpos);
		//int NewR = Ceil(rune.radius + ((cr - (RCount*50))/RCount));
		//rune.ACS_NamedExecuteAlways("ChangeR", 0, NewR);
		RuneBarrierArray.Push(rune);
		}
	}


	override void Tick()
	{
		super.Tick();

		if (activated == 0 && health > 0 && !isFrozen() && GetAge() % 5 == 0)
		{

		switch(exp) //If the x variable is...
			{

			case 1:
				A_SpawnItemEx ("DamnedSoulSilent2", random(-30,30), RANDOM(30,-30), -5, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
				return;
			case 3:
				A_SpawnItemEx ("DamnedSoulSilentGreen2", random(-30,30), RANDOM(30,-30), -5, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
				return;
			case 4:
				A_SpawnItemEx ("DamnedSoulSilentYellow2", random(-30,30), RANDOM(30,-30), -5, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
				return;
			case 6:
				A_SpawnItemEx ("DamnedSoulSilentOrange2", random(-30,30), RANDOM(30,-30), -5, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
				return;
			case 8:
				A_SpawnItemEx ("DamnedSoulSilentRed2", random(-30,30), RANDOM(30,-30), -5, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
				return;
			}
		}


		if (activated == 2)
		{
			for (int i = 0; i < MonstersArray.Size(); i++)
			{
				let mon = MonstersArray[i];

				if ( GetCVar("nestbr") == 1 && mon && mon.master && Distance3D(mon) > ArenaRadius)
					{
					mon.A_Warp(AAPTR_MASTER, 0, 0, 5);
					}

				if (!mon || mon.health <= 0 || mon.InStateSequence(self.curstate, self.ResolveState("Death.Execution")))
				{
					MonstersArray.delete(i);
					MonstersArray.ShrinkToFit();
				}
			}


			if (MonstersArray.Size() == 0)
			{
			activated = 3;
			SetState(FindState("GiveReward"));
			}
		}
	}


	void NoLookAround()
	{
		for (int i = 0; i < MonstersArray.Size(); i++)
		{
			let mon = MonstersArray[i];
			if (mon && mon.health > 0)
			{
				mon.bLOOKALLAROUND = false;
			}
		}
	}


  States
	{
	Spawn:
		6R62 A 2 Bright;

		"####" "#" 0
		{
		Stats = PB_GlobalStats.Get();
		int Count = Stats.Counters[PB_GlobalStats.Counter_LevelsCompleted];
		int lvtp = (levelsToPlay / 4);

/*
		if(Count <= lvtp)						{exp = randomPick(1, 3);}
		else if(Count <= (lvtp * 2))			{exp = randomPick(1, 3, 4);}
		else if(Count <= (lvtp * 3))			{exp = randomPick(1, 3, 4, 6);}
		else if(Count > (lvtp * 3))				{exp = randomPick(1, 3, 4, 6, 8);}
		}
*/

		if(Count <= (lvtp*0.7))					{exp = randomPick(1, 3);}
		else if(Count <= (lvtp * 1.7))			{exp = randomPick(1, 3, 4);}
		else if(Count <= (lvtp * 2.7))			{exp = randomPick(1, 3, 4, 6);}
		else if(Count > (lvtp * 2.7))			{exp = randomPick(1, 3, 4, 6, 8);}
		}

		"####" "#" 0 { if (GetCVar("nestrm") == 1)	{exp = randomPick(1, 3, 4, 6, 8);}}

		//"####" "#" 0 {exp = randomPick(1, 3, 4, 6, 7);}
		"####" "#" 0 A_SpawnItem("AxisofEvil2", 0, 10);
		Goto Idle;

	Pain.Inv:
		"####" "#" 0;
		"####" "#" 0 A_JumpIf(Exp == 8, "SpawnTeam");
		"####" "#" 0 A_JumpIf(Exp == 6, "SpawnBelphegorBros");
		"####" "#" 0 A_JumpIf(Exp == 4, "SpawnImpsDark");
		"####" "#" 0 A_JumpIf(Exp == 3, "SpawnPinkies");
		"####" "#" 0 A_JumpIf(Exp == 1, "SpawnImps");


	SpawnImps:
		"####" "#" 105 Bright;
	SpawnImpsContinue:
		"####" "#" 0
				{
				randomIndex = Random(0, ImpNames.Size() - 1);
				MonName = ImpNames[randomIndex];
				SpawnMonsters(MonName, spawnpos, 1, GetCVar("nesthm"));
				}
		"####" "#" 35 Bright;
		"####" "#" 0 {MNum = MNum+1;}
		"####" "#" 0 A_JumpIf(MNum < 8, "SpawnImpsContinue");
		"####" "#" 0 NoLookAround();
		"####" "#" 0 {Activated = 2;}
		"####" "#" 0 A_Jump(256, "IdleAct");


	SpawnImpsDark:
		"####" "#" 105 Bright;
	SpawnImpsDarkContinue:
		"####" "#" 0
				{
				randomIndex = Random(0, DarkImpNames.Size() - 1);
				MonName = DarkImpNames[randomIndex];
				SpawnMonsters(MonName, spawnpos, 1, GetCVar("nesthm"));
				}
		"####" "#" 35 Bright;
		"####" "#" 0 {MNum = MNum+1;}
		"####" "#" 0 A_JumpIf(MNum < 8, "SpawnImpsDarkContinue");
		"####" "#" 0 NoLookAround();
		"####" "#" 0 {Activated = 2;}
		"####" "#" 0 A_Jump(256, "IdleAct");


	SpawnPinkies:
		"####" "#" 105 Bright;
	SpawnPinkiesContinue:
		"####" "#" 0
				{
				randomIndex = Random(0, PinkyNames.Size() - 1);
				MonName = PinkyNames[randomIndex];
				SpawnMonsters(MonName, spawnpos, 1, GetCVar("nesthm"));
				}
		"####" "#" 35 Bright;
		"####" "#" 0 {MNum = MNum+1;}
		"####" "#" 0 A_JumpIf(MNum < 5, "SpawnPinkiesContinue");
		"####" "#" 0 NoLookAround();
		"####" "#" 0 {Activated = 2;}
		"####" "#" 0 A_Jump(256, "IdleAct");


	SpawnBelphegorBros:
		"####" "#" 105 Bright;
	SpawnBelphegorBrosContinue:
		"####" "#" 0
				{
				SpawnMonsters("PB_Belphegor", spawnpos, 1, GetCVar("nesthm"));
				}
		"####" "#" 0 Bright;
		"####" "#" 0 {MNum = MNum+1;}
		"####" "#" 0 A_JumpIf(MNum < 2, "SpawnBelphegorBrosContinue");
		"####" "#" 0 {Activated = 2;}
		"####" "#" 2 Bright;
		"####" "#" 0 NoLookAround();
		"####" "#" 0 A_Jump(256, "IdleAct");


	SpawnTeam:
		"####" "#" 105 Bright;

		"####" "#" 0
				{
				randomIndex = Random(0, MancubusNames.Size() - 1);
				MonName = MancubusNames[randomIndex];
				SpawnMonsters(MonName, spawnpos, 1, GetCVar("nesthm"));
				}
		"####" "#" 35 Bright;


		"####" "#" 0
				{
				randomIndex = Random(0, ArchvileNames.Size() - 1);
				MonName = ArchvileNames[randomIndex];
				SpawnMonsters(MonName, spawnpos, 1, GetCVar("nesthm"));
				}
		"####" "#" 35 Bright;

		"####" "#" 0
				{
				randomIndex = Random(0, BaronNames.Size() - 1);
				MonName = BaronNames[randomIndex];
				SpawnMonsters(MonName, spawnpos, 1, GetCVar("nesthm"));
				}
		"####" "#" 35 Bright;


		"####" "#" 0
				{
				randomIndex = Random(0, RevenantNames.Size() - 1);
				MonName = RevenantNames[randomIndex];
				SpawnMonsters(MonName, spawnpos, 1, GetCVar("nesthm"));
				}
		"####" "#" 35 Bright;

		"####" "#" 0 NoLookAround();
		"####" "#" 0 {Activated = 2;}
		"####" "#" 0 A_Jump(256, "IdleAct");


	IdleAct:
		"####" "#" 0;
		"####" "#" 0 {if(GetCVar("rrinvu") > 0){bInvulnerable = true;}}
		6R62 B 5 Bright A_Look;
	Loop;

	Idle:
		"####" "#" 0;
		"####" "#" 0 {if(GetCVar("rrinvu") > 0){bInvulnerable = true;}}
		6R62 A 5 Bright Light("GoreNestLight") A_Look;
	Loop;

	GiveReward:
		"####" "#" 0;
		
		"####" "#" 0 A_NoBlocking;

		"####" "#" 0
		{
			if (GetCVar("nestbr") == 1)
			{
				for (int i = 0; i < RuneBarrierArray.Size(); i++)
					{
					let Rune = RuneBarrierArray[i];
					if (Rune)
					{Rune.DamageMobj(self, self, Rune.health, "inv", DMG_FOILINVUL);}
					}
			}
		}

		"####" "#" 0 {MNum = 0;}

	SpawnRewardContinue:
		"####" "#" 0
				{
				randomIndex = Random(0, RewardItems1.Size() - (RewardItems1.Size() - Exp));
				MonName = RewardItems1[randomIndex];
				SpawnReward(MonName, 25);
				}
		"####" "#" 16 Bright;
		"####" "#" 0 {MNum = MNum+1;}
		"####" "#" 0 A_JumpIf(MNum < (GetCVar("nesthm")/200), "SpawnRewardContinue");
		"####" "#" 0 A_KillChildren ("Inv", KILS_FOILINVUL, "DamnedSoul2");
		"####" "#" 0 A_Jump(256, "IdleAct");


	Death:
	Death.Inv:
		TNT1 A 0 A_JumpIf(Activated == 0, "DeathContinue");
		TNT1 A 0 A_SpawnItemEx("Megasphere", 0, 0, 0);


	DeathContinue:
		TNT1 A 0 A_RemoveChildren(1,RMVF_EVERYTHING);
		TNT1 AAAAAAAAAA 0 A_SpawnItemEx("NashgoreGibs", 0, 0, 0, random (4, 12), 0, random (4, 12), random(0, 360));
		TNT1 AAAAAA 0 A_SpawnProjectile ("PB_SmallGib", 32, 0, random (150, 210), 2, random (0, 40));
		TNT1 AAAA 0 A_SpawnProjectile ("Brutal_Blood", 30, 0, random (0, 360), 2, random (0, 160));
		TNT1 AAAA 0 A_SpawnProjectile ("Brutal_FlyingBlood", 32, 0, random (170, 190), 2, random (0, 40));
		TNT1 AAAA 0 A_SpawnProjectile ("Brutal_FlyingBloodFaster", 32, 0, random (170, 190), 2, random (0, 40));
		TNT1 AA 0 A_SpawnProjectile ("MeatDeath", 0, 0, random (0, 360), 2, random (0, 160));
		TNT1 AA 0 A_SpawnProjectile ("XDeath1", 32, 0, random (0, 360), 2, random (0, 90));
		TNT1 AA 0 A_SpawnProjectile ("XDeath2", 32, 0, random (0, 360), 2, random (0, 90));
		TNT1 AA 0 A_SpawnProjectile ("XDeath3", 32, 0, random (0, 360), 2, random (0, 90));
		TNT1 AAAA 0 A_SpawnProjectile ("PB_SuperWallRedBlood", 32, 0, random (170, 190), 2, random (0, 40));
		TNT1 AAAA 0 A_SpawnProjectile ("PB_BloodMistBig", 40, 0, random (0, 360), 2, random (30, 90));
		TNT1 A 0 A_SpawnProjectile ("MuchBlood", 50, 0, random (0, 360), 2, random (0, 160));
		TNT1 AA 0 A_SpawnProjectile ("MeatDeathsmall", 0, 0, random (0, 360), 2, random (0, 160));
/*
		TNT1 AA 0 A_SpawnItemEx ("DamnedSoul", random(-10,10), 0, 0, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
		TNT1 AA 0 A_SpawnItemEx ("DamnedSoul", random(-20,20), RANDOM(30,-30), -5, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
		TNT1 A 0 A_SpawnItemEx ("DamnedSoul", random(-30,30), -50, -10, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
		TNT1 A 0 A_SpawnItemEx ("DamnedSoul", random(-35,35), 50, -10, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
		TNT1 A 0 A_SpawnItemEx ("DamnedSoul", random(-40,40), 90, -15, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);
		TNT1 A 0 A_SpawnItemEx ("DamnedSoul", random(-40,40), -90, -15, 0, 0, RANDOM(1,2), 0, SXF_NOCHECKPOSITION, Args[2]);

		TNT1 A 0 BRIGHT A_StartSound ("DamnedSoul/Moan",90, CHANF_OVERLAP,1.0);
		TNT1 AAAA 0 A_SpawnProjectile ("FireworkSFXType2", 2, 0, random (0, 360), 2, random (10, 80));
		EXPL AAAAA 0 A_SpawnProjectile ("ExplosionSmokeFast22", 0, 0, random (0, 360), 2, random (0, 360));
		TNT1 A 0 A_SpawnItem("FireBallExplosionFlames",0,20);
		TNT1 A 0 A_SpawnItem("ExplosionParticleSpawner",0,20);
		TNT1 AAAAA 0 A_SpawnItem("ExplosionParticleSpawner",0,40);
		TNT1 AA 0 A_SpawnItem("FireBallExplosionFlames",0,40);
		TNT2 AAA 0 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
*/
	Stop;
	}
}

Class AxisofEvil2: Actor
{
Default
{
  +FORCEXYBILLBOARD;
  +Nointeraction;
  +NOGRAVITY;
  +NOCLIP;
  +Dontfall;
  +THRUACTORS;
  +DONTTHRUST;
  -SOLID;
  Scale 0.6;
}
  States
	{
	Spawn:
		6R62 CDEFGHFED 3 Bright;
	Loop;
	}
}

Class DamnedSoul2: Actor
{
Default
{
  Radius 2;
  Height 2;
  Speed 1;
  Alpha 0.5;
  Scale 0.5;
  projectile;
  +CLIENTSIDEONLY;
  +NOINTERACTION;
  +GHOST;
}
  States
	{
	Spawn:
		DAM0 A 0 BRIGHT;
		DAM0 A 0 BRIGHT A_StartSound ("DamnedSoul/Moan",90, CHANF_OVERLAP,1.0);

	FadeIn:
		DAM0 A 1 BRIGHT A_SetTranslucent (0.05, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.1, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.15, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.2, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.25, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.3, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.35, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.4, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.45, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.5, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.55, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.6, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.65, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.7, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.75, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.8, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.85, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.9, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.95, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (1, 1);
	Linger:
		DAM0 A 4 BRIGHT;
	FadeOut:
		DAM0 A 1 BRIGHT A_SetTranslucent (1, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.95, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.9, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.85, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.8, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.75, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.7, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.65, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.6, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.55, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.5, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.45, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.4, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.35, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.3, 1);	
		DAM0 A 1 BRIGHT A_SetTranslucent (0.25, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.2, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.15, 1);		
		DAM0 A 1 BRIGHT A_SetTranslucent (0.1, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.05, 1);
	Stop;
	}
}

Class DamnedSoulSilent2 : DamnedSoul2
{
Default
{
  RenderStyle "Normal";
}
 States
	{
	Spawn:
		DAM0 A 0 BRIGHT;

	FadeIn:
		DAM0 A 1 BRIGHT A_SetTranslucent (0.05, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.1, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.15, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.2, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.25, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.3, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.35, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.4, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.45, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.5, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.55, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.6, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.65, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.7, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.75, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.8, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.85, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.9, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.95, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (1, 1);
	Linger:
		DAM0 A 4 BRIGHT;
	FadeOut:
		DAM0 A 1 BRIGHT A_SetTranslucent (1, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.95, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.9, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.85, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.8, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.75, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.7, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.65, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.6, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.55, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.5, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.45, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.4, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.35, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.3, 1);	
		DAM0 A 1 BRIGHT A_SetTranslucent (0.25, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.2, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.15, 1);		
		DAM0 A 1 BRIGHT A_SetTranslucent (0.1, 1);
		DAM0 A 1 BRIGHT A_SetTranslucent (0.05, 1);
	Stop;
	}
}

Class DamnedSoulSilentPink2: DamnedSoulSilent2
{
Default
{
Translation "0:255=%[0,0,0]:[1,0.5,0.5]";
}
}



Class DamnedSoulSilentRed2: DamnedSoulSilent2
{
Default
{
Translation "0:255=%[0,0,0]:[1,0,0]";
}
}

Class DamnedSoulSilentYellow2: DamnedSoulSilent2
{
Default
{
Translation "0:255=%[0,0,0]:[1,1,0]";
}
}

Class DamnedSoulSilentGreen2: DamnedSoulSilent2
{
Default
{
Renderstyle "Normal";
Translation "0:255=%[0,0,0]:[0.1,0.5,0.1]";
}
}

Class DamnedSoulSilentOrange2: DamnedSoulSilent2
{
Default
{
+SHADOW;
RenderStyle "OptFuzzy";
Translation "0:255=%[0,0,0]:[0.9,0.4,0.1]";
}
}


Class HellishAnomaly2: Actor
{
const sm = 0.01;
Default
{
  RenderStyle "Add";
  +CLIENTSIDEONLY;
  -SOLID;
  +NOCLIP;
  +THRUACTORS;
  +NOGRAVITY;
  +DONTFALL;
  +NOTELEPORT;
  -PUSHABLE;
  +NODAMAGETHRUST;
  +NOTARGET;
  +NORADIUSDMG;
  +INVULNERABLE;
  +NOBLOOD;
  +NOBLOODDECALS;
  +SHOOTABLE;
  +NOICEDEATH;
  +DONTTHRUST;
  Scale 0.04;
  Speed 0;
}
  States
	{
	Spawn:
		TNT1 A 0 A_StartSound ("OBPRTOP", 1, CHANF_OVERLAP);
		TNT1 A 0 A_StartSound ("OBPRTLP", 2, CHANF_LOOP);
		9EXP ABCDEFGHIJKLMNOPQRSTUVWXY 1 BRIGHT
			{
			A_SetScale((Scale.Y+sm)*1.2, Scale.Y+sm);
			A_FadeIn(0.04);
			}
		TNT1 A 0
			{
			if (master)
				{
				A_DamageMaster(1, "inv", DMSS_FOILINVUL);
				master.Health = master.health+1;
				}
			}
	SpawnLoop:
		9EXP ABCDEFGHIJKLMNOPQRSTUVWXY 1 BRIGHT Light("PortalLight_Red")
		{A_SpawnItemEx("ObeliskTrailSpark", random(-8, 8), random(-8, 8), random(-8,8), 0, 0, 0, 0, 128, 0);}
	Loop;


	Death:
		TNT1 A 0 A_Stopsound;
		TNT1 A 0 A_StartSound ("OBPRTCL", 1, CHANF_OVERLAP);
		TNT1 A 0 A_RemoveChildren(1,RMVF_EVERYTHING);
		9EXP ABCDEFGHIJKLMNOPQRSTUVWXY 1 BRIGHT
			{
			A_SetScale((Scale.Y-sm)*1.2, Scale.Y-sm);
			A_FadeIn(0.04);
			}
		TNT1 A 35
			{
			if (master)
				{
				A_DamageMaster(master.health, "normal", DMSS_FOILINVUL);
				}
			}

	Stop;
	}
}

Class HellishAnomalyTrail2: Actor
{
Default
{
  RenderStyle "Add";
  +NOGRAVITY;
  +DONTFALL;
  +THRUACTORS;
  -SOLID;
  Alpha 0.75;
  Scale 0.3;
  Speed 8;
}
 States
	{
	Spawn:
		AN0L GHI 3;
	Loop;
	}
}


Class HellishAnomalyFireball2 : FireworkSFXType2
{
Default
{
  Radius 4;
  Height 4;
  Speed 18;
  PROJECTILE;
  +THRUGHOST;
  +MISSILE;
  -NOGRAVITY;
  Gravity 0.15;
}
  States
	{
	Spawn:
		TNT1 A 0 A_JumpIf(waterlevel > 1, "Underwater");
		TNT1 A 0 A_SpawnItem ("HellishAnomalyFireballTrail2");
		TNT1 A 1 A_SpawnItem("RedFlareSmall");
		TNT1 A 0 A_SpawnProjectile ("ExplosionParticleHeavy", 2, 0, random (0, 360), 2, random (0, 290));
		TNT1 A 1 A_SpawnItem("RedFlareSmall");
	Loop;

	Death: 
		TNT1 A 0 A_SpawnItemEx ("TeleportFog",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 ;
	Stop;
	}
}

Class HellishAnomalyFireballTrail2: Actor
{
Default
{
  +NOINTERACTION;
  +ROLLSPRITE;
  RenderStyle "add";
  Alpha 0.95;
  Scale 0.2;
}
  States
	{
	Spawn:
		TNT1 A 0 NoDelay A_SetRoll(random(0,360));
		TNT1 A 1;
		HCT8 ABCDEFGHI 2 Bright A_FadeOut(0.05);
	Stop;
	}
}


Class GoreNestHolder2: Actor
{
Default
{
  +CLIENTSIDEONLY;
  -SOLID;
  +DONTRIP;
  -COUNTKILL;
  -ALLOWTHRUFLAGS;
  +STOPRAILS;
  +FLOORCLIP;
  +FLOORHUGGER;
  +THRUACTORS;
  +NOTELEPORT;
  -PUSHABLE;
  +NODAMAGETHRUST;
  +NOTARGET;
  +INVULNERABLE;
  +NOBLOOD;
  +NOBLOODDECALS;
  +SHOOTABLE;
  +NOICEDEATH;
  +DONTTHRUST;
  +BOSS;
  -BOSSDEATH;
  Scale 0.05;
  Speed 0;
  Height 5;
  Radius 25;
  Health 1;
  Renderstyle "Add";
  Gravity 5;
  Mass 1000;
}
  States
	{
	Spawn:
		TNT1 A 0 A_ScaleVelocity(0);
	SpawnLoop:
		TNT1 A 1 A_CheckFloor("Rescaling");
		TNT1 A 0
		{
		if(waterlevel >= 1) {SetState(FindState("Rescaling"));}
		}
	Loop;

	Rescaling:
		TNT1 A 2;
		TNT1 A 0 //A_SpawnItemEx("GoreNestHolderRune", 0, 0, 20, SXF_NOCHECKPOSITION  | SXF_SETMASTER );
		{
			Vector2 ofs = RotateVector((0, 0), 0); 
			Vector3 ppos = Vec3Offset(ofs.x, ofs.y, 40);
			let mo = Spawn("GoreNestHolderRune2", ppos);
			if (mo)
				{mo.master = self;}
		}
		TNT1 A 0
		{
		//radius = 20;
		bTHRUACTORS = false;
		bSOLID = true;
		//Console.Printf("Real H: %f", self.Scale.Y);
		}
		TNT1 A 0 ACS_NamedExecuteAlways("ChangeH", 0);
		TNT1 A 1;
		//TNT1 A 0 {Console.Printf("New Real ScaleY: %f", self.Scale.Y);}
		TNT1 A 0
			{
			Height = Scale.Y;
			Scale.Y = 0.05;
			}

	Idle:
		TNT1 C 5;
	Loop;

	Death:
	Death.Inv:
		TNT1 A 0;
		TNT1 A 0 A_KillChildren ("Inv", KILS_FOILINVUL, "GoreNestHolderRune2");
	Stop;
	}
}


Class GoreNestHolderRune2: Actor
{
const sm = 0.025;
Default
{
  Radius 1;
  Height 1;
  Scale 0.025;
  +CLIENTSIDEONLY;
  -SOLID;
  +NOCLIP;
  +THRUACTORS;
  +NOGRAVITY;
  +DONTFALL;
  +NOTELEPORT;
  -PUSHABLE;
  +NODAMAGETHRUST;
  +NOTARGET;
  +INVULNERABLE;
  +NOBLOOD;
  +NOBLOODDECALS;
  +SHOOTABLE;
  +NOICEDEATH;
  +DONTTHRUST;
  Renderstyle "Add";
}
  States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 0 A_ScaleVelocity(0);
		TNT1 A 0 A_Jump(256, "Spawn1", "Spawn2", "Spawn3", "Spawn4", "Spawn5", "Spawn6", "Spawn7");
	
	Spawn1:
		DRO0 A 1 Bright A_Jump(256, "Rescaling");
	Spawn2:
		DRO0 B 1 Bright A_Jump(256, "Rescaling");
	Spawn3:
		DRO0 C 1 Bright A_Jump(256, "Rescaling");
	Spawn4:
		DRO0 D 1 Bright A_Jump(256, "Rescaling");
	Spawn5:
		DRO0 E 1 Bright A_Jump(256, "Rescaling");
	Spawn6:
		DRO0 F 1 Bright A_Jump(256, "Rescaling");
	Spawn7:
		DRO0 G 1 Bright A_Jump(256, "Rescaling");

	Rescaling:
		"####" "#####" 1 //bright Light("PortalLight_Red")
		{
		A_SetScale((Scale.Y+sm)*1.2, Scale.Y+sm);
		A_FadeIn(0.2);
		}
		
	Idle:
		"####" "#" 5;
	Loop;

	Death:
	Death.Inv:
		"####" "#" 0;
		"####" "#####" 2 bright
		{
		A_SetScale((Scale.Y-sm)*1.2, Scale.Y-sm);
		A_FadeOut(0.2);
		}
	Stop;
	}
}