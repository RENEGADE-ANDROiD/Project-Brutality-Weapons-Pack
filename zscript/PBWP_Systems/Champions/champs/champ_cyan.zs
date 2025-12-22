/*
 *
 *		Cyan Champion
 *			constant wind thrust
 *
 */
class champion_CyanController : champion_BaseController
	{
	int windforce;
	
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"ffffff", "ccffff", "33ccff"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[6]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[6]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		eftic = 1;
		if(colours) 
			champion.A_SetTranslation("champion_Cyan");
		
		if(icons)
			champion_SpawnIcon(6,"champ_Cyan");
			
		windforce = 192;
		for(int i = 0; i < 8; i++)
			{
			champion.A_SpawnItemEx("champion_Leaves", angle:i*45, flags:SXF_SETMASTER|SXF_NOCHECKPOSITION);
			}
		}
	
	override void champion_LegendoomSpecial()
		{
		windforce = 384;
		}
	
	override void champion_TickEffect()
		{
		champion.A_RadiusThrust(windforce,384,RTF_NOIMPACTDAMAGE|RTF_NOTMISSILE);
		}
		
	override void champion_DeathEffect()
		{
		}
	}
	
class champion_Leaves : Actor
	{
	default
		{
		+NOINTERACTION;
		+FLOATBOB;
		}
	
	double orbitdist;
	double orbitheight;
	
	override void PostBeginPlay()
		{
		super.PostBeginPlay();
		
		if(master)
			{
			orbitdist 	= double(frandom(master.Radius, master.Radius*1.5));
			orbitheight = double(frandom(0,master.Height));
			}
		}
	
	override void Tick()
		{
		super.Tick();
		
		if(master)
			{
			A_SetAngle(angle + 12);
			A_Warp(AAPTR_MASTER,	xofs:orbitdist,
									zofs:orbitheight,
									flags:WARPF_NOCHECKPOSITION|WARPF_USECALLERANGLE|WARPF_INTERPOLATE);
			if(master.health < 1)
				{
				A_FadeOut();
				}
			}
		else
			{
			A_FadeOut();
			}
		}
		
	states
		{
		Spawn:
			TNT1 A 0 NoDelay A_Jump(128, "Spawn2");
		Spawn1:
			LEF1 ABCDEFGHI 1;
			loop;
		Spawn2:
			LEF2 ABCDEFGHI 1; 
			loop;
		}
	}