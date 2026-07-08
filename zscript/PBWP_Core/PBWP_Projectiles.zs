// PB_357Magnum / PB_444Marlin — provided by PBX-Weapons (Prosurv_LeverAction)

class PB_Complex12GAPellet : PB_12GAPellet_ASG
{
	Default
	{
      PB_Projectile.BaseDamage 28;
	}
}

class PB_MGNailCryo : PB_MGNail
{
	Default
	{
		PB_Projectile.BaseDamage 14;
		PB_Projectile.RipperCount 3;
		+FORCEPAIN;
		+BRIGHT;
		DamageType "Ice";
		Translation "0:255=%[0.00,0.10,0.35]:[0.55,0.85,1.40]";
		Speed 90;
		Obituary "%o was chilled by %k's cryo nails.";
	}
	States
	{
	Death:
		NLPJ A 1
		{
			A_StopSound(CHAN_BODY);
			A_SpawnItemEx("HitPuff");
			A_Explode(8, 48, XF_NOTMISSILE);
			StickToWall();
		}
		Goto DeathLoop;
	}
}

class PB_SMGNail : PB_MGNail
{
	Default
	{
		PB_Projectile.BaseDamage 15;
	}
}

class PB_SMGNail1 : PB_SMGNail
{
	Default
	{
		DamageType "ExplosiveImpact";
	}
}

class PB_SMGNail2 : PB_SMGNail
{
	Default
	{
		DamageType "SSG";
	}
}

class PB_SMGNailHot : PB_MGNailHot
{
	Default
	{
		PB_Projectile.BaseDamage 25;
      DamageType "Fire";
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItem("RedFlare22");
			TNT1 A 0 A_SpawnItem ("FireballExplosionFlamesSmall");
			NLPJ B 1 BRIGHT A_StartSound("Weapons/NailFlight", CHAN_BODY, CHANF_LOOP, 1.0 );
			Goto Fly;
		Fly:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItem("RedFlare22");
			TNT1 A 0 A_SpawnItem ("FireballExplosionFlamesSmall");
			NLPJ B 1 BRIGHT A_SpawnItemEx("GunFireSmoke",0,0,-2,-7);
			Loop;
		Crash:
		Death:
			TNT1 A 0 { 
				LIFETIME = CVar.GetCVar("pb_naillifetime").GetInt(); 
				A_StopSound(CHAN_BODY);
				A_SpawnItemEx("HitPuff");
				A_SpawnItemEx("TinyBurningPiece", random (-45, 45), random (-45, 45));
				A_SpawnItem("ExplosionParticleSpawner");
				A_Stop();
            A_SpawnItem ("FireballExplosionFlamesSmall");
				A_SpawnItemEx("GunFireSmoke",0,0,-2,-7);
			}
			NLPJ B 70 BRIGHT A_SpawnItemEx("GunFireSmoke",0,0,-2,-7);
			TNT1 A 0 A_SpawnItemEx("GunFireSmoke",0,0,-2,-7);
		Hanging:
			NLPJ A 35 A_JumpIf(LIFETIME <= 0, "Fade");
			TNT1 A 0 {
				LIFETIME--;
				return A_CheckBlock("Hanging", 0, 0, (RADIUS / 2) + 1);
			}
		Drop:
			TNT1 A 0 {
				bNOINTERACTION = false;
				bNOGRAVITY = false;
				bTHRUACTORS = true;
			}
		Fade:
			NLPJ B 1 A_FadeOut(0.2,FTF_REMOVE | FTF_CLAMP);
			Loop;
	}
}