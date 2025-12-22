/*
 *
 *		Blue Champion
 *			Explodes into projectiles on death
 *
 */
class champion_BlueController : champion_BaseController
	{
	int projectiles;
	int hitPause;
	int tiers;

	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"5959ff", "8080ff", "b3b3ff", "ffffff"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[7]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[7]));
			if(token)
				token.Secondary = true;
			}
		}

	override void champion_InitEffect()
		{
		eftic = 20;
		
		if(colours) 
			champion.A_SetTranslation("champion_Blue");
		
		if(icons)
			champion_SpawnIcon(7,"champ_Blue");
		
		projectiles = int((champion.radius * 0.33)*2);
		
		tiers = int(max(1,champion.Height / 32));
		
		tiers = int(tiers * (champion.bBOSS ? 1.5 : 1));
		
		}
		
	override void champion_LegendoomSpecial()
		{
		projectiles = int(champion.radius * 0.50);
		}
		
	override void champion_TickEffect()
		{
		if(hitPause)
			hitPause--;
		}
		
	override void champion_DeathEffect()
		{
		double step = double(360.0 / double(projectiles));
		
		for(int j = 0; j < tiers; j++)
			{
			for(int i = 0; i < projectiles; i++)
				{
				double ang = ((step*0.5)*j)+(i*step);
				champion.A_SpawnProjectile("champion_Fireball1",spawnHeight:random(-4,4)+(24+(j*24)), angle:ang, flags:CMF_AIMDIRECTION, pitch:-6.125);
				
				}
			}
		}
	
	override void champion_HitEffect()
		{
		if(!random(0,4) && !hitpause)
			{
			hitpause = random(1,4);
			int proj2 = int(projectiles * 0.25);
			double step = 360 / proj2;
			for(int i = 0; i < proj2; i++)
				{
				champion.A_SpawnProjectile("champion_Fireball1",angle:i*step, flags:CMF_AIMDIRECTION, pitch:-6.125);
				}			
			}
		}
	}
	
class champion_Fireball1 : DoomImpBall
	{
	default
		{
		-NOGRAVITY;
		Speed 10;
		Damage 3;
		Gravity 0.1;
		}
	override int SpecialMissileHit(actor victim)
		{
		if(victim && target && victim is target.GetClassName())
			return 1;
		return -1;
		}
	States
		{
		Spawn:
			CBAL AB 4 Bright;
			loop;
		Death:
			CBAL CDE 4 Bright;
			stop;
		}
	}