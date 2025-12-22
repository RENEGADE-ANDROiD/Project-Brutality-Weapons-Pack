/*
 *
 *		Black Champion
 *			Deals 2x damage
 *
 */
class champion_BlackController : champion_BaseController
	{
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"000000", "4d4d4d", "999999"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[11]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[11]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		if(colours) 
			champion.A_SetTranslation("champion_Black");
		
		if(icons)
			champion_SpawnIcon(11,"champ_Black");
			
		champion.DamageMultiply *= 2.0;
		champion.DamageFactor 	*= 2.0;
		}
		
	override void champion_LegendoomSpecial()
		{
		//champion.DamageMultiply *= 2.5;
		}
	}