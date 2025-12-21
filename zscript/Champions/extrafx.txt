/*
 * 
 *		Extra effects
 *			For champion mutations and
 *			other stuff
 *
 */
 

class champion_ArchvileFire : Actor
	{
	Default
		{
		+NOBLOCKMAP +NOGRAVITY +ZDOOMTRANS
		RenderStyle "Add";
		Alpha 1;
		}
	States
		{
		Spawn:
			FIRE A 2 BRIGHT;
			FIRE BAB 2 BRIGHT;
			FIRE C 2 BRIGHT;
			FIRE BCBCDCDCDEDED 2 BRIGHT;
			FIRE E 2 BRIGHT;
			FIRE FEFEFGHGHGH 2 BRIGHT;
			Stop;
		}
}
//
// Champion Icon
class champion_Icon : Actor
	{
	actor champion;
	bool primary;
	bool secondary;
	double sec_pos;
	default
		{
		+NOINTERACTION;
		+NOGRAVITY;
		+BRIGHT;
		RenderStyle "Translucent";
		scale 0.2;
		}

	override void PostBeginPlay()
		{
		super.PostBeginPlay();
		
		
		if(primary)
			sec_pos = -6.0;
			
		if(secondary)
			sec_pos = 6.0;
			
		if(primary || secondary)
			{
			scale.x = scale.y = scale.y * 0.75;
			}
		}

	override void Tick()
		{
		super.Tick();
		
		if(master && master.health > 0)
			A_Warp(AAPTR_MASTER, yofs:sec_pos, flags:WARPF_INTERPOLATE|WARPF_NOCHECKPOSITION, heightoffset: 1.1);
		else
			destroy();
		}
	
	states
		{
		Spawn:
			//"####" "#" 0;
			ICNX "#" 1;
			wait;
		}
	}

class champion_Balloon : Actor
	{
	actor champion;

	default
		{
		+NOINTERACTION;
		+NOBLOCKMAP;
		+NOGRAVITY;
		+FLOATBOB;
		+BRIGHT;
		scale 0.66;
		}

	override void Tick()
		{
		super.Tick();
		
		if(master && master.health > 0)
			A_Warp(AAPTR_MASTER, flags:WARPF_INTERPOLATE|WARPF_NOCHECKPOSITION, heightoffset: 0.75);
		else
			destroy();
		}
	
	states
		{
		Spawn:
			//"####" "#" 0;
			BALN A 1;
			wait;
		}
	}

class champion_MissileEffect : Actor
	{
	int id;
	
	default
		{
		+NOINTERACTION;
		+NOGRAVITY;
		+BRIGHT;
		RenderStyle "Translucent";
		alpha 0.3;
		scale 0.6;
		}
	
	override void PostBeginPlay(void)
		{
		super.PostBeginPlay();
		
		if(master)
			{
			//double scalefactor = master.height * 0.0125;
			
			//scale.x = scale.y = scalefactor;
			}
		
		switch(id)
			{
			default:
				break;
				
			case champ_Cyan:
				for(int i = 0; i < 3; i++)
					{
					A_SpawnItemEx("champion_Leaves", angle:i*45, flags:SXF_SETMASTER|SXF_NOCHECKPOSITION);
					}
				break;
			}
		}
		
	override void Tick()
		{
		super.Tick();

		if(!master)
			{
			A_RemoveChildren(true);
			SetStateLabel("Death");
			}

		if(master)
			{
			int zmis = (master is "Rocket") ? 8 : 0;
			A_Warp(AAPTR_MASTER, zofs:zmis, flags:WARPF_INTERPOLATE|WARPF_NOCHECKPOSITION);
			}
			
 		if(master && master.InStateSequence(master.CurState,master.FindState("Death")))
			{
			A_RemoveChildren(true);
			SetStateLabel("Death");
			} 
			
		if(master && master.vel.x == 0 && master.vel.y == 0)
			{
			A_RemoveChildren(true);
			SetStateLabel("Death");
			}			
		}
	
	states
		{
		Spawn:
			GLOW "#" 1;
			wait;
		Death:
			GLOW "#" 1 A_FadeOut();
			wait;
		}
	}
	
//
// Undying Champion Mutation FX
class champion_Halo : Actor
	{
	default	
		{
		+NOINTERACTION;
		+FLOATBOB;
		FloatBobStrength 0.1;
		Scale 0.3;
		}
	override void Tick()
		{
		super.Tick();
		
		if(master && master.bBUDDHA)
			{
			A_Warp(AAPTR_MASTER,flags:WARPF_NOCHECKPOSITION|WARPF_INTERPOLATE, heightoffset:1.05);
			return;
			}
		destroy();
		}
	states
		{
		Spawn:
			HALO A 1 Bright;
			loop;
		}
	}

class champion_Heart : Actor
	{
	default
		{
		Radius 16;
		Height 24;
		Speed 1;
		Health 50;
		Scale 0.75;
		mass 0x7FFFFFFF;
		PushFactor 0.1;
		Monster;
		-SOLID;
		-COUNTKILL;
		+NOGRAVITY;
		+FLOATBOB;
		//+THRUACTORS;
		//+BRIGHT;
		+NOTARGETSWITCH;
		+NOTARGET;
		+NEVERTARGET;
		+RANDOMIZE;
		}
		
	name fuckEoA;
	
	override void PostBeginPlay()
		{
		if(master)
			{
			target = master;
			fuckEoA = 'GloryKillCounter';
			}
		}
	
	Override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags, double angles)
		{
		if(source && !source.CheckClass("PlayerPawn", AAPTR_DEFAULT, true))
			damage = 0;
		return Super.DamageMobj(Inflictor, Source, Damage, Mod, Flags, Angle);
		}
	
	override void Tick()
		{
		super.tick();
		takeInventory(fuckEoA,1);
		A_Chase(null, null);
		if(target && target != master)
			{
			target = master;
			}
		if(master)
			{
			if(Distance2D(master) > 512)
				{
				//A_SpawnItemEx("TeleportFog");
				SetOrigin((master.pos.x,master.pos.y,master.pos.z+(master.height*0.5)),0);
				//A_SpawnItemEx("TeleportFog");
				}
			}
		}
		
	states
		{
		Spawn:
			HART A 35;
			HART A 1 A_SetScale(scale.x+0.1,scale.y-0.0);
			HART A 1 A_SetScale(scale.x+0.1,scale.y-0.1);
			HART A 1 A_SetScale(scale.x+0.0,scale.y-0.1);
			HART A 0 A_SpawnItemEx("Blood");
			HART A 1 A_SetScale(scale.x-0.1,scale.y+0.0);
			HART A 1 A_SetScale(scale.x-0.1,scale.y+0.1);
			HART A 1 A_SetScale(scale.x+0.0,scale.y+0.1);
			loop;
		Death.Massacre:
			TNT1 A 0 
				{
				master.bBUDDHA = false;				
				A_KillMaster("Massacre",KILS_FOILBUDDHA);
				}
		Death:
			TNT1 A 0 
				{
				if(master)
					{
					master.bBUDDHA = false;
					}
				for(int i = 0; i < 16; i++)
					{
					A_SpawnItemEx("Blood", 	xvel:frandom(2.0,4.0),
											zvel:frandom(4.0,8.0),
											angle:frandom(0.0,359.0));			
					}
				}
			stop;
		GenericFreezeDeath:
			"####" "#" 0 
				{
				if(master)
					{
					master.bNOBLOOD = master.default.bNOBLOOD;
					master.bNODAMAGE = false;
					}
				for(int i = 0; i < 16; i++)
					{
					A_SpawnItemEx("Blood", 	xvel:frandom(2.0,4.0),
											zvel:frandom(4.0,8.0),
											angle:frandom(0.0,359.0));			
					}
				}
			Goto Super::GenericFreezeDeath;
		}
	}

//
// Titan Champion Aggression buff
class champion_AggroEffect : CustomInventory
	{
	default
		{
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.AUTOACTIVATE;
		}
	states
		{
		Use:
			TNT1 A 0
				{
				if(invoker.owner)
					{
					if(invoker.owner.bSPECIAL || invoker.owner.bWEAPONSPAWN)
						return false;
					
					A_GiveInventory("champion_AggroGiver");
					return true;
					}
				return false;
				}
			stop;
		}
	}
	
class champion_AggroPower : PowerUp
	{
	override void InitEffect()
		{
		Super.InitEffect();
		if(owner)
			{
			if(owner.CountInv("champion_TitanToken"))
				return;
				
			owner.bALWAYSFAST = true;
			owner.A_SpawnItemEx("champion_AggroVisual",flags:SXF_SETMASTER);
			}
		}
	
	override void EndEffect()
		{
		super.EndEffect();
		if(owner)
			{
			if(owner.CountInv("champion_TitanToken"))
				return;
				
			owner.bALWAYSFAST = owner.default.bALWAYSFAST;
			}
		}
	}

class champion_AggroGiver : PowerupGiver
	{
	default
		{
		Powerup.Duration -10;
		Powerup.Type "champion_AggroPower";
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.AUTOACTIVATE;
		}
	}
	
class champion_AggroVisual : Actor
	{
	int visdir;
	
	default	
		{
		+NOINTERACTION;
		+FLATSPRITE;
		+ROLLSPRITE;
		Renderstyle "Translucent";
		Scale 0.666;
		}
	override void Tick()
		{
		super.Tick();
		
		if (visdir > 0)
			{
			Alpha += 1/16.;
			if (Alpha >= 1.)
				{
				Alpha = 1.;
				visdir = -1;
				}
			}
		else
			{
			Alpha -= 1/16.;
			if (Alpha <= 0.25)
				{
				Alpha = 0.25;
				visdir = 1;
				}
			}	
			
		if(master && master.CountInv("champion_AggroPower"))
			{
			SetOrigin((master.pos.x,master.pos.y,master.floorz+1),true);
			return;
			}
		destroy();
		}
	states
		{
		Spawn:
			PENT A 1 Bright;
			loop;
		}
	}
	
class champion_TitanVisual : Actor
	{
	int visdir;
	
	default	
		{
		+NOINTERACTION;
		+FLATSPRITE;
		+ROLLSPRITE;
		+VISIBILITYPULSE;
		Renderstyle "Translucent";
		Scale 0.666;
		}
	override void Tick()
		{
		super.Tick();
		
		if (visdir > 0)
			{
			Alpha += 1/16.;
			if (Alpha >= 1.)
				{
				Alpha = 1.;
				visdir = -1;
				}
			}
		else
			{
			Alpha -= 1/16.;
			if (Alpha <= 0.25)
				{
				Alpha = 0.25;
				visdir = 1;
				}
			}	
			
		if(master && master.health >1)
			{
			scale.x = 2.666 - ( master.DamageFactor * 2.0 );
			scale.y = 2.666 - ( master.DamageFactor * 2.0 ); 
			SetOrigin((master.pos.x,master.pos.y,master.floorz+1),true);
			return;
			}
		destroy();
		}
	states
		{
		Spawn:
			PENT A 1 Bright;
			loop;
		}
	}
	
class champion_TitanBossEffect : CustomInventory
	{
	default
		{
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		}
	states
		{
		use:
			TNT1 A 0
				{
				if(invoker.owner.CountInv("champion_AggroPower"))
					invoker.owner.A_DamageSelf(1000000,'none',DMSS_KILL);
				}
			stop;
		}
	}
	
class champion_VoiceChanger : Inventory
{
	double factor;
	
	override void Tick()
	{
		Super.Tick();
		
		if (Owner != null)
		{
			Owner.A_SoundPitch(CHAN_VOICE, factor);
		}
	}
}	
//
// Psychic Mutation FX
class champion_MissileManipulator : Thinker
	{
	actor missile;
	actor missiletarget;
	
	override void PostBeginPlay()
		{
		if(missile)
			{
			missile.bSEEKERMISSILE = true;
			missiletarget = missile.target.target;
			}
		}
	
	override void Tick()
		{
		super.Tick();
		if(missile && missiletarget)
			{
			//double dang = clamp(missile.AngleTo(missiletarget),0,8);
			//double dpit = clamp(missile.
			missile.VelFromAngle(missile.speed, missile.AngleTo(missiletarget));
			}
		
		else
			self.Destroy();
		}
	}
	
//
// Metallic Champion Sparkle FX	
class champion_Sparkle : Actor
	{
	default
		{
		+NOINTERACTION;
		+NOGRAVITY;
		+ROLLSPRITE;
		+ROLLCENTER;
		Scale 0.25;
		}
	
	double dir;
	
	override void PostBeginPlay()
		{
		super.PostBeginPlay();
		
		dir = randompick(-1,1);
		}
	
	override void tick()
		{
		super.Tick();
		
		A_SetRoll(roll + 5*dir, SPF_INTERPOLATE);
		A_SetScale(scale.x-(scale.x * 0.3));
		if(scale.x < 0.0001)
			destroy();
		}
	
	states
		{
		Spawn:
			XXST A 1 Bright;
			wait;
		}
	}
	
class champion_Sparkle2 : champion_Sparkle
	{
	default
		{
		scale 1.0;
		}
	}