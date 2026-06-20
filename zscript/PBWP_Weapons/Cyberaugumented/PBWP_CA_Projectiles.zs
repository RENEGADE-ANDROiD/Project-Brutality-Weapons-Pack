// Cyberaugumented — shared projectiles / FX (folded from CAScript).

class PBWP_CA_GrenadePuff : BulletPuff
{
	Default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+DONTSPLASH;
		RenderStyle "Add";
		Scale 0.5;
	}
	States
	{
	Spawn:
		TNT1 A 1;
		Stop;
	}
}

class PBWP_CA_BFGPuff : BulletPuff
{
	Default
	{
		+ALWAYSPUFF;
		+NOBLOCKMAP;
		RenderStyle "Add";
		Scale 0.75;
	}
	States
	{
	Spawn:
		SUPH A 1 Bright;
		Stop;
	}
}

class PBWP_CA_Grenade : Rocket
{
	Default
	{
		Speed 25;
		Damage 20;
		Gravity 0.45;
		BounceType "Doom";
		BounceFactor 0.3;
		WallBounceFactor 0.3;
		+CANBOUNCEWATER;
		-NOGRAVITY;
		SeeSound "";
		DeathSound "DCYBFGX/Explode";
	}
	States
	{
	Spawn:
		MNAD A 1 Bright;
		Loop;
	Death:
		MNAD A 1 Bright;
		NBKL D 2 Bright
		{
			A_Explode(128, 128);
			bNoGravity = true;
			A_QuakeEx(2, 2, 2, 20, 0, 450, "none", QF_SCALEDOWN | QF_3D);
		}
		NBKL EFGHIJKLM 2 Bright;
		Stop;
	}
}

class PBWP_CA_BFGSpheroid : Rocket
{
	Default
	{
		DamageType "BFG";
		+BRIGHT;
		+ROLLSPRITE;
		Radius 13;
		Height 8;
		Speed 25;
		Damage 150;
		RenderStyle "Add";
		Alpha 1.0;
		DeathSound "DCYBFGX/Explode";
	}
	States
	{
	Spawn:
		BF3X ABCB 1 Bright;
		Loop;
	Death:
		BF4X A 1 Bright
		{
			A_StopSound(CHAN_BODY);
			A_QuakeEx(4, 4, 4, 60, 0, 1200, "", QF_3D | QF_SCALEDOWN | QF_RELATIVE);
		}
		BF4X BBCCD 2 Bright;
		BF4X D 2 Bright { A_BFGSpray("PBWP_CA_BFGExtra", damagecnt: 25); }
		BF4X EEFFGG 2 Bright;
		BF4X HI 3;
		TNT1 A 40;
		Stop;
	}
}

class PBWP_CA_BFGExtra : BFGExtra
{
	Default
	{
		Alpha 1.0;
	}
	States
	{
	Spawn:
		BF3X Z 3 Bright;
		BF3X ABCDEFGH 3 Bright;
		Stop;
	}
}

class PBWP_CA_NeonicBall : FastProjectile
{
	Default
	{
		Damage 15;
		Radius 24;
		Height 24;
		Speed 60;
		RenderStyle "Add";
		Alpha 1.0;
		+BRIGHT;
		+NOEXTREMEDEATH;
		+FORCERADIUSDMG;
		SeeSound "NeonicBall/Fire";
		DeathSound "NeonicBall/Death";
	}
	States
	{
	Spawn:
		TNT1 A 1;
		Loop;
	Death:
		TNT1 A 2
		{
			A_Explode(256, 128, XF_NOTMISSILE);
		}
		Stop;
	}
}

class PBWP_CA_VeneratedBeam : FastProjectile
{
	Default
	{
		Damage 15;
		Radius 12;
		Height 12;
		Speed 222;
		RenderStyle "Add";
		XScale 0.6;
		YScale 0.45;
		+BRIGHT;
		+RIPPER;
		+FORCERADIUSDMG;
		+NOEXTREMEDEATH;
		+DONTRIP;
	}
	States
	{
	Spawn:
		TRAC B 1 Bright;
		Loop;
	Death:
		TNT1 A 1 { A_Explode(100, 100, 0, 1); }
		Stop;
	}
}

class PBWP_CA_CinerealLaser : FastProjectile
{
	Default
	{
		Damage 40;
		Speed 300;
		+THRUGHOST;
		+EXTREMEDEATH;
		+RIPPER;
		+SEEKERMISSILE;
		+BRIGHT;
		RenderStyle "Add";
		Scale 1.0;
		Alpha 0.1;
		Radius 18;
		Height 18;
	}
	States
	{
	Spawn:
		TNT1 A 1;
		Loop;
	Death:
		TNT1 A 1;
		Stop;
	}
}

class PBWP_CA_DeracinatorBolt : Rocket
{
	Default
	{
		Damage 80;
		Speed 35;
		Radius 16;
		Height 16;
		+BRIGHT;
		RenderStyle "Add";
		DeathSound "DCYBFGX/Explode";
	}
	States
	{
	Spawn:
		BF3X ABCB 1 Bright;
		Loop;
	Death:
		BF4X A 2 Bright { A_Explode(256, 256); A_BFGSpray("PBWP_CA_BFGExtra", damagecnt: 20); }
		BF4X BBCC 2 Bright;
		Stop;
	}
}
