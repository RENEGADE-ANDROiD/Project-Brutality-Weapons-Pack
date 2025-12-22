/*
 *
 *		Pink Champion
 *			resurrects nearby enemies, for a price.
 *
 */
class champion_PinkController : champion_BaseController
	{
	int healing;
	int radfactor;
	int cockblock;
	
	//int starthealth;

	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"ff8aa0", "ff6682", "ffccd5", "ffb3ff", "ffffff"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[10]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[10]));
			if(token)
				token.Secondary = true;
			}
		}

	override void champion_InitEffect()
		{
		eftic = 70;
		starthealth = champion.Health;
		if(colours) 
			champion.A_SetTranslation("champion_Pink");
			
		if(icons)
			champion_SpawnIcon(10,"champ_Pink");
		
		radfactor = 4;
		}
	
	override void champion_LegendoomSpecial()
		{
		radfactor = 8;
		}
	
	override void champion_TickEffect()
		{
/* 		if(cockblock)
			{
			cockblock--; return;
			} */
		
		if(champion.health <= starthealth * 0.2)
			return;

		ThinkerIterator think = ThinkerIterator.Create("Actor");
		actor mo;
		while(mo = Actor(think.Next()))
			{
            if(	mo.Distance2D(champion) < (champion.radius * radfactor) && 
				mo.bISMONSTER && mo.Health < 1 							&& 
				mo.FindState("Raise")									&&
				!mo.CountInv("champion_PinkToken") 						&&
				!mo.CountInv("champion_NullToken"))
				{   
                if(mo.RaiseActor(mo))
					champion.A_DamageSelf(int(starthealth * 0.2));
				}
			}		
		}
	
	override void champion_HitEffect()
		{
		if(cockblock)
			return;
			
		cockblock = 3;
		}
	}
 
class champion_HealingCross : Actor
	{
	default
		{
		+NOINTERACTION;
		+NOGRAVITY;
		+BRIGHT;
		//Renderstyle "Translucent";
		Scale 1.0;
		alpha 0.0;
		}
	states
		{
		Spawn:
			CROS AAAA 1 A_FadeIn();
			CROS A 5;
			CROS AAAA 1 A_FadeOut();
			wait;
		}
	}
	
class champion_Resurrection : CustomInventory
	{
	default
		{
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		}
	states
		{
		use:
			TNT1 A 0
				{
				if(invoker.owner.bSPECIAL || invoker.owner.bWEAPONSPAWN)
						return resolveState("failState");
				
				if(invoker.owner.CountInv("champion_PinkToken"))
						return resolveState("failState");
						
				RaiseActor(invoker.owner);
				return resolveState("success");
				}
			stop;
		success:
			TNT1 A 0;
			stop;
			
		failState:
			TNT1 A 0;
			fail;
		}
	}
	
class champion_HealingRing : actor
	{
	default
		{
		+NOINTERACTION;
		}
	states
		{
		Spawn:
			TNT1 A 0 NoDelay
				{
				for(int i = 0; i < 12; i++)
					{
					A_SpawnItemEx("champion_HealingCross",xofs:32.0, zvel:4.0, angle:i * 30);
					}
				}
			stop;
		}
	}