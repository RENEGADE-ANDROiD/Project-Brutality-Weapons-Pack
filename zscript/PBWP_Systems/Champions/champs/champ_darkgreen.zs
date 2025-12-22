/*
 *
 *		Dark Green Champion
 *			spawns a trail of creep
 *
 */
class champion_DarkGreenController : champion_BaseController
	{
	class<actor> creep;
	
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"00b300", "008000", "004d00", "001a00"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[4]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[4]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		eftic = 10;
		if(colours)
			champion.A_SetTranslation("champion_DarkGreen");
		
		if(icons)
			champion_SpawnIcon(4,"champ_DarkGreen");
			
		creep = "champion_DarkGreenCreep";
		}
		
	override void champion_LegendoomSpecial()
		{
		creep = "champion_RedCreep";
		}
	
	override void champion_TickEffect()
		{
		if(champion.target)
			{
			champion.A_SpawnItemEx(creep, xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_SETTARGET);
			}
		}
		
	override void champion_DeathEffect()
		{
		}
		
/* 	override void champion_DeathEffect()
		{
		champion.A_SpawnItemEx("champion_BigDarkGreenCreep", xofs:-16, flags:SXF_SETTARGET);
		} */
	}
	

class champion_CreepBase : actor
	{
	int count;
	
	property CreepEffect: 	CreepEffect;	class<inventory> CreepEffect;
	property CreepRadius: 	CreepRadius; 	int CreepRadius;
	property CreepTick:		CreepTick;		int CreepTick;
	property CreepLife:		CreepLife;		int CreepLife;
	property SpriteScale:	SpriteScale;	double SpriteScale;
	property FlatScale:		FlatScale;		double FlatScale;
	
	default
		{
		+NOGRAVITY;
		+BRIGHT;
		alpha 0.0;
		RenderStyle "Stencil";
		champion_CreepBase.CreepRadius 48;
		champion_CreepBase.CreepLife 3;
		champion_CreepBase.CreepTick 35;
		champion_CreepBase.SpriteScale 	0.6;
		champion_CreepBase.FlatScale 	0.3;
		}

	override void BeginPlay()
		{
		Super.BeginPlay();
		bFLATSPRITE = champion_FlatSprites;
		bSPRITEFLIP = random(0,1);
		if(bFLATSPRITE)
			{
			SetOrigin((pos.x,pos.y,floorz+1),false);
			
			scale.x = scale.y =  frandom(flatScale,flatScale+(flatScale*0.2));
			angle = frandom(0.0,360.0);
			}
		else
			{
			A_SetRenderStyle(0.0, STYLE_TRANSLUCENT);
			scale.x = scale.y = frandom(spriteScale, spriteScale+(spriteScale*0.2));
			}
		}
		
	override void Tick()
		{
		Super.Tick();
		
		if(isFrozen())
			return;
			
		if(level.Time % creepTick == 0)
			A_RadiusGive(creepEffect,creepRadius,RGF_CUBE|RGF_PLAYERS,1);
		
		if(GetAge() % 35 == 0)
			{
			count += 1; if(count > creepLife)
			SetStateLabel("Disappear"); 
			}
			
		if(bFLATSPRITE)
			SetOrigin((pos.x,pos.y,floorz+1),true);
		}
	states
		{
		Spawn:
			TNT1 A 1 NoDelay A_JumpIf(bFLATSPRITE,"SpawnFlat");
			TNT1 A 0 A_Jump(256,"SpawnSprite");
		SpawnFlat:
			BSPL AAAAA 1 A_FadeIn(0.1);
		SpawnFlatLoop:
			BSPL A 35;
			loop;
		SpawnSprite:
			CRPG III 1 A_FadeIn(0.1);
		SpawnSpriteLoop:
			CRPG EFGHI 6;
			loop;
		Disappear:
			"####" "#" 1 { A_FadeOut(0.1); A_SetScale(scale.x-(scale.x * 0.05)); if(scale.x < 0.00001) { destroy(); } }
			wait;
		}
	}


	
class champion_DarkGreenCreep : champion_CreepBase
	{
	default
		{
		StencilColor "00e600";
		Translation "champion_Green";
		
		champion_CreepBase.CreepEffect 'champion_CreepDamage';
		champion_CreepBase.CreepLife 3;

		}
	}

class champion_RedCreep : champion_DarkGreenCreep
	{
	default
		{
		translation "champion_Red";
		StencilColor "cc0000";
		
		champion_CreepBase.CreepLife 6;		
		champion_CreepBase.CreepTick 17;
		}
	}
	
class champion_SmallDarkGreenCreep : champion_DarkGreenCreep
	{
	default
		{
		champion_CreepBase.CreepRadius 	32;
		champion_CreepBase.SpriteScale 	0.3;
		champion_CreepBase.FlatScale 	0.15;
		}
	}

class champion_SmallRedCreep : champion_RedCreep
	{
	default
		{
		champion_CreepBase.CreepRadius 	32;
		champion_CreepBase.SpriteScale 	0.3;
		champion_CreepBase.FlatScale 	0.15;
		}
	}

class champion_DarkGreenMissileCreep : inventory
	{
	override void DoEffect()
		{
		super.DoEffect();
		
		if(owner.GetAge() % 3 == 0)
			owner.A_SpawnItemEx("champion_SmallDarkGreenCreep", xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_TRANSFERPOINTERS);
		
 		if(owner && owner.InStateSequence(owner.CurState,owner.FindState("Death")))
			{
			owner.A_SpawnItemEx("champion_DarkGreenCreep", xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_TRANSFERPOINTERS);
				Destroy();
			} 
			
		if(owner && owner.vel.x == 0 && owner.vel.y == 0)
			{
			owner.A_SpawnItemEx("champion_DarkGreenCreep", xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_TRANSFERPOINTERS);	
				Destroy();
			}	
		}
	}

class champion_RedMissileCreep : inventory
	{
	override void DoEffect()
		{
		super.DoEffect();
		
		if(owner.GetAge() % 3 == 0)
			owner.A_SpawnItemEx("champion_SmallRedCreep", xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_TRANSFERPOINTERS);
		
 		if(owner && owner.InStateSequence(owner.CurState,owner.FindState("Death")))
			{
			owner.A_SpawnItemEx("champion_RedCreep", xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_TRANSFERPOINTERS);
				Destroy();
			} 
			
		if(owner && owner.vel.x == 0 && owner.vel.y == 0)
			{
			owner.A_SpawnItemEx("champion_RedCreep", xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_TRANSFERPOINTERS);	
				Destroy();
			}	
		}
	}

class champion_CreepDamage : CustomInventory
	{
	default
		{
		+INVENTORY.AUTOACTIVATE;
		inventory.MaxAmount 1;
		}
	states
		{
		Use:
			TNT1 A 0
				{
				if(invoker.owner && invoker.owner.CountInv("PowerIronFeet"))
					return;
					
				A_DamageSelf(5,"champion_Toxic",src:AAPTR_NULL);
				}
			stop;
		}
	}