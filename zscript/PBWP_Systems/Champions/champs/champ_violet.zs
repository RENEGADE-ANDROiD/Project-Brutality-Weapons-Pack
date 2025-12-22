/*
 *
 *		Violet Champion
 *			fires projectiles occasionally
 *
 */
class champion_VioletController : champion_BaseController
	{
	
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"800080", "cc00cc", "330033", "ffb3ff", "000000"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[9]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[9]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		eftic = 30;
		if(colours) 
			champion.A_SetTranslation("champion_Violet");
		
		if(icons)
			champion_SpawnIcon(9,"champ_Violet");
				
		}
	
	override void champion_LegendoomSpecial()
		{
		eftic = 20;
		}
	
	override void champion_TickEffect()
		{
		if(champion.target && random(0,2))
			{
			int rand  = randompick(	0,0,0,
									0,0,0,
									0,0,0,
									1,1,1,
									2,2);
			switch(rand)
				{
				case 0:
					champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,0,CMF_AIMDIRECTION, pitch:-6.125);
					if(transformed)
						{
						champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,-12.5,CMF_AIMDIRECTION, pitch:-6.125);
						champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,+12.5,CMF_AIMDIRECTION, pitch:-6.125);
						}
					break;
					
				case 1:
					champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,-12.5,CMF_AIMDIRECTION, pitch:-6.125);
					champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,+12.5,CMF_AIMDIRECTION, pitch:-6.125);
					if(transformed)
						{
						champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,-25.0,CMF_AIMDIRECTION, pitch:-6.125);
						champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,+25.0,CMF_AIMDIRECTION, pitch:-6.125);
						}
					break;
					
				case 2:
					champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,0.0,CMF_AIMDIRECTION, pitch:-6.125);
					champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,+90.0,CMF_AIMDIRECTION, pitch:-6.125);
					champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,-90.0,CMF_AIMDIRECTION, pitch:-6.125);
					champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,-180.0,CMF_AIMDIRECTION, pitch:-6.125);
					if(transformed)
						{
						champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,+45.0,CMF_AIMDIRECTION, pitch:-6.125);
						champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,-45.0,CMF_AIMDIRECTION, pitch:-6.125);
						champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,+135.0,CMF_AIMDIRECTION, pitch:-6.125);
						champion.A_SpawnProjectile("champion_Fireball2",champion.height*0.5,0,-130.0,CMF_AIMDIRECTION, pitch:-6.125);
						}
					break;
				}
			}
		}
	}
	

	
class champion_Fireball2 : DoomImpBall
	{
	default
		{
		-NOGRAVITY;
		+SEEKERMISSILE;
		Speed 10;
		Gravity 0.1;
		}
	States
		{
		Spawn:
			CBAL AB 4 Bright A_SeekerMissile(0,4);
			loop;
		Death:
			CBAL CDE 4 Bright;
			stop;
		}
	}