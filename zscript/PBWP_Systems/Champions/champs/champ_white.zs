/*
 *
 *		White Champion
 *			leaves a trail of slowing creep
 *
 */
class champion_WhiteController : champion_BaseController
	{
	class<actor> creep;
	int radfactor;
	
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"ffffff", "b3b3b3", "666666"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[13]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[13]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		eftic = 10;
		if(colours) 
			champion.A_SetTranslation("champion_White");
		
		if(icons)
			champion_SpawnIcon(13,"champ_White");
			
		creep = "champion_WhiteCreep";
		radfactor = 2;
		}
		
	override void champion_LegendoomSpecial()
		{
		creep = "champion_BigWhiteCreep";
		radfactor = 3;
		}
	
	override void champion_TickEffect()
		{
		if(champion.target)
			{
			if(!random(0,1))
				champion.A_RadiusGive("champion_Slowness2",champion.radius*radfactor,RGF_PLAYERS);
			
			champion.A_SpawnItemEx(creep, xofs:-16, yofs:frandom(-16.0,16.0), flags:SXF_SETTARGET);
			}
		}
	}
	
class champion_WhiteMissileCreep : inventory
	{
	override void DoEffect()
		{
		super.DoEffect();
		
		if(GetAge() % 3 == 0)
			owner.A_SpawnItemEx("champion_SmallWhiteCreep", xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_TRANSFERPOINTERS);
			
 		if(owner && owner.InStateSequence(owner.CurState,owner.FindState("Death")))
			{
			owner.A_SpawnItemEx("champion_WhiteCreep", xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_TRANSFERPOINTERS);
				Destroy();
			} 
			
		if(owner && owner.vel.x == 0 && owner.vel.y == 0)
			{
			owner.A_SpawnItemEx("champion_WhiteCreep", xofs:-16, yofs:frandom(-16.0,16.0), angle: frandom(0.00,360.00), flags:SXF_TRANSFERPOINTERS);
				Destroy();
			}	
		}
	}	

class champion_WhiteCreep : champion_CreepBase
	{
	default
		{
		RenderStyle "Stencil";
		StencilColor "f2f2f2";
		translation "champion_White";
		
		champion_CreepBase.CreepEffect 'champion_Slowness1';
		champion_CreepBase.CreepLife 	6;
		champion_CreepBase.CreepTick 	18;
/* 		champion_CreepBase.SpriteScale 	0.3; */
		}
	states
		{
/* 		SpawnSprite:
			SWEB AAAAAA 1 A_FadeIn(0.1);
		SpawnSpriteLoop:
			SWEB A 35;
			loop; */
		}
	}
	
class champion_BigWhiteCreep : champion_WhiteCreep
	{
	default
		{
		champion_CreepBase.CreepEffect 'champion_Slowness2';
		champion_CreepBase.CreepLife 	6;
		champion_CreepBase.CreepTick 	18;
		}
	}
	
class champion_SmallWhiteCreep : champion_WhiteCreep
	{
	default
		{
		champion_CreepBase.CreepEffect 'champion_Slowness1';
		champion_CreepBase.CreepLife 	6;
		champion_CreepBase.CreepTick 	18;
		
		champion_CreepBase.CreepRadius 	32;
		champion_CreepBase.SpriteScale 	0.3;
		champion_CreepBase.FlatScale 	0.15;
		}
	}

class champion_SlownessEffect : PowerSpeed
	{
	default
		{
		Inventory.Icon "";
		Speed 0.33;
		+POWERSPEED.NOTRAIL;
		+INVENTORY.NOSCREENBLINK;
		}
	}

class champion_Slowness1 : PowerupGiver
	{
	default
		{
		Powerup.Type "champion_SlownessEffect";
		Powerup.Duration -3;
		Powerup.Color "FF FF FF", 0.2;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		
		}
	}

class champion_Slowness2 : champion_Slowness1
	{
	default
		{
		Powerup.Duration -6;
		}
	}