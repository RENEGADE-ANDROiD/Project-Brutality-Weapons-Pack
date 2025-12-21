/*
 * 
 *		Champion Base Controller
 *			Stores all the empty functions required for 
 *			champion modification
 *
 */
 
class champion_BaseController : thinker
	{
	actor 	champion;	// The champion to be controlled
	
	int 	tic; 
	int 	eftic;		// duration to pass before champion_TickEffect() is called
	int 	mutation;	// current Mutation
	
	
	state 	prevState;	// Previous State (for modifying actor tic speed)
	
	int 	oldhealth;
	int 	starthealth;
	
	bool colours;
	bool icons;
	bool particles;
	bool bundles;
	bool secondary;
	
	double icon_scale;
	double icon_alpha;
	
	bool setup;	
	int time;
	int mutationchance;
	
	string ld_token1;
	string ld_token2;
	
	bool legend;		// [LD-Compat] monster is legendary	
	bool transformed;// [LD-Compat] monster has transformed
	bool ld_boost;
	bool ld_dormant;	
	
	virtual color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"ffffff"
			};
			
		return ParticleColours[0];
		}
	
	virtual void champion_GiveToken()	
		{
		}
	
	virtual void champion_InitEffect()	// When the champion is spawned
		{
		}
	
	virtual void champion_TickEffect()	// When the champion tics (based on EffectTic property)
		{
		}
		
	virtual void champion_HitEffect()	// When the champion takes damage
		{
		}
		
	virtual void champion_DeathEffect()	// When the champion dies
		{
		}
	
	virtual void champion_LegendoomSpecial()
		{
		}
	
	void champion_SpawnIcon(int icon, string t)
		{
			
		let i = champion_Icon(champion.Spawn("champion_Icon",champion.pos,ALLOW_REPLACE));
		if(champion && i)
			{
			i.scale.x	= 0.75*icon_scale;
			i.scale.y	= 0.75*icon_scale;
			i.alpha 	= icon_alpha;
			
			i.Master	= champion;
			i.Frame 	= icon;
			i.Secondary = secondary;
			if(mutation == mutation_Hybrid)
				i.Primary = true;
			}
		}

	virtual void champion_SpawnParticles()
		{
		if(champion && champion)
			{
			champion.A_SpawnParticle(GetParticleColour(),	flags:SPF_FULLBRIGHT|SPF_RELPOS,
															lifetime:35,
															size:frandom(4.0,6.0),
															angle:frandom(0.0,359.9),
															xoff:champion.Radius,
															zoff:frandom(champion.height*0.25,champion.height*0.75),
															velz:frandom(0.3,0.6),
															accelz:0.01
															);
			}
		}
	double getHealthFactor(int amt, bool minorboss, bool mainboss)
		{
		double factor = 2.0;
		double fac2 = 1.5;
		
		if(minorboss)
			{
			fac2 = 1.1;
			factor = 1.5;
			}
			
		if(mainboss)
			{
			fac2 = 1.0;
			factor = 1.15;
			}
		
		return ((amt*fac2)+150)*factor;
		}
		
	void champion_InitMutation()
		{
/* 		mutationchance = mutation? 256 : mutationchance;
		if(champion && random(0,255) < mutationchance)
			{
			let info = champion_PersistentInfo(champion.FindInventory("champion_PersistentInfo"));
					
			let hand = champion_Handler(EventHandler.Find("champion_Handler"));
			int pick = 0;
			if(champion && hand && info)
				{
				if(info.m)
					{
					pick = info.m;
					}
				else if(champion && hand.champion_WeightedMutations.Size() > 0)
					{
					pick = hand.champion_WeightedMutations[random(0,hand.champion_WeightedMutations.Size()-1)];
					info.m = pick;
					}
				} */
		
		//mutationChance = ((mutation != -1)? 256 : mutationChance);
/* 		int pick;
		if(mutation != -1)
			{
			pick = mutation;
			}
			
		else if(champion && random(0,255) < mutationChance && mutation == -1)
			{
			let info = champion_PersistentInfo(champion.FindInventory("champion_PersistentInfo"));
					
			let hand = champion_Handler(EventHandler.Find("champion_Handler"));
			if(champion && hand && info)
				{
				if(champion && hand.champion_WeightedMutations.Size() > 0)
					{
					pick = hand.champion_WeightedMutations[random(0,hand.champion_WeightedMutations.Size()-1)];
					info.m = pick;
					}
				}
			} */
			int pick = mutation;
			
			switch(pick)
				{
				case mutation_Titan:
					mutation = mutation_Titan;
					champion.Scale *= 1.33;
					champion.Health = int(gethealthFactor(champion.Health, champion.bBOSSDEATH, champion.bBOSS));
					champion.DamageMultiply *= 2.0;
					champion.PainChance = int(champion.PainChance * 0.25);
					champion.bBOSS = true;
					champion.bNOTARGET = true;
					champion.bMISSILEMORE = true;
					champion.bMISSILEEVENMORE = true;
					champion.bALWAYSFAST = true;
					champion.bQUICKTORETALIATE = true;
					champion.bFORCEINFIGHTING = true;
					champion.bNOFEAR = true;
					eftic = int(clamp(eftic * 0.5, 1, 99));
					champion.A_SpawnItemEx("champion_TitanVisual",flags:SXF_SETMASTER);
					champion.A_GiveInventory("champion_TitanToken");
					champion.A_GiveInventory("champion_NullToken");	// titans can't be revived.
					champion.A_GiveInventory("champion_VoiceChanger");
					let voicechange = champion_VoiceChanger(champion.FindInventory("champion_VoiceChanger"));
					
					if(voicechange)
						voicechange.factor = 0.75;
						
					break;
				
				//case mutation_Splitter:
				//	champion.A_GiveInventory("champion_SplitterToken");
				//	break;
					
				case mutation_Undying: // EoA really fucking breaks the Undying Heart so might as well disable it lmao
					if(champion.CountInv("champion_DarkRedToken") || Wads.CheckNumForFullName("EOAMonsters.txt") != -1)
						return;
						
					champion.bBUDDHA = true;
					actor heart;
					bool fakebool;
					champion.A_SpawnItemEx("champion_Halo",flags:SXF_SETMASTER);
					[fakebool, heart] = champion.A_SpawnItemEx("champion_Heart", zofs:champion.height*0.5, flags:SXF_SETMASTER|SXF_NOCHECKPOSITION);
					//heart.CopyFriendliness(champion,false);
					heart.Health = champion.bBOSS? 200 : 50;
					break;
					
				case mutation_Ghost:
					if(champion.CountInv("champion_PinkToken"))
						return;
						
					mutation = mutation_Ghost;
					champion.bVISIBILITYPULSE = true;
					champion.bBRIGHT = true;
					break;
					
				case mutation_Balloon:
					mutation = mutation_Balloon;
					champion.bNOGRAVITY = true;
					champion.bFLOAT = true;
					champion.bFLOATBOB = true;
					champion.SetZ(random(32, 192));
					let balloon = champion_balloon(champion.spawn("champion_Balloon",champion.pos,ALLOW_REPLACE));
					if(balloon)
						{
						balloon.master = champion;
						balloon.FloatBobPhase = champion.FloatBobPhase;
						balloon.translation = champion.translation;
						}
					break;
					
				//case mutation_Psychic:
				//	champion.A_GiveInventory("champion_PsychicToken");
				//	break;					
				}
		}
		
	virtual void champion_SpawnBundles(void)
		{
		int maxdrops = int(clamp(starthealth * 0.05, 4, 25));
		
		if(champion.Health <= champion.GetGibHealth())
			maxdrops *= 2;
			
		int tier;
		maxdrops *= int((mutation)			? 2.0 : 1.0);
		maxdrops *= int((champion.bBOSS)	? 2.0 : 1.0);
		
		maxdrops = int(maxdrops * max(champion.DamageMultiply, 1.0));
		maxdrops = int(maxdrops * max(1.0, 2-(min(champion.DamageFactor, 1.0))));
		
		if(champion && starthealth < 150)
			tier = 0;
			
		if(champion && starthealth >= 150)
			tier = 1;	
			
		if(champion && starthealth >= 300)
			tier = 2;
			
		if(champion && starthealth >= 500)
			tier = 3;
			
		if(champion && starthealth >= 1000) 
			tier = 4;
			
		if(champion && starthealth >= 2000)
			tier = 5;
			
		let dropper = champion_Bundle(champion.Spawn("champion_Bundle",champion.pos,ALLOW_REPLACE));
		if(champion && dropper)
			{
			dropper.maxdrops 	= maxdrops;
			dropper.tier		= tier;
			}
		}
	
	override void PostBeginPlay()
		{
		super.PostBeginPlay();
		
		if(champion)
			champion_GiveToken();
		
		ld_token1 = "LDLegendaryMonsterToken";
		ld_token2 = "LDLegendaryMonsterTransformed";
		//time = legend? level.time + 3 : level.time + 0;
		}
	
	override void Tick()
		{
		super.Tick();
		
		if(champion)
			{
			if(level.isFrozen())
				return;
				
			if(champion && ld_dormant && champion.CountInv(ld_token2))
				{
				ld_dormant = false;
				//champion.A_SpawnItemEx("ArchvileFire",flags:SXF_TRANSFERTRANSLATION);
				}
			
			if(champion && ld_dormant)
				return;
				
			if(champion && !setup)
				{
				champion_InitEffect();
				champion_InitMutation();
				champion.starthealth = int(champion.health / G_SkillPropertyFloat(SKILLP_MonsterHealth));
				starthealth = champion.starthealth;
				setup = true;
				champion.A_SpawnItemEx("champion_ArchvileFire",flags:SXF_TRANSFERTRANSLATION);
				}
				
			if(champion && particles)
				champion_SpawnParticles();
				
			if(champion && champion.health < 1)
				{
				if(champion && bundles)
					champion_SpawnBundles();
				
				champion.bFLOATBOB = false;
				champion_DeathEffect();
				champion.StartHealth 	= champion.Default.StartHealth;
				champion.PainChance		= champion.Default.PainChance;
				champion.DamageFactor 	= champion.Default.DamageFactor;
				champion.DamageMultiply = champion.Default.DamageMultiply;
				self.destroy();
				return;
				}
			
			if(champion && champion.Health > oldhealth)
				oldhealth = champion.Health;
			
			if(champion && champion.Health < oldhealth && champion.Health > 0)
				{
				oldhealth = champion.Health;
				champion_HitEffect();
				}		
			
			if(champion && eftic && ++tic == eftic)
				{
				champion_TickEffect();
					tic = 0;
				}
				
			//console.printf("%d", tic);
			
			if(champion && !transformed  && champion.CountInv(ld_token2) && ld_boost)
				{
				transformed = true;
				champion_LegendoomSpecial();
				}	
				
			if(champion && mutation == mutation_Titan)
				{
				int a = champion.A_RadiusGive("champion_AggroEffect",384.0,RGF_MONSTERS|RGF_EXFILTER, filter: "champion_Heart");
				double b = clamp(1.0 - (a * 0.1), 0.1, 1.0);
				champion.DamageFactor = b;
				}
				
			if(champion && mutation == mutation_Ghost)
				{
				if(champion && champion.alpha < 0.5)
					{
					champion.bSPECTRAL = true;
					}
				if(champion && champion.alpha >= 0.5)
					{
					champion.bSPECTRAL = false;
					}			
				}			
			}
		}
	}

class champion_PersistentInfo : Inventory
	{
	class<thinker> 	c;
	int				i;
	int				m;
	int 			s;
	default
		{
		Inventory.MaxAmount 1;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.HUBPOWER;
		+INVENTORY.UNTOSSABLE;
		}
	}
	
class champion_NullToken : Inventory 
	{
	default
		{
		+INVENTORY.UNTOSSABLE;
		+INVENTORY.UNDROPPABLE;
		}
	}
	
class champion_ItemBundle : Actor
	{
	int quantity;
	}
