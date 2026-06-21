// EXPLOSION FLAMES
Class NLExplode : Actor
{
	Default
	{
		-SPRITEFLIP
		+NOBLOCKMAP
		+NOCLIP
		+BRIGHT
		+NOGRAVITY
		Speed 3;
		Scale 1.2;
		Alpha 0.5;
		Renderstyle "Add";
	}
	States
	{
	Spawn:
		FTX1 A 1;
		FTX1 AABBCCDEFGHIJKLMNOOPP 1 A_SetScale(Scale.X+0.060,Scale.Y+0.060);
		FTX1 QQQQQQQQQQQQQQQQQQQQQ 1 A_FadeOut(0.05,1);
		Stop;
	}
}

Class LBWP0FlameImpact : NLExplode
{
	Default { Scale  0.8; Alpha 0.7; }
	States
	{
    Spawn:
		FTX1 EFGHIJKLMNOPQ 1 BRIGHT
		{
			A_FadeOut(0.02,1);
			A_SetScale(Scale.X+0.01,Scale.Y+0.01);
			A_SetRoll(Roll+fRandom(8,15),SPF_INTERPOLATE);
		}
		Stop;
    }
}

Class NLSmokeSpawner : Actor
{
	Default
	{
		+NOCLIP
		Speed 20;
	}
	States
    {
	Spawn:
		TNT1 A 0 NoDelay A_SpawnProjectile("NLWeaponSmoke",9,0,Random(0,360),2,Random(0,180));
        Stop;
    }
}

Class NLWeaponSmoke : Actor
{
	Default
	{
		+NOGRAVITY
		+NOBLOCKMAP
		+FLOORCLIP
		+FORCEXYBILLBOARD
		+CLIENTSIDEONLY
		+NOINTERACTION
		+DONTSPLASH
		+MISSILE
		RenderStyle "Add";
		Scale  0.200;
		Alpha  0.3;
		Radius 0;
		Height 0;
		Speed  1;
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay; //A_JumpIf(CVar.FindCVar("SmokeEffects").GetBool() == 0,"Vanish");
		SMOK ABCDEFGHIJKLMNOPQR 2
		{
			If (self is "NLCasingSmoke") { A_SetTics(1); A_SetScale(0.02,0.06); A_FadeOut(0.005); }
			Else if (self is "NLCasingSmokeEnd") { A_SetTics(1); A_SetScale(0.02,0.095); A_FadeOut(0.005); ThrustThingZ(0,1,0,0); }
			Else { A_FadeOut(0.005); ThrustThingZ(0,2,0,0);}
			Return ResolveState(null);
		}
	Vanish:
		TNT1 A 0 A_StopSound(2);
		Stop;
	}
}


Class NLCasingSmoke : NLWeaponSmoke { Default { Speed 1; } }
Class NLCasingSmokeEnd : NLWeaponSmoke { Default { Speed 8; } }

Class EXPlosmokes : Actor
{
	Default
	{
		+NOBLOCKMAP
		+THRUACTORS
		PROJECTILE;
		Radius 	1;
		Height 	1;
		Speed 	2;
		Damage 	0;
		Scale 	0.7;
	}
	States
	{
	Spawn:
		//TNT1 A 0 NoDelay A_JumpIf(ACS_NamedExecuteWithResult("SmokeToggle")==0,"Vanish");
		TNT1 A 0 NoDelay;
		SMOK ABCDEFGHIJKLMNOPQR 2 { A_SetTranslucent(0.250,1); A_FadeOut(0.1,1);}
		Stop;
	Vanish:
		TNT1 A 0;
		Stop;
	}
}
