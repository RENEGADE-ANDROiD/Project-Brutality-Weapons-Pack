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

// Liquidation — aurum/gold (Ballista-style quake on trail segments)
class PBWP_CA_AurumRailTrail : PBWP_CA_RailTrailBase
{
	Default
	{
		Scale 5.5;
		Alpha 0.7;
		Translation "0:255=%[0.00,0.00,0.00]:[2.00,1.49,0.72]";
	}
	States
	{
	Spawn:
		TRAC A 0;
		TRAC A 5
		{
			A_FadeIn(frandom(0.25, 0.55));
			A_QuakeEx(1, 1, 1, 10, 0, 100, "none", QF_SCALEDOWN);
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

// Caduceus / Nightfall laser — azure neonic (upstream DCY_NeonicWandTrail uses M_TR-style wisps)
class PBWP_CA_NeonicRailTrail : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		+ROLLSPRITE;
		RenderStyle "Add";
		Alpha 0.35;
		Scale 1.5;
		Translation "0:255=%[0.00,0.00,0.00]:[0.07,0.36,0.83]";
	}
	States
	{
	Spawn:
		M_TR C 0;
		M_TR C 5
		{
			A_FadeIn(frandom(0.25, 0.55));
			A_SetScale(Scale.X + frandom(-0.1, 0.35));
		}
		M_TR CCDDDEEEFFFGGGH 1
		{
			A_FadeOut(0.05);
			A_SetScale(Scale.X, Scale.Y - 0.15);
		}
		Stop;
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
		+ROLLSPRITE;
		+FLATSPRITE;
		+BRIGHT;
		RenderStyle "Add";
		Scale 0.85;
		Translation "0:255=%[0.00,0.00,0.00]:[2.00,1.49,0.72]";
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay
		{
			CA_SpawnAurumBurst();
			A_SetRoll(Roll + random(0, 360));
			for (int i = 0; i < 3; i++)
				A_SpawnItemEx("PBWP_CA_AurumRailSpark", 0, 0, 0, frandom(10, 20), 0, frandom(2, 13), frandom(0, 360),
					SXF_NOCHECKPOSITION, 28);
		}
		SUPH AACEGIKMOPQR 1 Bright;
		PUFF AAA 1 Bright { A_FadeOut(0.08); A_SetScale(Scale.X - 0.03); }
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

class PBWP_CA_NeonicRingBurst : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		+ROLLSPRITE;
		+FLATSPRITE;
		RenderStyle "Add";
		Scale 0.45;
		Translation "0:255=%[0.00,0.00,0.18]:[1.01,2.00,2.00]";
	}
	States
	{
	Spawn:
		C28Y A 0 NoDelay
		{
			A_SetAngle(random(0, 360));
			A_SetRoll(random(0, 360));
			A_SetPitch(random(0, 360));
		}
		C28Y A 1;
		C28Y B 1 { A_Explode(50, 25, 0, 0); }
		C28Y DFGIJLMNPQ 1;
		Stop;
	}
}

class PBWP_CA_NeonicExplode : Actor
{
	Default
	{
		+NOINTERACTION;
		+BRIGHT;
		+ROLLSPRITE;
		RenderStyle "Add";
		Scale 1.275;
		Translation "0:255=%[0.00,0.00,0.00]:[0.07,0.36,0.83]";
	}
	States
	{
	Spawn:
		KABE A 1 NoDelay { A_SetRoll(frandom(0, 360)); }
		KABE BCDEFGHIJKLMNOPQRSTUVW 1;
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
		TNT1 A 0 NoDelay
		{
			CA_SpawnNeonicBurst();
			A_SpawnItemEx("PBWP_CA_NeonicRingBurst", flags: SXF_NOCHECKPOSITION);
		}
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
		MNAD A 1 Bright
		{
			roll = roll + frandom(-10, 10);
			if ((level.time % 4) == 0)
				A_CustomMissile("RocketSmokeTrail52Moving", 2, 0, random(70, 110), 2, random(0, 360));
			if ((level.time % 3) == 0)
				A_SpawnItemEx("PBWP_CA_GrenadeFlare", frandom(-2.5, 2.5), frandom(-2.5, 2.5), frandom(-2.5, 2.5),
					flags: SXF_NOCHECKPOSITION);
		}
		Loop;
	Death:
		MNAD A 1 Bright;
		NBKL D 2 Bright
		{
			A_Explode(128, 128);
			A_SpawnItem("PBWP_CA_GrenadePuff");
			bNoGravity = true;
			A_QuakeEx(2, 2, 2, 20, 0, 450, "none", QF_SCALEDOWN | QF_3D);
		}
		NBKL E 2 Bright
		{
			for (int i = 3; i > 0; i--)
				A_SpawnItemEx("PBWP_CA_ExplosionSmall", frandom(-4, 4), frandom(-4, 4), frandom(-2, 2),
					frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(0, 360),
					SXF_NOCHECKPOSITION);
		}
		NBKL FGHIJKLM 2 Bright;
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
		BF3X ABCB 1 Bright
		{
			roll = frandom(0, 360);
			if ((level.time % 2) == 0)
				A_SpawnItemEx("PBWP_CA_BfgArc", frandom(-20, 20), frandom(-20, 20), frandom(-20, 20),
					flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 100);
			if ((level.time % 3) == 0)
				A_SpawnItemEx("PBWP_CA_ElecDeathBurst", frandom(-20, 20), frandom(-20, 20), frandom(-20, 20),
					flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 140);
			A_SpawnParticle(0x148c1c, SPF_FULLBRIGHT | SPF_RELATIVE, random(35, 55), random(10, 16), frandom(0, 360),
				frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5), fadestepf: 0.02, sizestep: 0.35);
			A_SpawnParticle(0xc9ffa3, SPF_FULLBRIGHT | SPF_RELATIVE, random(20, 32), random(6, 10), frandom(0, 360),
				frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5), fadestepf: 0.03, sizestep: 0.2);
		}
		Loop;
	Death:
		BF4X A 1 Bright
		{
			roll = 0;
			A_SetScale(1.3, 1.3);
			A_StopSound(CHAN_BODY);
			A_QuakeEx(4, 4, 4, 60, 0, 1200, "", QF_3D | QF_SCALEDOWN | QF_RELATIVE);
			A_SpawnItem("PBWP_CA_BfgGreenPuff");
			for (int i = 0; i < 6; i++)
				A_SpawnItemEx("PBWP_CA_ElecDeathBurst", frandom(-20, 20), frandom(-20, 20), frandom(-20, 20),
					frandom(-5, 5), frandom(-5, 5), frandom(-5, 5), 0, SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 20);
		}
		BF4X AA 2 Bright
		{
			A_SpawnItemEx("PBWP_CA_BfgArc", frandom(-2, 2), frandom(-2, 2), frandom(-2, 2),
				flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 60);
		}
		BF4X BBCCD 2 Bright
		{
			A_SpawnItemEx("PBWP_CA_BfgArc", frandom(-2, 2), frandom(-2, 2), frandom(-2, 2),
				flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 60);
		}
		BF4X D 2 Bright { A_BFGSpray("PBWP_CA_BFGExtra", damagecnt: 25); }
		BF4X EEFFGG 2 Bright;
		BF4X HI 3 Bright;
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
		BF3X Z 3 Bright NoDelay
		{
			for (int i = 0; i < 4; i++)
				A_SpawnParticle(0x148c1c, SPF_FULLBRIGHT, random(16, 28), random(5, 9), frandom(0, 360),
					frandom(-3, 3), frandom(-3, 3), frandom(-3, 3), fadestepf: 0.04, sizestep: -0.2);
			for (int i = 0; i < 4; i++)
				A_SpawnItemEx("PBWP_CA_ElecDeathBurst", frandom(-10, 10), frandom(-10, 10), frandom(-10, 10),
					flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 30);
		}
		BF3X ABCDEFGH 3 Bright { A_FadeOut(0.04); A_SetScale(Scale.X - 0.02); }
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
		TNT1 A 0
		{
			for (int i = 0; i < 2; i++)
				A_SpawnItemEx("PBWP_CA_NeonicExplode", flags: SXF_NOCHECKPOSITION);
			A_SpawnItem("PBWP_CA_NeonicPuff");
		}
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
		+BRIGHT;
		RenderStyle "Add";
		Alpha 0.5;
		Scale 1.2;
		Translation "0:255=%[0.00,0.00,0.00]:[0.07,0.36,0.83]";
	}
	States
	{
	Spawn:
		M_TR C 1 NoDelay { A_SetRoll(frandom(0, 360)); }
		M_TR CCDDDEEEFFFGGGH 1
		{
			A_SetScale(Scale.X - 0.175);
			A_FadeOut(0.05);
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
		TRAC B 1 Bright
		{
			for (int i = 0; i < 2; i++)
				A_SpawnParticle(0xffffff, SPF_FULLBRIGHT | SPF_RELATIVE, random(10, 35), random(10, 15),
					frandom(0, 360), frandom(-4, 4), frandom(-4, 4), frandom(-4, 4),
					frandom(-0.35, 0.35), frandom(-0.35, 0.35), frandom(-0.35, 0.35), sizestep: -0.625);
		}
		Loop;
	Death:
		TNT1 A 1
		{
			A_Explode(100, 100, 0, 1);
			A_SpawnItemEx("PBWP_CA_HolyFlame", flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION);
			for (int i = 0; i < 8; i++)
			{
				A_SpawnProjectile("HitSpark", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
				A_SpawnProjectile("HitSpark22", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
				A_SpawnProjectile("HitSpark23", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
			}
			for (int i = 0; i < 12; i++)
				A_SpawnParticle(0xffffff, SPF_FULLBRIGHT, random(40, 55), 10, frandom(0, 360),
					frandom(-7.5, 7.5), frandom(-7.5, 7.5), frandom(-7.5, 7.5),
					frandom(-6, 6), frandom(-6, 6), frandom(0.5, 11.4), accelz: -0.85, sizestep: -0.425);
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
		Alpha 0.1;
		Scale 0.5;
		Translation "0:255=%[0.00,0.00,0.00]:[1.74,1.74,1.74]";
	}
	States
	{
	Spawn:
		EF2_ B 0
		{
			if (Scale.X <= 0.0001 || Alpha <= 0.0001)
				Destroy();
			A_SetScale(Scale.X - 0.005, Scale.X - 0.005);
		}
		EF2_ B 1 { A_FadeOut(0.0025); }
		Loop;
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
			for (int i = 0; i < 2; i++)
				A_SpawnItemEx("PBWP_CA_MonoExplosionSmall", frandom(-6, 6), frandom(-6, 6), frandom(-6, 6),
					flags: SXF_NOCHECKPOSITION);
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
		EF1_ I 1 Bright
		{
			if (Alpha <= 0.05 || Scale.X <= 0.05)
				Destroy();
			A_FadeOut(0.03555);
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
		BF3X ABCB 1 Bright
		{
			roll = frandom(0, 360);
			if ((level.time % 3) == 0)
				A_SpawnItemEx("PBWP_CA_ElecDeathBurst", frandom(-10, 10), frandom(-10, 10), frandom(-10, 10),
					flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 160);
			A_SpawnParticle(0x148c1c, SPF_FULLBRIGHT | SPF_RELATIVE, random(30, 45), random(8, 14),
				frandom(0, 360), frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5),
				fadestepf: 0.018, sizestep: 0.4);
			A_SpawnParticle(0xc9ffa3, SPF_FULLBRIGHT | SPF_RELATIVE, random(18, 28), random(5, 9),
				frandom(0, 360), frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5),
				fadestepf: 0.02, sizestep: 0.25);
		}
		Loop;
	Death:
		BF4X A 1 Bright
		{
			A_SpawnItem("PBWP_CA_BfgGreenPuff");
			for (int i = 0; i < 4; i++)
				A_SpawnItemEx("PBWP_CA_ElecDeathBurst", frandom(-10, 10), frandom(-10, 10), frandom(-10, 10),
					flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 40);
			A_Explode(256, 256);
		}
		BF4X D 2 Bright { A_BFGSpray("PBWP_CA_BFGExtra", damagecnt: 20); }
		BF4X EEFFGG 2 Bright;
		Stop;
	}
}

// Dispatcher — blue plasma bolt (DCY_RehauledPlasma fold)
class PBWP_CA_RehauledPlasma : FastProjectile
{
	default
	{
		+BRIGHT;
		+ROLLSPRITE;
		+FORCEXYBILLBOARD;
		+BLOODLESSIMPACT;
		Radius 13;
		Height 8;
		Damage 5;
		Speed 25;
		RenderStyle "Add";
		Alpha 1.0;
		SeeSound "weapons/plasmaf2";
		DeathSound "LASRX";
		DamageType "Plasma";
		Translation "0:255=%[0.00,0.00,0.00]:[0.57,0.80,1.43]";
	}

	states
	{
	Spawn:
		BLPL AABBCCDD 1 Bright
		{
			A_SetRoll(frandom(0.0, 360.0));
			if (random(0, 2) == 0)
				A_SpawnItemEx("PBWP_CA_FluorescentSparkle", frandom(-8, 8), frandom(-8, 8), frandom(-8, 8),
					flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION);
			A_SpawnItemEx("PBWP_CA_PlasmaCWTrail", flags: SXF_TRANSFERTRANSLATION | SXF_TRANSFERSCALE | SXF_TRANSFERROLL);
			if ((level.time % 2) == 0)
			{
				A_SpawnParticle(0x3399ff, SPF_FULLBRIGHT | SPF_RELATIVE, random(20, 35), random(6, 10),
					frandom(0, 360), frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5),
					fadestepf: 0.05, sizestep: -0.2);
			}
		}
		Loop;
	Death:
		PLS1 A 3 Bright
		{
			A_SetScale(1.0, 1.0);
			A_SetRoll(frandom(0, 360));
			for (int i = 0; i < 6; i++)
				A_SpawnParticle(0x3399ff, SPF_FULLBRIGHT, random(18, 30), random(5, 9), frandom(0, 360),
					frandom(-4, 4), frandom(-4, 4), frandom(-4, 4), fadestepf: 0.05, sizestep: -0.25);
		}
		C3AL ABCDE 2 Bright;
		PLS1 BCDE 2 Bright;
		Stop;
	}
}

// --- Upstream hybrid FX helpers (batch 2) ---

class PBWP_CA_ExplosionSmall : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		+ROLLSPRITE;
		+THRUACTORS;
		+DONTSPLASH;
		RenderStyle "Add";
		Alpha 0.8;
		Scale 0.35;
	}
	States
	{
	Spawn:
		BEWM A 0 NoDelay { A_SetRoll(random(0, 360)); }
		BEWM ACDEGHJKMOPRSUVXZ 1 { A_FadeOut(0.005); A_SetScale(Scale.X + 0.01, Scale.Y + 0.01); }
		B2WM ACFGGGGGGG 1 { A_FadeOut(0.05); A_SetScale(Scale.X + 0.01, Scale.Y + 0.01); }
		Stop;
	}
}

class PBWP_CA_MonoExplosionSmall : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		+ROLLSPRITE;
		+THRUACTORS;
		RenderStyle "Add";
		Alpha 0.8;
		Scale 0.35;
		Translation "80:111=[138,138,138]:[0,0,0]", "0:255=%[0.00,0.00,0.00]:[0.31,0.31,0.31]";
	}
	States
	{
	Spawn:
		BE2M A 0 NoDelay { A_SetRoll(random(0, 360)); }
		BE2M ACDEGHJKMOPRSUVXZ 1 { A_FadeOut(0.005); A_SetScale(Scale.X + 0.01, Scale.Y + 0.01); }
		B22M ACFGGGGGGG 1 { A_FadeOut(0.05); A_SetScale(Scale.X + 0.01, Scale.Y + 0.01); }
		Stop;
	}
}

class PBWP_CA_HolyFlame : Actor
{
	Default
	{
		+BRIGHT;
		RenderStyle "Add";
		Scale 2.0;
		Translation "0:255=%[0.00,0.00,0.00]:[1.74,1.74,1.74]";
	}
	States
	{
	Spawn:
		BPX0 A 0 NoDelay { A_SetScale(frandompick(Scale.X, -Scale.X), Scale.Y); }
		BPX0 ABCD 2;
		BPX0 E 2 { A_ChangeVelocity(0, 0, 1); }
		BPX0 FG 2;
		Stop;
	}
}

class PBWP_CA_BfgArc : Actor
{
	Default
	{
		+NOINTERACTION;
		+BRIGHT;
		+ROLLSPRITE;
		+FLATSPRITE;
		RenderStyle "Add";
		Scale 0.5;
		Translation "0:255=%[0.00,0.00,0.00]:[1.03,2.00,0.70]";
	}
	States
	{
	Spawn:
		L1G5 A 0 NoDelay
		{
			A_SetScale(frandompick(Scale.X, -Scale.X), Scale.Y);
			A_SetRoll(frandom(0, 360));
			A_SetAngle(frandom(0, 360));
		}
		L1G5 AAAA 1 { A_SetScale(Scale.X + 0.1); }
		Stop;
	}
}

class PBWP_CA_ElecDeathBurst : Actor
{
	Default
	{
		+NOINTERACTION;
		+BRIGHT;
		+ROLLSPRITE;
		RenderStyle "Add";
		Translation "0:255=%[0.00,0.00,0.00]:[1.03,2.00,0.70]";
	}
	States
	{
	Spawn:
		"4L4C" A 0 NoDelay { roll = frandom(0, 360); }
		"4L4C" ABCDEFG 2;
		Stop;
	}
}

class PBWP_CA_FluorescentSparkle : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		+ROLLSPRITE;
		RenderStyle "Add";
		Translation "0:255=%[0.00,0.00,0.50]:[0.57,0.80,1.43]";
	}
	States
	{
	Spawn:
		SP4K A 0 NoDelay { A_SetRoll(frandom(0, 360)); }
		SP4K ABCDEFG 2;
		Stop;
	}
}

class PBWP_CA_PlasmaCWTrail : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		RenderStyle "Add";
		Alpha 0.55;
		Scale 0.55;
		Translation "0:255=%[0.00,0.00,0.50]:[0.57,0.80,1.43]";
	}
	States
	{
	Spawn:
		SUE1 CCDDDDEEEEFFFF 1 { A_FadeOut(0.1); roll += 3; }
		Stop;
	}
}

class PBWP_CA_GrenadeFlare : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		+ROLLSPRITE;
		RenderStyle "Add";
		Translation "0:255=%[0.00,0.00,0.00]:[1.40,0.75,0.12]";
	}
	States
	{
	Spawn:
		TNT1 A 3 NoDelay { A_SetScale(frandompick(Scale.X, -Scale.X), Scale.Y); }
		"3XP0" ABCDE 2;
		Stop;
	}
}

class PBWP_CA_AurumRailSpark : Actor
{
	Default
	{
		+MISSILE;
		+FORCEXYBILLBOARD;
		+BRIGHT;
		RenderStyle "Add";
		Scale 0.5;
		Gravity 0.75;
		BounceType "Hexen";
		BounceFactor 9999999;
		BounceCount 999999999;
		Translation "0:255=%[0.00,0.00,0.00]:[2.00,1.49,0.72]";
	}
	States
	{
	Spawn:
		NULL A 3 NoDelay { A_Gravity(); }
		NULL A 1
		{
			if (Scale.X <= 0)
				Destroy();
			A_Gravity();
			A_SetScale(Scale.X - 0.055);
			A_FadeOut(0.000751);
		}
		Loop;
	}
}

// Warbringer / Nightfall — upstream DCY_TracerPlayer visual + PB impact layer
class PBWP_CA_RifleTracer : FastProjectile
{
	Default
	{
		+RANDOMIZE;
		+FORCEXYBILLBOARD;
		+NOEXTREMEDEATH;
		+BRIGHT;
		+MISSILE;
		Damage 0;
		Radius 2;
		Height 2;
		Speed 140;
		RenderStyle "Add";
		Alpha 0.9;
		Scale 0.13;
	}
	States
	{
	Spawn:
		TRAC A 1 Bright;
		Loop;
	Death:
		TNT1 A 0
		{
			A_StartSound("DCYBullet/Hit", CHAN_BODY, CHANF_DEFAULT, 0.5);
			for (int i = 0; i < 3; i++)
			{
				A_SpawnProjectile("HitSpark", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
				A_SpawnProjectile("HitSpark22", 2, 0, frandom(0, 1) * frandom(0, 360), 2, frandom(0, 1) * frandom(30, 360));
			}
			A_SpawnItemEx("PlasmaSmoke", flags: SXF_NOCHECKPOSITION);
		}
		Stop;
	}
}

// Nightfall laser mode — upstream DCY_MechaZombiePlasma2 bolt (TRAC E)
class PBWP_CA_MinigunLaserBolt : FastProjectile
{
	Default
	{
		+RANDOMIZE;
		+FORCEXYBILLBOARD;
		+NOEXTREMEDEATH;
		+BRIGHT;
		+MISSILE;
		Damage 0;
		Radius 5;
		Height 5;
		Speed 140;
		RenderStyle "Add";
		Alpha 0.95;
		Scale 0.15;
		Translation "0:255=%[0.00,0.00,0.00]:[0.07,0.36,0.83]";
		SeeSound "DSPLASM4";
	}
	States
	{
	Spawn:
		TRAC E 1 Bright;
		Loop;
	Death:
		TNT1 A 0 { A_SpawnItem("PBWP_CA_NeonicPuff"); }
		TNT1 A 2;
		Stop;
	}
}

// Nightfall emphasis — upstream DCY_Blastawave (WV00 bolt + MPB_ impact)
class PBWP_CA_BlastawaveTrail : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		RenderStyle "Add";
		Scale 0.8;
		Translation "0:255=%[0.00,0.00,0.00]:[0.43,0.75,1.57]";
	}
	States
	{
	Spawn:
		WV00 ABCDE 1
		{
			A_SetScale(Scale.X - 0.01);
			A_FadeOut(0.2);
		}
		Stop;
	}
}

class PBWP_CA_BlastaThunder : Actor
{
	Default
	{
		+NOINTERACTION;
		+BRIGHT;
		Translation "0:255=%[0.00,0.00,0.50]:[1.01,2.00,2.00]";
	}
	States
	{
	Spawn:
		TNT1 AAAAAAAAAAAAAAAA 1
		{
			tics = random(0, 1);
			A_ChangeVelocity(frandom(-1.5, 1.5), frandom(-1.5, 1.5), frandom(-1.5, 1.5));
			A_SpawnParticle(0xacfdfc, SPF_FULLBRIGHT, random(10, 20), random(12, 18), frandom(0, 360),
				frandom(-1.5, 1.5), frandom(-1.5, 1.5), frandom(-1.5, 1.5));
		}
		Goto Death;
	Death:
		C3AL ABCDE 2;
		Stop;
	}
}

class PBWP_CA_Blastawave : FastProjectile
{
	Default
	{
		+BRIGHT;
		+FORCEXYBILLBOARD;
		-RANDOMIZE;
		Radius 10;
		Height 20;
		Damage 30;
		Speed 65;
		Scale 0.8;
		SeeSound "";
		DeathSound "CARCATKX";
		DamageType "Plasma";
		Translation "0:255=%[0.00,0.00,0.00]:[0.43,0.75,1.57]";
	}
	States
	{
	Spawn:
		WV00 AB 1
		{
			A_SpawnItemEx("PBWP_CA_BlastawaveTrail", flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION | SXF_TRANSFERSCALE);
		}
		Loop;
	Death:
		MPB_ H 3
		{
			A_SetScale(1.0, 1.0);
			A_SetRoll(frandom(0, 360));
			for (int i = 4; i > 0; i--)
			{
				A_SpawnParticle(0x7ccdfc, SPF_FULLBRIGHT, random(20, 40), random(6, 9), frandom(0, 360),
					frandom(-6.5, 6.5), frandom(-6.5, 6.5), frandom(-6.5, 6.5));
				A_SpawnItemEx("PBWP_CA_BlastaThunder", frandom(-10, 10), frandom(-10, 10), frandom(-10, 10),
					frandom(5, 10), 0, frandom(-7, 7), frandom(0, 360),
					SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, failchance: 120);
			}
		}
		MPB_ IJKL 2;
		Stop;
	}
}

// Intervention napalm alt — upstream DCY_Napalm (simplified fire pool)
class PBWP_CA_NapalmFire : Actor
{
	int fireDuration;

	Default
	{
		+FORCERADIUSDMG;
		+NOBLOCKMAP;
		+NOGRAVITY;
		+BRIGHT;
		DamageType "Fire";
		Radius 12;
		Height 12;
		RenderStyle "Add";
		Alpha 0.85;
		Scale 1.0;
		Translation "0:255=%[0.00,0.00,0.00]:[1.98,1.18,0.53]";
	}

	States
	{
	Spawn:
		TNT1 A 0 { fireDuration = 85; }
	Idle:
		TNT1 A 4
		{
			if (--fireDuration <= 0)
			{
				A_FadeOut(0.15);
				Destroy();
			}
			A_Explode(3, 64, 1);
			for (int i = 0; i < 3; i++)
				A_SpawnParticle(randompick(0xffffff, 0xffd77a, 0xff983d), SPF_FULLBRIGHT, random(20, 35),
					random(4, 8), frandom(0, 360), frandom(-2, 2), frandom(-2, 2), frandom(0, 4),
					fadestepf: 0.05, sizestep: -0.2);
		}
		Loop;
	}
}

class PBWP_CA_NapalmEmber : FastProjectile
{
	Default
	{
		+RIPPER;
		+BLOODLESSIMPACT;
		+BRIGHT;
		+NEVERFAST;
		-NOGRAVITY;
		DamageType "Fire";
		Damage 5;
		Speed 18;
		Gravity 0.7;
		Scale 1.0;
		RenderStyle "Add";
		Translation "0:255=%[0.00,0.00,0.00]:[1.98,1.18,0.53]";
	}
	States
	{
	Spawn:
		TNT1 A 1 Bright
		{
			if (waterlevel > 0)
				Destroy();
			A_SpawnParticle(randompick(0xffffff, 0xffd77a, 0xff983d), SPF_FULLBRIGHT, 35, random(9, 13),
				frandom(0, 360), frandom(-1, 1), frandom(-1, 1), frandom(-1, 1), fadestepf: 0.04, sizestep: -0.3);
		}
		Loop;
	Death:
		TNT1 A 0
		{
			let fire = Spawn("PBWP_CA_NapalmFire", pos, NO_REPLACE);
			if (fire)
				fire.scale *= 0.95;
		}
		Stop;
	}
}

class PBWP_CA_NapalmGrenade : PBWP_CA_Grenade
{
	Default
	{
		DeathSound "DCYBFGX/Explode";
	}

	States
	{
	Spawn:
		MNAD A 1 Bright
		{
			roll = roll + frandom(-10, 10);
			if ((level.time % 4) == 0)
				A_CustomMissile("RocketSmokeTrail52Moving", 2, 0, random(70, 110), 2, random(0, 360));
			if ((level.time % 2) == 0)
			{
				A_SpawnItemEx("PBWP_CA_GrenadeFlare", frandom(-2.5, 2.5), frandom(-2.5, 2.5), frandom(-2.5, 2.5),
					flags: SXF_NOCHECKPOSITION);
				A_SpawnParticle(randompick(0xffffff, 0xffd77a, 0xff983d), SPF_FULLBRIGHT, random(20, 40),
					random(3, 9), frandom(0, 360), frandom(-4, 4), frandom(-4, 4), frandom(-4, 4),
					fadestepf: 0.05, sizestep: -0.3);
			}
		}
		Loop;
	Death:
		MNAD A 1 Bright;
		NBKL D 2 Bright
		{
			A_Explode(128, 128);
			A_SpawnItem("PBWP_CA_GrenadePuff");
			bNoGravity = true;
			A_QuakeEx(2, 2, 2, 20, 0, 450, "none", QF_SCALEDOWN | QF_3D);
			let fire = Spawn("PBWP_CA_NapalmFire", pos, NO_REPLACE);
			if (fire)
				fire.scale *= 1.35;
			for (int i = 5; i > 0; i--)
			{
				A_SpawnItemEx("PBWP_CA_NapalmEmber", frandom(-7, 7), frandom(-7, 7), frandom(-7, 7),
					frandom(-7, 7), frandom(-7, 7), frandom(1, 10), frandom(0, 360),
					SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION);
			}
		}
		NBKL E 2 Bright
		{
			for (int i = 3; i > 0; i--)
				A_SpawnItemEx("PBWP_CA_ExplosionSmall", frandom(-4, 4), frandom(-4, 4), frandom(-2, 2),
					frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(-0.5, 0.5), frandom(0, 360),
					SXF_NOCHECKPOSITION);
		}
		NBKL FGHIJKLM 2 Bright;
		Stop;
	}
}

// Legionnaire — upstream DCY_OverhauledRocket fold
class PBWP_CA_LegionnaireRocket : Rocket
{
	Default
	{
		DamageType "Explosive";
		Speed 32;
		Damage 20;
		Radius 11;
		Height 8;
		Scale 1.2;
		+DEHEXPLOSION;
		+RANDOMIZE;
		SeeSound "RocketLauncher/Kaboom";
		DeathSound "Explod";
		RenderStyle "Normal";
	}
	States
	{
	Spawn:
		NMSL A 1 Bright
		{
			if ((level.time % 3) == 0)
			{
				A_SpawnParticle(0xff3e1f, SPF_FULLBRIGHT | SPF_RELATIVE, random(20, 35), random(4, 8),
					frandom(0, 360), frandom(-1, 1), frandom(-1, 1), frandom(-1, 1), fadestepf: 0.05, sizestep: -0.2);
				A_SpawnItemEx("PBWP_CA_GrenadeFlare", frandom(-2.5, 2.5), frandom(-2.5, 2.5), frandom(-2.5, 2.5),
					flags: SXF_NOCHECKPOSITION);
			}
		}
		Loop;
	Death:
		TNT1 A 0;
		TNT1 A 5 Bright
		{
			A_Explode(128, 128);
			A_SpawnItem("PBWP_CA_GrenadePuff");
			A_QuakeEx(2, 2, 2, 20, 0, 200, "none", QF_SCALEDOWN);
			for (int i = 0; i < 3; i++)
				A_SpawnItemEx("PBWP_CA_ExplosionSmall", frandom(-5, 5), frandom(-5, 5), frandom(-2, 2),
					frandom(-0.85, 0.85), frandom(-0.85, 0.85), frandom(-0.85, 0.85), frandom(0, 360),
					SXF_NOCHECKPOSITION);
		}
		Stop;
	}
}

// Sirius Crisis — charge-track + laser bolt + BFG sphere (simplified upstream fold)
class PBWP_CA_SiriusTrack : Actor
{
	Default
	{
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		+NOTIMEFREEZE;
		RenderStyle "Add";
		Alpha 0.45;
		Scale 0.35;
		Translation "0:255=%[0.00,0.00,0.00]:[1.06,1.66,1.83]";
	}
	States
	{
	Spawn:
		SRB0 C 0;
		SRB0 C 3 { A_FadeOut(0.12); A_SetScale(Scale.X + 0.05); }
		Stop;
	}
}

class PBWP_CA_SiriusSmoke : Actor
{
	Default
	{
		+NOINTERACTION;
		+BRIGHT;
		+ROLLSPRITE;
		RenderStyle "Add";
		Alpha 0.65;
		Scale 1.5;
		Translation "0:255=%[0.00,0.00,0.00]:[1.06,1.66,1.83]";
	}
	States
	{
	Spawn:
		SE1Z A 0 NoDelay { A_SetRoll(frandom(0, 360)); }
		SE1Z AB 2;
		SE1Z AAAAAAAA 1 { A_FadeOut(0.08); }
		Stop;
	}
}

class PBWP_CA_SiriusLaser : FastProjectile
{
	Default
	{
		+BRIGHT;
		+FORCEXYBILLBOARD;
		+FORCERADIUSDMG;
		Damage 10;
		Radius 10;
		Height 10;
		Speed 140;
		Scale 0.6;
		Translation "0:255=%[0.00,0.00,0.00]:[1.06,1.66,1.83]";
		DamageType "Plasma";
	}
	States
	{
	Spawn:
		TRAC E 1 Bright { A_Explode(10, 30); }
		Loop;
	Death:
		XDeath:
		TNT1 A 0
		{
			A_SpawnItem("PBWP_CA_NeonicPuff");
			for (int i = 0; i < 8; i++)
				A_SpawnItemEx("PBWP_CA_SiriusSmoke", frandom(-3, 3), frandom(-3, 3), frandom(-3, 3),
					frandom(-3, 3), frandom(-3, 3), frandom(-3, 3), frandom(0, 360), SXF_NOCHECKPOSITION);
			A_QuakeEx(4, 4, 4, 40, 0, 900, "none", QF_SCALEDOWN);
		}
		TNT1 A 1 { A_Explode(300, 350); }
		TNT1 AAAAAAAA 4
		{
			A_Explode(300, 350);
			for (int i = 0; i < 2; i++)
				A_SpawnItemEx("PBWP_CA_SiriusSmoke", frandom(-3, 3), frandom(-3, 3), frandom(-3, 3),
					frandom(-3, 3), frandom(-3, 3), frandom(-3, 3), frandom(0, 360), SXF_NOCHECKPOSITION);
		}
		Stop;
	}
}

class PBWP_CA_SiriusBFGBall : Actor
{
	int sspeed;

	Default
	{
		+BRIGHT;
		+FORCEXYBILLBOARD;
		+FORCERADIUSDMG;
		+RIPPER;
		+MISSILE;
		Damage 10;
		DamageType "BFG";
		Radius 35;
		Height 35;
		Speed 3;
		RenderStyle "Add";
		Alpha 0.85;
		Scale 1.0;
		Translation "0:255=%[1.02,1.85,1.99]:[0.00,0.00,0.34]";
	}

	void PBWP_SiriusTrail()
	{
		A_SpawnItemEx("PBWP_CA_SiriusSmoke", frandom(-2, 2), frandom(-2, 2), frandom(-2, 2),
			flags: SXF_NOCHECKPOSITION);
		if (sspeed > 64 && sspeed < 128)
			vel += vel.unit() * 0.875;
		sspeed++;
	}

	States
	{
	Spawn:
		TNT1 A 0;
		BVDP A 1 Bright
		{
			PBWP_SiriusTrail();
			A_StartSound("SiriusBFG/Loop", CHAN_BODY, CHANF_LOOPING, 1.0);
		}
		BVDP ABBCC 1 Bright { PBWP_SiriusTrail(); }
		Loop;
	Death:
		BVDP A 1 Bright
		{
			A_StopSound(CHAN_BODY);
			A_StartSound("SiriusBFG/DeathWait", CHAN_AUTO, 0, 1.0, 0.5);
			A_Explode(80, 300, 1);
			for (int i = 0; i < 4; i++)
				A_SpawnItemEx("PBWP_CA_SiriusSmoke", frandom(-20, 20), frandom(-20, 20), frandom(-20, 20),
					frandom(-20, 20), frandom(-20, 20), frandom(-20, 20), frandom(0, 360), SXF_NOCHECKPOSITION);
		}
		PKCH ABCDE 2 Bright { A_Explode(80, 300, 1); }
		TNT1 A 0
		{
			for (int i = 0; i < 4; i++)
				A_StartSound("SiriusBFG/DeathStart", i, CHANF_DEFAULT, 1.0, 0.45);
			A_QuakeEx(8, 8, 8, 90, 0, 1400, "none", QF_SCALEDOWN);
			A_QuakeEx(3, 3, 3, 125, 0, 2222, "none", QF_SCALEDOWN);
		}
		TNT1 A 1
		{
			A_Explode(700, 400, 1);
			A_Explode(350, 800, 1);
			A_Explode(200, 1200, 1);
			for (int i = 0; i < 6; i++)
				A_SpawnItemEx("PBWP_CA_SiriusSmoke", frandom(-50, 50), frandom(-50, 50), frandom(-50, 50),
					frandom(-50, 50), frandom(-50, 50), frandom(-50, 50), frandom(0, 360), SXF_NOCHECKPOSITION);
		}
		TNT1 A 40;
		Stop;
	}
}

// Legacy aliases (avoid breaking references)
class PBWP_CA_BFGRailTrail : PBWP_CA_BfgGreenRailTrail {}
class PBWP_CA_BFGPuff : PBWP_CA_BfgGreenPuff {}
