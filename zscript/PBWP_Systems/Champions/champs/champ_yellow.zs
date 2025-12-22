/*
 *
 *		Yellow Champion
 *			2x faster
 *
 */
class champion_YellowController : champion_BaseController
	{
	double factor;

	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"ffffff", "ffffb3", "ffff4d", "e6e600"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[3]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[3]));
			if(token)
				{
				token.Secondary = true;
				}
			}
		}
	
	override void champion_InitEffect()
		{
		eftic = 1;
		
		if(colours) 
			champion.A_SetTranslation("champion_Yellow");
			
		if(icons)
			champion_SpawnIcon(3,"champ_Yellow");
	
		factor = 1.5;
		//champion.bALWAYSFAST = true
		}
	
	override void champion_LegendoomSpecial()
		{
		factor = 2.0;
		}
	
	override void champion_TickEffect()
		{
		if(champion && champion.health < 1 || champion.tics <= 0) { return; } 
		
        if (prevState != champion.curState)
			{ champion.A_SetTics (int(champion.tics / factor)); }

        prevState = champion.curState;
		}
	}