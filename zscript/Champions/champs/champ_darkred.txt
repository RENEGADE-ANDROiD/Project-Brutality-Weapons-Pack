/*
 *
 *		Dark Red Champion
 *			Respawns if the corpse isn't destroyed
 *
 */
class champion_DarkRedController : champion_BaseController
	{
	actor gibbed;
	bool hidden;
	int restics;
	int basetics;
	int destruction;
	int champhealth;
	
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"e62e00", "b32400", "801a00", "4d0f00", "1a0500"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[0]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[0]));
			if(token)
				token.Secondary = true;
			}
		}
	
	override void champion_InitEffect()
		{
		eftic = 1;
		
		if(colours) 
			champion.A_SetTranslation("champion_DarkRed");
		
		if(icons)
			champion_SpawnIcon(0,"champ_DarkRed");
		
		champhealth = champion.Health;
		champion.bBUDDHA = true;
		champion.DeathSound = "misc/gibbed";
		basetics = 105;
		}
		
	override void champion_TickEffect()
		{
			
		if(champion && champion.health == 1 && !hidden)
			{
			for(int i; i < 32; i++)
				{
				champion.A_SpawnItemEx("Blood",xvel:frandom(3.0,8.0), zvel:frandom(4.0,8.0), angle:frandom(0.0,359.9), flags:SXF_USEBLOODCOLOR);
				}
			hidden = true;
			
			champion.bSOLID = false;
			champion.bSHOOTABLE = false;
			champion.bNOTARGET = true;
			champion.bNOTAUTOAIMED = true;
			champion.bNEVERTARGET = true;
			champion.bINVISIBLE = true;
			champion.A_Stop();
			champion.tics = -1;
			restics = basetics; 
			gibbed = Actor.Spawn("champion_ShootableCorpse",champion.pos);
			if(gibbed)
				{
				gibbed.translation = champion.translation;
				gibbed.CopyBloodColor(champion);
				}
			champion.SetOrigin((16384,16384,0),0);	 // crime
			}
			
		if(hidden && gibbed && gibbed.health < 1)
			{
			champion.SetOrigin(gibbed.pos,false);
			hidden = false;
			champion.bSOLID = true;
			champion.bSHOOTABLE = true;
			champion.bBUDDHA = false;
			champion.bSPECTRAL = false;
			champion.tics = 1;
			champion.A_Die();
			}
			
		if(hidden)
			{
			restics -= 1;
			if(restics < 0) 
				{
				if(gibbed)
					{
					hidden = false;
					champion.A_XScream();
					champion.SetStateLabel("Spawn");
					champion.SetOrigin(gibbed.pos,false);
					champion.health = int(transformed? starthealth * 0.66 : starthealth * 0.33);
					champion.bSOLID = champion.default.bSOLID;
					champion.bSHOOTABLE = champion.default.bSHOOTABLE;
					champion.bNOTARGET = champion.default.bNOTARGET;
					champion.bNOTAUTOAIMED = champion.default.bNOTAUTOAIMED;
					champion.bNEVERTARGET = champion.default.bNEVERTARGET;
					champion.bINVISIBLE = champion.default.bINVISIBLE;
					champion.tics = 1;
					for(int i; i < 32; i++)
						{
						champion.A_SpawnItemEx("Blood",xvel:frandom(3.0,8.0), zvel:frandom(4.0,8.0), angle:frandom(0.0,359.9), flags:SXF_USEBLOODCOLOR);
						}
					gibbed.destroy();
					}
				}
			}
		}
		
	override void champion_DeathEffect()
		{
		}
	}
	
class champion_ShootableCorpse : Actor
	{
	default
		{
		+SOLID;
		+SHOOTABLE;
		+ISMONSTER;
		Health 30;
		Radius 16;
		Height 16;
		YScale 0.66;
		}
	states
		{
		Spawn:
			RSPL A 1;
			wait;
		Death:
			TNT1 A 0 
				{
				for(int i; i < 32; i++)
					{
					A_SpawnItemEx("Blood",xvel:frandom(3.0,8.0), zvel:frandom(4.0,8.0), angle:frandom(0.0,359.9), flags:SXF_USEBLOODCOLOR);
					}
				}
			TNT1 A 35; //A_XScream();
			stop;
		}
	}