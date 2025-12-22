/*
 *
 *		Gold Champion
 *			<effect>
 *
 */
class champion_GoldController : champion_BaseController
	{
	int radfactor;
	class<inventory> Midas;
	
	override void champion_SpawnParticles()
		{
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[16]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[16]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		eftic = 1;
		champion.Painchance = int(champion.PainChance * 0.1);
		champion.Health = int(champion.Health * 5.0);
		champion.Mass *= 12;
		champion.bNOBLOOD = true;
		if(colours) 
			champion.A_SetTranslation("champion_Golden");
		
		if(icons)
			champion_SpawnIcon(16,"champ_Gold");
			
		radfactor = 3.0;
		midas = "champion_MidasTouch1";
		}
	
	override void champion_LegendoomSpecial()
		{
		radfactor = 5.0;
		midas = "champion_MidasTouch2";
		}
	
	override void champion_TickEffect()
		{
		if(!random(0,1))
			{
			champion.A_RadiusGive(midas, champion.Radius*radfactor,RGF_MONSTERS|RGF_EXFILTER, filter:"champion_Heart");
			champion.A_SpawnItemEx("champion_Sparkle",	xofs:champion.radius,
														zofs:frandom(0,champion.height),
														angle:random(0,359),
														failchance:224);
			}
		if(champion && champion.health < 1 || champion.tics <= 0) { return; } 
		
        if (prevState != champion.curState)
			{ champion.A_SetTics (int(champion.tics * 1.75)); }

        prevState = champion.curState;
		}
		
	override void champion_DeathEffect()
		{
		}
	}
	
class champion_MidasTouch1 : CustomInventory
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
				if(invoker.owner)
					{
					if(invoker.owner.bSPECIAL || invoker.owner.bWEAPONSPAWN)
						return;
						
					if(invoker.owner.CountInv("champion_GoldToken"))
						return;
					
					invoker.owner.A_GiveInventory("champion_GoldToken");
					invoker.owner.A_SetTranslation("champion_Golden");
					invoker.owner.Mass *= 12;
					invoker.owner.Painchance = int(invoker.owner.Painchance * 0.1);
					invoker.owner.DamageFactor *= 0.66;
					invoker.owner.bNOBLOOD = true;
					}
				}
			stop;
		}
	}
	
class champion_MidasTouch2 : CustomInventory
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
				if(invoker.owner)
					{
					if(invoker.owner.bSPECIAL || invoker.owner.bWEAPONSPAWN)
						return;
						
					if(invoker.owner.CountInv("champion_GoldToken"))
						return;
					
					invoker.owner.A_GiveInventory("champion_GoldToken");
					invoker.owner.A_SetTranslation("champion_Golden");
					invoker.owner.Mass *= 12;
					invoker.owner.Painchance = int(invoker.owner.Painchance * 0.1);
					invoker.owner.DamageFactor *= 0.33;
					invoker.owner.bNOBLOOD = true;
					}
				}
			stop;
		}
	}