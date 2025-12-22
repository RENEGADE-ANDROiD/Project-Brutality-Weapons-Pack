/*
 *
 *		<colour> Champion
 *			<effect>
 *
 */
class champion_<colour>Controller : champion_BaseController
	{
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"e62e00", "b32400", "801a00", "4d0f00", "1a0500"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_InitEffect()
		{
		eftic = <tic>;
		if(colours)
			champion.A_SetTranslation("champion_<colour>");
			
		if(icons)
			champion_SpawnIcon(<index>,"champ_<colour>");
			
		}
	
	override void champion_LegendoomSpecial()
		{
		}
	
	override void champion_TickEffect()
		{
		}
		
	override void champion_HitEffect()
		{
		}	
		
	override void champion_DeathEffect()
		{
		}
	}