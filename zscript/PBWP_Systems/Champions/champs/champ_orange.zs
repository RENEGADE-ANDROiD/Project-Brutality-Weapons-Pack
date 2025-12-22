/*
 *
 *		Orange Champion
 *			Explodes on Death
 *
 */
class champion_OrangeController : champion_BaseController
	{
	double missileofs;
	class<actor> explosiontype;

	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"ffffff", "ff9900", "ffad33", "ff5c33", "ff3300"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[2]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[2]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		if(colours)
			champion.A_SetTranslation("champion_Orange");
		
		if(icons)
			champion_SpawnIcon(2,"champ_Orange");
		
		missileofs = champion.Height * 0.5;
		explosiontype = "champion_Explosion";
		}
	override void champion_LegendoomSpecial()
		{
		explosiontype = "champion_ClusterExplosion";
		}
		
	override void champion_DeathEffect()
		{
		let explosion = champion.Spawn(explosiontype, (champion.pos.x,champion.pos.y,champion.pos.z+missileofs),0);
		if(explosion)
			{
			explosion.target = champion.target;
			}
		}
	}
	
class champion_Explosion : Rocket
	{
	default
		{
		-ROCKETTRAIL;
		speed 0;
		}
	states
		{
		Spawn:
			TNT1 A 0 NoDelay A_PlaySound("weapons/rocklx");
		Death:
			OEXP A 8 Bright A_Explode();
			OEXP B 6 Bright;
			OEXP C 4 Bright;
			stop;
		}
	}
	
class champion_ClusterExplosion : Rocket
	{
	default
		{
		-ROCKETTRAIL;
		speed 0;
		}
	states
		{
		Spawn:
			TNT1 A 0 NoDelay A_PlaySound("weapons/rocklx");
		Death:
			OEXP A 8 Bright 
				{
				for(int i = 0; i < 8; i++)
					{
					A_SpawnItemEx("champion_MiniCluster",	xvel:frandom(4.0,8.0),
															zvel:frandom(4.0,8.0),
															angle:random(0,360));
					}
				A_Explode();
				}
			OEXP B 6 Bright;
			OEXP C 4 Bright;
			stop;
		}
	}
	
class champion_MiniCluster : champion_Fireball1
	{
	default
		{
		DamageFunction (0);
		Gravity 0.6;
		Scale 0.75;
		DeathSound "";
		Translation "champion_Grey";
		Renderstyle "Normal";
		+DEHEXPLOSION;
		}
	states
		{
		Death:
			OEXP A 8 Bright 
				{
				A_SetTranslation("none");
				A_Explode(64,64);
				A_PlaySound("weapons/rocklx",CHAN_BODY,0.2);
				}
			OEXP B 6 Bright;
			OEXP C 4 Bright;
			stop;
		}
	}