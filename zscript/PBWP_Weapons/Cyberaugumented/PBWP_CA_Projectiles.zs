// Cyberaugumented — shared projectiles / FX (PB Staging–compatible; per-weapon color themes).

class PBWP_CA_PuffFX : BulletPuff
{
	void CA_SpawnHitSparks(int count = 4)
	{
		for (int i = 0; i < count; i++)
		{
			A_SpawnProjectile("HitSpark", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
			A_SpawnProjectile("HitSpark22", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
			A_SpawnProjectile("HitSpark23", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
		}
	}

	void CA_SpawnColoredBurst(int coreColor, int accentColor, bool explosive = false)
	{
		for (int i = 0; i < 8; i++)
			A_SpawnParticle(coreColor, SPF_FULLBRIGHT, random(22, 40), random(6, 12), frandom(0, 360),
				frandom(-5, 5), frandom(-5, 5), frandom(-5, 5), fadestepf: 0.05, sizestep: -0.3);
		for (int i = 0; i < 4; i++)
			A_SpawnParticle(accentColor, SPF_FULLBRIGHT, random(14, 28), random(4, 8), frandom(0, 360),
				frandom(-3, 3), frandom(-3, 3), frandom(-3, 3), fadestepf: 0.06, sizestep: -0.25);
		CA_SpawnHitSparks(4);
		if (explosive)
			A_SpawnItemEx("RocketExplosion", 0, 0, 0, 0, 0, 0, 0, SXF_NOCHECKPOSITION);
	}

	void CA_SpawnAurumBurst()
	{
		CA_SpawnColoredBurst(0xffdc9c, 0xff983d);
		A_SpawnItemEx("PlasmaSmoke", 0, 0, 2, 0, 0, 0, 0, SXF_NOCHECKPOSITION);
	}

	void CA_SpawnBfgGreenBurst()
	{
		CA_SpawnColoredBurst(0x148c1c, 0xc9ffa3, true);
		A_SpawnItemEx("PlasmaSmoke", 0, 0, 2, 0, 0, 0, 0, SXF_NOCHECKPOSITION);
	}

	void CA_SpawnNeonicBurst()
	{
		A_SpawnItem("HellRifle_Puff2");
		if (random(0, 255) < 96)
			A_SpawnItem("BlueFlareSmall");
		A_SpawnItemEx("PlasmaSmoke", 0, 0, 2, 0, 0, 0, 0, SXF_NOCHECKPOSITION);
		for (int i = 0; i < 4; i++)
			A_SpawnParticle(0xaaddff, SPF_FULLBRIGHT, random(14, 24), random(4, 7), frandom(0, 360),
				frandom(-3, 3), frandom(-3, 3), frandom(-3, 3), fadestepf: 0.06, sizestep: -0.25);
		CA_SpawnHitSparks(3);
	}

	void CA_SpawnGrenadeBurst()
	{
		CA_SpawnColoredBurst(0xff983d, 0xff3e1f, true);
		A_SpawnItemEx("PlasmaSmoke", 0, 0, 8, 0, 0, 0, 0, SXF_NOCHECKPOSITION);
	}

	void CA_SpawnCinerealBurst()
	{
		for (int i = 0; i < 10; i++)
			A_SpawnParticle(0xcccccc, SPF_FULLBRIGHT, random(25, 45), random(6, 12), frandom(0, 360),
				frandom(-6, 6), frandom(-6, 6), frandom(-6, 6), fadestepf: 0.06, sizestep: -0.35);
		for (int i = 0; i < 4; i++)
			A_SpawnParticle(0xffffff, SPF_FULLBRIGHT, random(18, 30), random(4, 8), frandom(0, 360),
				frandom(-4, 4), frandom(-4, 4), frandom(-4, 4), fadestepf: 0.07, sizestep: -0.25);
		CA_SpawnHitSparks(6);
	}
}

class PBWP_CA_RailTrailBase : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		+NOTIMEFREEZE;
		+DONTSPLASH;
		RenderStyle "Add";
		Alpha 0.45;
		Scale 2.0;
	}
	States
	{
	Spawn:
		TRAC A 0;
		TRAC A 5
		{
			A_FadeIn(frandom(0.25, 0.55));
			A_SetScale(Scale.X + frandom(-0.1, 0.35));
		}
		TRAC AAAAAAAAAA 1
		{
			A_FadeOut(0.08);
			A_SetScale(Scale.X, Scale.Y - 0.12);
		}
		Stop;
	}
}

// Liquidation — aurum/gold
class PBWP_CA_AurumRailTrail : PBWP_CA_RailTrailBase
{
	Default
	{
		Scale 5.5;
		Alpha 0.7;
		Translation "0:255=%[0.00,0.00,0.00]:[2.00,1.49,0.72]";
	}
}

// Amnesia / Deracinator — toxic green BFG
class PBWP_CA_BfgGreenRailTrail : PBWP_CA_RailTrailBase
{
	Default
	{
		Scale 5.0;
		Alpha 0.65;
		Translation "0:255=%[0.00,0.00,0.00]:[1.03,2.00,0.70]";
	}
}

// Caduceus / Nightfall laser — azure neonic
class PBWP_CA_NeonicRailTrail : PBWP_CA_RailTrailBase
{
	Default
	{
		Scale 1.5;
		Alpha 0.35;
		Translation "0:255=%[0.00,0.00,0.00]:[0.07,0.36,0.83]";
	}
}

// Dismantler — holy white
class PBWP_CA_HolyRailTrail : PBWP_CA_RailTrailBase
{
	Default
	{
		Scale 3.5;
		Alpha 0.75;
		Translation "0:255=%[0.00,0.00,0.00]:[1.74,1.74,1.74]";
	}
}

// Cinereal Ordnance — monochrome
class PBWP_CA_CinerealRailTrail : PBWP_CA_RailTrailBase
{
	Default
	{
		Scale 3.0;
		Alpha 0.5;
		Translation "80:111=[138,138,138]:[0,0,0]", "0:255=%[0.00,0.00,0.00]:[0.31,0.31,0.31]";
	}
}

class PBWP_CA_AurumPuff : PBWP_CA_PuffFX
{
	Default
	{
		+ALWAYSPUFF;
		+NOBLOCKMAP;
		RenderStyle "Add";
		Scale 0.85;
		Translation "0:255=%[0.00,0.00,0.00]:[2.00,1.49,0.72]";
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay { CA_SpawnAurumBurst(); }
		PUFF AAAAA 1 Bright { A_FadeOut(0.08); A_SetScale(Scale.X - 0.03); }
		Stop;
	}
}

class PBWP_CA_BfgGreenPuff : PBWP_CA_PuffFX
{
	Default
	{
		+ALWAYSPUFF;
		+NOBLOCKMAP;
		RenderStyle "Add";
		Scale 0.85;
		Translation "0:255=%[0.00,0.00,0.00]:[1.03,2.00,0.70]";
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay { CA_SpawnBfgGreenBurst(); }
		PUFF AAAAA 1 Bright { A_FadeOut(0.08); A_SetScale(Scale.X - 0.03); }
		Stop;
	}
}

class PBWP_CA_NeonicPuff : PBWP_CA_PuffFX
{
	Default
	{
		+ALWAYSPUFF;
		+NOBLOCKMAP;
		RenderStyle "Add";
		Scale 0.6;
		Translation "0:255=%[0.00,0.00,0.00]:[0.07,0.36,0.83]";
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay { CA_SpawnNeonicBurst(); }
		PUFF AAA 1 Bright { A_FadeOut(0.12); A_SetScale(Scale.X - 0.05); }
		Stop;
	}
}

class PBWP_CA_CinerealPuff : PBWP_CA_PuffFX
{
	Default
	{
		+ALWAYSPUFF;
		+NOBLOCKMAP;
		RenderStyle "Add";
		Scale 0.8;
		Translation "80:111=[138,138,138]:[0,0,0]", "0:255=%[0.00,0.00,0.00]:[0.31,0.31,0.31]";
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay { CA_SpawnCinerealBurst(); }
		PUFF AAA 1 Bright { A_FadeOut(0.12); }
		Stop;
	}
}

class PBWP_CA_GrenadePuff : PBWP_CA_PuffFX
{
	Default
	{
		+ALWAYSPUFF;
		+NOBLOCKMAP;
		+NOGRAVITY;
		+DONTSPLASH;
		RenderStyle "Add";
		Scale 0.65;
		Translation "0:255=%[0.00,0.00,0.00]:[2.00,0.91,0.00]";
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay { CA_SpawnGrenadeBurst(); }
		PUFF AAAA 1 Bright { A_FadeOut(0.1); A_SetScale(Scale.X - 0.04); }
		Stop;
	}
}

class PBWP_CA_Grenade : Rocket
{
	Default
	{
		Speed 25;
		Damage 20;
		Radius 5;
		Height 5;
		Scale 0.5;
		Gravity 0.45;
		BounceType "Doom";
		BounceFactor 0.3;
		WallBounceFactor 0.3;
		+CANBOUNCEWATER;
		-NOGRAVITY;
		+ROLLSPRITE;
		+FORCEXYBILLBOARD;
		SeeSound "";
		DeathSound "DCYBFGX/Explode";
		Translation "0:255=%[0.00,0.00,0.00]:[1.40,0.75,0.12]";
	}
	States
	{
	Spawn:
		GRNP A 2
		{
			roll = roll + frandom(-10, 10);
			if ((level.time % 4) == 0)
				A_CustomMissile("RocketSmokeTrail52Moving", 2, 0, random(70, 110), 2, random(0, 360));
		}
		Loop;
	Death:
		TNT1 A 0
		{
			A_Explode(128, 128);
			A_SpawnItem("PBWP_CA_GrenadePuff");
			bNoGravity = true;
			A_QuakeEx(2, 2, 2, 20, 0, 450, "none", QF_SCALEDOWN | QF_3D);
		}
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
		Translation "0:255=%[0.00,0.00,0.00]:[1.03,2.00,0.70]";
	}
	States
	{
	Spawn:
		PBAL I 1 Bright
		{
			roll = frandom(0, 360);
			A_SpawnParticle(0x148c1c, SPF_FULLBRIGHT | SPF_RELATIVE, random(35, 55), random(10, 16), frandom(0, 360),
				frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5), fadestepf: 0.02, sizestep: 0.35);
			A_SpawnParticle(0xc9ffa3, SPF_FULLBRIGHT | SPF_RELATIVE, random(20, 32), random(6, 10), frandom(0, 360),
				frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5), fadestepf: 0.03, sizestep: 0.2);
		}
		Loop;
	Death:
		TNT1 A 0 Bright
		{
			A_StopSound(CHAN_BODY);
			A_QuakeEx(4, 4, 4, 60, 0, 1200, "", QF_3D | QF_SCALEDOWN | QF_RELATIVE);
			A_SpawnItem("PBWP_CA_BfgGreenPuff");
		}
		TNT1 A 0 Bright { A_BFGSpray("PBWP_CA_BFGExtra", damagecnt: 25); }
		PUFF ABCDEFGHI 2 Bright { A_FadeOut(0.06); }
		TNT1 A 40;
		Stop;
	}
}

class PBWP_CA_BFGExtra : BFGExtra
{
	Default
	{
		Alpha 1.0;
		RenderStyle "Add";
		Translation "0:255=%[0.00,0.00,0.00]:[1.03,2.00,0.70]";
	}
	States
	{
	Spawn:
		PUFF A 0 NoDelay
		{
			for (int i = 0; i < 4; i++)
				A_SpawnParticle(0x148c1c, SPF_FULLBRIGHT, random(16, 28), random(5, 9), frandom(0, 360),
					frandom(-3, 3), frandom(-3, 3), frandom(-3, 3), fadestepf: 0.04, sizestep: -0.2);
		}
		PUFF ABCDEFGH 3 Bright { A_FadeOut(0.04); A_SetScale(Scale.X - 0.02); }
		Stop;
	}
}

class PBWP_CA_NeonicBall : FastProjectile
{
	Default
	{
		Damage 15;
		Radius 10;
		Height 10;
		Speed 60;
		RenderStyle "Add";
		Alpha 0.7;
		Scale 0.38;
		+NOEXTREMEDEATH;
		+FORCERADIUSDMG;
		SeeSound "NeonicBall/Fire";
		DeathSound "NeonicBall/Death";
		MissileType "PBWP_CA_NeonicTrail";
		MissileHeight 6;
		Translation "168:191=192:207", "16:47=240:247";
	}
	States
	{
	Spawn:
		PBAL HI 1 Bright
		{
			if ((level.time % 2) == 0)
				A_SpawnItem("BlueFlareSmall");
			A_SpawnParticle(0xaaddff, SPF_FULLBRIGHT, random(12, 18), random(3, 5), frandom(0, 360),
				frandom(-1, 1), frandom(-1, 1), frandom(-1, 1), fadestepf: 0.05, sizestep: -0.2);
			A_Weave(1, 1, 0.5, 0.5);
		}
		Loop;
	Death:
		TNT1 A 0 { A_SpawnItem("PBWP_CA_NeonicPuff"); }
		TNT1 A 2 { A_Explode(256, 128, XF_NOTMISSILE); }
		Stop;
	}
}

class PBWP_CA_NeonicTrail : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+ROLLSPRITE;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.5;
		Translation "0:255=%[0.00,0.00,0.00]:[0.07,0.36,0.83]";
	}
	States
	{
	Spawn:
		TRAC A 1 NoDelay
		{
			A_SetRoll(frandom(0, 360));
			A_SetScale(Scale.X - 0.12);
			A_FadeOut(0.06);
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
		MissileType "PBWP_CA_HolyTrail";
		MissileHeight 4;
		Translation "0:255=%[0.00,0.00,0.00]:[1.74,1.74,1.74]";
	}
	States
	{
	Spawn:
		TRAC A 1 Bright
		{
			for (int i = 0; i < 2; i++)
				A_SpawnParticle(0xffffff, SPF_FULLBRIGHT | SPF_RELATIVE, random(10, 25), random(8, 12),
					frandom(0, 360), frandom(-2, 2), frandom(-2, 2), frandom(-2, 2),
					fadestepf: 0.05, sizestep: -0.45);
		}
		Loop;
	Death:
		TNT1 A 1
		{
			A_Explode(100, 100, 0, 1);
			for (int i = 0; i < 8; i++)
			{
				A_SpawnProjectile("HitSpark", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
				A_SpawnProjectile("HitSpark22", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
				A_SpawnProjectile("HitSpark23", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
			}
			for (int i = 0; i < 8; i++)
				A_SpawnParticle(0xffffff, SPF_FULLBRIGHT, random(30, 45), 10, frandom(0, 360),
					frandom(-5, 5), frandom(-5, 5), frandom(-5, 5), fadestepf: 0.04, sizestep: -0.35);
		}
		Stop;
	}
}

class PBWP_CA_HolyTrail : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		RenderStyle "Add";
		Alpha 0.35;
		Scale 0.45;
		Translation "0:255=%[0.00,0.00,0.00]:[1.74,1.74,1.74]";
	}
	States
	{
	Spawn:
		TRAC A 1 { A_FadeOut(0.04); A_SetScale(Scale.X - 0.02); }
		Stop;
	}
}

class PBWP_CA_CinerealLaser : FastProjectile
{
	Default
	{
		Damage 40;
		Speed 300;
		FastSpeed 300;
		+THRUGHOST;
		+EXTREMEDEATH;
		+RIPPER;
		+SEEKERMISSILE;
		+BRIGHT;
		RenderStyle "Add";
		XScale 0.75;
		YScale 0.75;
		Alpha 0.85;
		Radius 18;
		Height 18;
		SeeSound "LIGTBALL";
		DeathSound "LIGTBALL";
		MissileType "PBWP_CA_CinerealTrail";
		MissileHeight 6;
		Translation "80:111=[138,138,138]:[0,0,0]", "0:255=%[0.00,0.00,0.00]:[0.31,0.31,0.31]";
	}
	States
	{
	Spawn:
		TRAC A 1 Bright
		{
			A_SpawnParticle(0xdddddd, SPF_FULLBRIGHT, random(20, 35), random(6, 10), frandom(0, 360),
				frandom(-2, 2), frandom(-2, 2), frandom(-2, 2), fadestepf: 0.04, sizestep: -0.2);
		}
		Loop;
	Death:
		TNT1 A 0
		{
			for (int i = 0; i < 8; i++)
			{
				A_SpawnItemEx("PBWP_CA_CinerealBeam", frandom(-6, 6), frandom(-6, 6), frandom(-6, 6),
					random(-5, 5), random(-5, 5), random(-5, 5), random(0, 359),
					SXF_NOCHECKPOSITION);
			}
			A_SpawnItem("PBWP_CA_CinerealPuff");
			A_Explode(128, 96, XF_NOTMISSILE);
		}
		Stop;
	}
}

class PBWP_CA_CinerealTrail : Actor
{
	Default
	{
		+NOCLIP;
		+NOINTERACTION;
		+BRIGHT;
		RenderStyle "Add";
		Alpha 0.35;
		Scale 0.55;
		Translation "80:111=[138,138,138]:[0,0,0]", "0:255=%[0.00,0.00,0.00]:[0.31,0.31,0.31]";
	}
	States
	{
	Spawn:
		TRAC A 1 Bright { A_FadeOut(0.06); A_SetScale(Scale.X - 0.03); }
		Stop;
	}
}

class PBWP_CA_CinerealBeam : Actor
{
	Default
	{
		+NOCLIP;
		+NOINTERACTION;
		+BRIGHT;
		+NOTIMEFREEZE;
		RenderStyle "Add";
		Alpha 0.45;
		Scale 0.75;
		Translation "80:111=[138,138,138]:[0,0,0]", "0:255=%[0.00,0.00,0.00]:[0.31,0.31,0.31]";
	}
	States
	{
	Spawn:
		PUFF A 1 Bright
		{
			if (Alpha <= 0.05 || Scale.X <= 0.05)
				Destroy();
			A_FadeOut(0.05);
			A_SetScale(Scale.X - 0.02, Scale.Y - 0.02);
		}
		Loop;
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
		+ROLLSPRITE;
		RenderStyle "Add";
		DeathSound "DCYBFGX/Explode";
		MissileType "PBWP_CA_BfgGreenRailTrail";
		MissileHeight 8;
		Translation "0:255=%[0.00,0.00,0.00]:[1.03,2.00,0.70]";
	}
	States
	{
	Spawn:
		PBAL I 1 Bright
		{
			roll = frandom(0, 360);
			A_SpawnParticle(0x148c1c, SPF_FULLBRIGHT | SPF_RELATIVE, random(30, 45), random(8, 14),
				frandom(0, 360), frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5),
				fadestepf: 0.018, sizestep: 0.4);
			A_SpawnParticle(0xc9ffa3, SPF_FULLBRIGHT | SPF_RELATIVE, random(18, 28), random(5, 9),
				frandom(0, 360), frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5),
				fadestepf: 0.02, sizestep: 0.25);
		}
		Loop;
	Death:
		TNT1 A 0 Bright
		{
			A_SpawnItem("PBWP_CA_BfgGreenPuff");
			A_Explode(256, 256);
		}
		TNT1 A 0 Bright { A_BFGSpray("PBWP_CA_BFGExtra", damagecnt: 20); }
		PUFF ABCDE 2 Bright { A_FadeOut(0.07); }
		Stop;
	}
}

// Legacy aliases (avoid breaking references)
class PBWP_CA_BFGRailTrail : PBWP_CA_BfgGreenRailTrail {}
class PBWP_CA_BFGPuff : PBWP_CA_BfgGreenPuff {}
