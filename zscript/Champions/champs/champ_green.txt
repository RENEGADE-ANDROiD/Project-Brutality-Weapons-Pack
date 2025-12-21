/*
 *
 *		Green Champion
 *			teleports randomly
 *
 */
class champion_GreenController : champion_BaseController
	{	
	int steps;
	int chance;
	int cooldown;
	
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"ffffff", "33cc33", "70db70", "1f7a1f", "d8fe01"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[5]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[5]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		eftic = 35;
		if(colours)
			champion.A_SetTranslation("champion_Green");
			
		if(icons)
			champion_SpawnIcon(5,"champ_Green");
			
		steps = 50;
		chance = 4;
		}
	
	override void champion_LegendoomSpecial()
		{
		steps = int(steps * 1.5);
		chance = 2;
		}
	
	override void champion_TickEffect()
		{
		if(coolDown)
			{
			//console.printf("%d",cooldown);
			cooldown--;
			return;
			}
		
		
		if(champion.target && !random(0,chance))
			{
			int maxstep = random(steps,steps*2);
			champion.A_SpawnItemEx("TeleportFog");
			champion.bJUMPDOWN = true;
			champion.bTHRUACTORS = true; 
			champion.MaxDropOffHeight = 512;
			champion.MaxStepHeight = 512;
			champion.A_SetAngle(champion.angle+randompick(-90,-45,0,+45,+90));
			for(int i = 0; i < maxstep; i++)
				{
				champion.A_Chase(null, null,CHF_NORANDOMTURN);
				}
			champion.bJUMPDOWN = champion.default.bJUMPDOWN;
			champion.bTHRUACTORS = champion.default.bTHRUACTORS; 
			champion.MaxDropOffHeight = champion.default.MaxDropOffHeight;
			champion.MaxStepHeight = champion.Default.MaxStepHeight;
			champion.A_SpawnItemEx("TeleportFog");
			cooldown = random(2,5);
			}
		}
		
	override void champion_HitEffect()
		{
		if(!random(0,2))
			champion_TickEffect();
		}
	}
	