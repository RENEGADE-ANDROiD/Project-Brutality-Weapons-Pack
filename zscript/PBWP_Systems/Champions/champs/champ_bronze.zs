/*
 *
 *		Bronze Champion
 *			<effect>
 *
 */
class champion_BronzeController : champion_BaseController
	{
	override void champion_SpawnParticles()
		{
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[14]);
		
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[14]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		eftic = 1;
		champion.PainChance = 0;
		champion.DamageFactor *= 0.5;
		champion.Health = int(champion.Health * 2.0);
		champion.Mass = 0x7FFFFFFF;
		champion.bNOBLOOD = true;
		if(colours) 
			champion.A_SetTranslation("champion_Bronze");
			
		if(icons)
			champion_SpawnIcon(14,"champ_Bronze");
			
		}
	
	override void champion_LegendoomSpecial()
		{
		}
	
	override void champion_TickEffect()
		{
		if(!random(0,8))
			{
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