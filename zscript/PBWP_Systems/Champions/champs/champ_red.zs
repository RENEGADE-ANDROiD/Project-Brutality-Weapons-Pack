/*
 *
 *		Red Champion
 *			Starts with 2x base health
 *
 */
class champion_RedController : champion_BaseController
	{
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"ff0000", "ff4d4d", "ff9999", "ffffff"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[1]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[1]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		if(colours)
			champion.A_SetTranslation("champion_Red");
			
		if(icons)
			champion_SpawnIcon(1,"champ_Red");
			
		champion.Health *= 2;
		}
	}
	