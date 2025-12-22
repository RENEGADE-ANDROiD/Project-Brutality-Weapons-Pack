/*
 *
 *		Grey Champion
 *			lunges towards enemy
 *
 */
class champion_GreyController : champion_BaseController
	{	
	override color GetParticleColour()
		{
		static const color ParticleColours[]=
			{
			"ffffff", "808080", "000000"
			};
		
		return ParticleColours[random(0,ParticleColours.Size()-1)];
		}	
	
	override void champion_GiveToken()
		{
		champion.A_GiveInventory(champion_Static.champion_Tokens[12]);
		if(secondary)
			{
			let token = champion_token(champion.FindInventory(champion_Static.champion_Tokens[12]));
			if(token)
				token.Secondary = true;
			}
		}
		
	override void champion_InitEffect()
		{
		eftic = 8;
		if(colours) 
			champion.A_SetTranslation("champion_Grey");
			
		if(icons)
			champion_SpawnIcon(12,"champ_Grey");
			
		}
		
	override void champion_TickEffect()
		{
		if(champion.target && random(0,1) && champion.CheckSight(champion.target))
			{
			if(random(0,1) && champion.CheckIfInTargetLOS(30,0,500))
				{
				champion.A_FaceTarget();
				champion.A_SkelWhoosh();
				champion.A_ChangeVelocity(0,frandompick(-16,16),0,CVF_RELATIVE);
				champion.GiveInventory("champion_GreyShadowSpawner", 1);
				return;
				}
			if(!random(0,3) && champion.CheckIfInTargetLOS(30,0,500))
				{
				champion.A_FaceTarget();
				champion.A_ChangeVelocity(48.0,0,2.0,CVF_RELATIVE);
				champion.A_SkelWhoosh();
				champion.GiveInventory("champion_GreyShadowSpawner", 1);
				}
			}
		}
	}
	
class champion_GreyShadowSpawner : inventory
	{
	const lifespan = 20;
	
	int age;
	
	default
		{
		inventory.MaxAmount 1;
		}
	
	override void DoEffect()
		{
		super.DoEffect();
		
		age--;
		
		if(owner)
			{
			let shadow = owner.Spawn("champion_Shadow", owner.pos);
			
			if(shadow)
				{
				shadow.Sprite = owner.Sprite;
				shadow.Frame = owner.Frame;
				shadow.Angle = owner.Angle;
				shadow.Translation = owner.Translation;
				shadow.A_SetSize(owner.radius, owner.height);
				}
			}
		
		if(age <= 0)
			self.DepleteOrDestroy();
		}
	
	override void AttachToOwner(actor other)
		{
		super.AttachToOwner(other);
		
		age = lifespan;
		}
	
	override bool HandlePickup(inventory item)
		{
		age = lifespan;
		
		return super.HandlePickup(item);
		}
	}
	
class champion_Shadow : actor
	{
	default
		{
		+NOBLOCKMAP;
		+NOGRAVITY;
		RenderStyle "Translucent";
		Alpha 0.75;
		}
	States
		{
		Spawn:
			"####" "#" 1 A_FadeOut();
			wait;
		}
	}