/*
 *
 *		Indigo Champion
 *			Spawns weak clones on death
 *
 */
class champion_IndigoController : champion_BaseController
	{
	class<actor> tospawn;
	int spawnCount;

	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"a081fe", "7a4efd", "b3b3ff", "c6b3fe"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[8]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[8]));
			if(token)
				token.Secondary = true;
			}
		}
	
	override void champion_InitEffect()
		{
		if(colours) 
			champion.A_SetTranslation("champion_Indigo");
			
		if(icons)
			champion_SpawnIcon(8,"champ_Indigo");
			
		tospawn = champion.GetClassName();
		spawnCount = 2;
		}
		
	override void champion_LegendoomSpecial()
		{
		spawnCount = 4;
		}	
		
	override void champion_DeathEffect()
		{
		
		for(int i; i < spawnCount; i++)
			{
			actor 	a;
			bool	b;
			int spawnDist = int(-(12*spawnCount)*0.5);
			[b, a] = champion.A_SpawnItemEx(tospawn, xofs:random(-12,12), yofs:spawnDist+(12*i), xvel:frandom(2.0,4.0), zvel:frandom(4.0,6.0), angle: 180+((360 / spawnCount) * i), flags:SXF_TRANSFERTRANSLATION|SXF_NOCHECKPOSITION|SXF_TRANSFERPOINTERS);
			
			if(a)
				{
				a.GiveInventory("champion_Clonetoken",1);
				a.Health = int(a.GetSpawnHealth() * 0.75);
				a.A_SetSize(a.Radius * 0.75, a.Height * 0.75);
				a.Scale  = a.Scale  * 0.75;
				a.DamageMultiply = 0.75;
				a.alpha = champion.alpha;
				a.bTHRUSPECIES = true;
				a.bDONTHARMSPECIES = true;
				a.A_GiveInventory("champion_NullToken");
				a.A_GiveInventory("champion_VoiceChanger");
				a.CopyBloodColor(champion);
				let voiceChange = champion_VoiceChanger(a.FindInventory("champion_VoiceChanger"));
			
				if(voiceChange)
					voiceChange.factor = 1.15;
						
				a.Species = "BlueManGroup";
					
				a.A_ChangeCountFlags(0,FLAG_NO_CHANGE,FLAG_NO_CHANGE);		
				}
			}
		}
	}
	
	class champion_CloneToken : inventory { }