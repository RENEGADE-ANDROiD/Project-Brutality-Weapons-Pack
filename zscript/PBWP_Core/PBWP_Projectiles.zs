class PB_357Magnum : PB_500SW
{
	Default
	{
		PB_Projectile.BaseDamage 120;
		PB_Projectile.RipperCount 4;
		PB_Projectile.PenetrationCount 5;
		+PB_Projectile.WHIZCRACK;
		Obituary "%o was shot at somewhere else by %k.";
	}
}

class PB_444Marlin : PB_500SW
{
	Default
	{
		PB_Projectile.BaseDamage 200;
		PB_Projectile.RipperCount 5;
		PB_Projectile.PenetrationCount 5;
		+PB_Projectile.WHIZCRACK;
		DamageType "SSG";
		Obituary "%o was Hard hit with punch of Marlin by %k.";
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