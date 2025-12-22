/*
 *
 *		Silver Champion
 *			Sucks you in with a strong magnetic field
 *
 */
class champion_SilverController : champion_BaseController
	{
	int radfactor;
	
	override void champion_SpawnParticles()
		{
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[15]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[15]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		eftic = 1;
		champion.Health = int(champion.Health * 1.25);
		champion.Mass *= 4;
		champion.bNOBLOOD = true; 
		
		if(colours) 
			champion.A_SetTranslation("champion_Silver");
		
		if(icons)
			champion_SpawnIcon(15,"champ_Silver");
			
		radfactor = -224;
		}
	
	override void champion_LegendoomSpecial()
		{
 		radfactor = -384;
		}
	
	override void champion_TickEffect()
		{
		champion.A_RadiusThrust(radfactor,384,RTF_NOIMPACTDAMAGE|RTF_NOTMISSILE, species: 'succ');
		
		if(level.time % 16 == 0)
			{
			champion.A_SpawnItemEx("champion_SilverMagnetism", flags:SXF_SETMASTER);
			}
		}
	}


class champion_SilverMagnetism : actor
	{
	int zpos;
	
	default
		{
		renderStyle "Add";
		+BRIGHT;
		+NOBLOCKMAP;
		+NOGRAVITY;
		Scale 0.75;
		alpha 0.00;
		}
	override void PostBeginPlay()
		{
		super.PostBeginPlay();
		
		bFLATSPRITE = champion_FlatSprites;
		
		zpos = bFLATSPRITE? 1 : int(master.Height * 0.5);
		
		if(bFLATSPRITE)
			{
			if(master)
				SetOrigin((master.pos.x, master.pos.y, master.pos.z+zpos), true);
			}

		}
		
	override void Tick()
		{
		Super.Tick();
		
		if(isFrozen())
			return;
			
		scale.x = scale.y = scale.y -= 0.01;
		
		if(master)
			SetOrigin((master.pos.x, master.pos.y, master.pos.z+zpos), true);
				
		if(scale.x <= 0 || !master || master.Health < 1)
			destroy();
		}
		
	states
		{
		Spawn:
			MAGN AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 1 A_FadeIn(0.04);
		FadeOut:
			MAGN A 1 A_FadeOut(0.005);
			wait;
		}
	}

class champion_SilverShield : actor
	{
	sound oldsound;
	default
		{
		+NOINTERACTION;
		+BRIGHT;
		Renderstyle "add";
		Scale 0.4;
		}
	override void Tick()
		{
		super.Tick();
		
		if(master && master.CountInv("champion_SilverReflection"))
			return;
		
		if(master) { master.painsound = oldsound; } 
		destroy();
		}
		
	states
		{
		Spawn:
			TNT1 A 0;
			CSHL A 0
				{
				if(master)
					{
					oldsound = master.painsound;
					master.painsound = "";
					}
				}
			CSHL A 1 
				{
				master.SetStateLabel("Pain");
				master.A_FaceTarget();
				A_Warp(AAPTR_MASTER,1,flags:WARPF_INTERPOLATE|WARPF_NOCHECKPOSITION, heightoffset:0.5);
				}
			wait;
		}
	}

class champion_SilverReflection : PowerInvulnerable
	{
	default
		{
		Powerup.Mode "Reflective";
		}
	}

class champion_SilverReflectionGiver : PowerupGiver
	{
	default
		{
		Powerup.Type "champion_SilverReflection";
		Powerup.Duration -3;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		}
	}
	
class champion_SilverSparkleRing : actor
	{
	default
		{
		+NOINTERACTION;
		}
	states
		{
		Spawn:
			TNT1 A 0 NoDelay
				{
				for(int i = 0; i < 18; i++)
					{
					A_SpawnItemEx("champion_Sparkle",xofs:32.0, zvel:4.0, angle:i * 20);
					}
				}
			stop;
		}
	}