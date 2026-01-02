// DEFLECTION SPHERE
// Deflects non-homing projectiles aimed at player
class PowerDeflect : Powerup 
{
	bool zeroTurn;	// "random" deflection direction when projectile aims directly at player
	
	Default
	{
		Powerup.Duration -30;
		Powerup.Color "ff 80 00", 0.2;
	}
	
	override void InitEffect ()
	{
		Super.InitEffect();
		
		zeroTurn = random(0,1);
	}

	override void DoEffect ()
	{
		Super.DoEffect();
		Actor ob;
		ThinkerIterator iter = ThinkerIterator.Create();

		while (ob = Actor(iter.Next()))
		{
			if (!ob || !ob.bMissile || ob.bSeekermissile || ob.target == Owner) continue;
			
			double v = ob.vel.Length();	// speed of projectile
			double ang = VectorAngle(ob.vel.x, ob.vel.y);	// direction of projectile
			double dist = ob.Distance3D(Owner);	// distance from player

			if (dist > 35*v) continue;	// too far away, no need to deflect
			
			zeroTurn = !zeroTurn;
			
			vector2 vecToPlayer = ob.Vec2To(Owner);	
			double angleToPlayer = VectorAngle(vecToPlayer.x, vecToPlayer.y); // direction from projectile to player
			double angleDelta = deltaangle(ang, angleToPlayer);	// how much the projectile is off
			
			if (abs(angleDelta) > 60) continue;	// not going to player (too much off)
			
			double newDiff;		// new direction difference
			if (angleDelta < 0) newDiff = 3.0;
			else if (angleDelta > 0 || zeroTurn) newDiff = -3.0;
			else newDiff = 3.0;
			
			ang += newDiff;
			double flatVel = sqrt(ob.vel.x*ob.vel.x + ob.vel.y*ob.vel.y);
			ob.vel.x = flatVel * cos(ang);
			ob.vel.y = flatVel * sin(ang);
			ob.angle += newDiff;
			
		}
	}
}

// ELECTRIC AURA SPHERE
Class ElectricAuraSphere : PowerupGiver
{
	Default
	{
		//$Category Powerups
		//$Sprite VELAE0
		//$Title "Electric Aura Sphere"
		+COUNTITEM;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.BIGPOWERUP;
		Inventory.MaxAmount 0;
		Powerup.Type "ElectricAuraPower";
		Powerup.Duration -30;
		Powerup.Color "FFFF00", 0.075;
		Inventory.PickupMessage "Electric Aura! Summons an Electric Field that Stuns Nearby Enemies in Area";
	}
	States
	{
	Spawn:
		VELA ABCDEFGHDEF 3 bright;
		Loop;
	}
}

class ElectricAuraPower : Powerup
{
	actor AL;
	double arad;
	override void InitEffect()
	{
		super.InitEffect();
//==============================================================================
		arad = 384;	//Aura Radius
//==============================================================================
		if (owner)
		{
			owner.A_Startsound("ElectricAura/aura",22243,CHANF_LOOPING|ATTN_NONE);
			owner.A_AttachLight("ELAL1",DynamicLight.PulseLight,"FFFFFF",arad*0.1,arad*0.2,
				flags:DYNAMICLIGHT.LF_NOSHADOWMAP,
				ofs:(0,0,owner.height),param:2.5);
				owner.A_AttachLight("ELAL2",DynamicLight.PointLight,"A0A0FF",arad,arad,
				flags:DYNAMICLIGHT.LF_NOSHADOWMAP,
				ofs:(0,0,owner.height));

			for (int i = 0; i < 360; i += 15)
			{
				AL = spawn("ElectricAuraWarp",owner.pos);
				if (AL)
				{
					AL.target = owner;
					AL.scale.x = (arad / 360) *0.375;
					AL.scale.y = AL.scale.x/1.5;
					AL.A_SetSize(-1,owner.height/3);
					AL.reactiontime = arad;
					AL.warp(owner, arad, 0, AL.height, i, WARPF_ABSOLUTEANGLE|WARPF_NOCHECKPOSITION|WARPF_INTERPOLATE);
					AL.A_AttachLight("ELAL3",DynamicLight.FlickerLight,"FFFFFF",arad*0.1,arad*0.2,
						flags:DYNAMICLIGHT.LF_NOSHADOWMAP,
						ofs:(0,0,0),param:2.5);
				}
			}
		}
	}
	override void Tick()
	{	
		if (owner)
		{
//-------------------------------- shock monsters -------------------------------
			if(GetAge() % 5 == 0)
			{
				array<actor> monsters;
				actor mon;
				let it = BlockThingsIterator.Create(owner, arad);
				while (it.Next())
				{
					actor mon = it.thing;
					mon.A_RemoveLight("ELATL");
					if (mon && mon.bISMONSTER && !mon.bKILLED && monsters.Find(mon) == monsters.Size() && owner.Distance3D(mon) <= arad  && owner.CheckSight(mon))
					{
						monsters.push(mon);
					}
				}
				if (monsters.Size()> 0)
				{
					int index = random(0,monsters.Size()-1);
					actor mon = monsters[index];
					if (mon && !mon.bKILLED && owner.Distance3D(mon) <= arad && owner.CheckSight(mon))
					{
						actor Electricdmg = spawn("ElectricAuraBeam",owner.pos+(0,0,owner.height/2));
						if (Electricdmg)
						{
							Electricdmg.angle = owner.AngleTo(mon);
							Electricdmg.pitch = owner.PitchTo(mon,owner.height/2,mon.height/2);
							double dist = owner.distance3D(mon);
							Electricdmg.scale.y = dist/355;
							Electricdmg.scale.x = 0.5;
							Electricdmg.DoMissileDamage(mon);
							if (mon.tics > 0) mon.tics += 4; //stun monster
//---------------------------------- Aura FX -----------------------------------
							int ht = mon.height/2;
							SparkParticle("FFFFFF", mon.pos, ht);
							SparkParticle("FFFFFF", mon.pos, ht);
							SparkParticle("FFFFFF", mon.pos, ht);
							SparkParticle("FFFFFF", mon.pos, ht);
							SparkParticle("FFFF00", mon.pos, ht);
							SparkParticle("FFFF00", mon.pos, ht);
							SparkParticle("FFFF00", mon.pos, ht);
							SparkParticle("FFFF00", mon.pos, ht);
							SparkParticle("C080FF", mon.pos, ht);
							SparkParticle("C080FF", mon.pos, ht);
							SparkParticle("C080FF", mon.pos, ht);
							SparkParticle("C080FF", mon.pos, ht);
							mon.A_AttachLight("ELATL",DynamicLight.PointLight,"E0E0FF",mon.radius,mon.radius,
								flags:DYNAMICLIGHT.LF_NOSHADOWMAP|DYNAMICLIGHT.LF_ATTENUATE,
								ofs:(0,0,mon.height/2));
							mon.A_Startsound("ElectricAura/electric");
						}
					}
				}
			}
			AuraParticle();
		}
		super.Tick();
	}
	override void EndEffect()
	{
		if (owner)
		{
			owner.A_RemoveLight("ELAL1");
			owner.A_RemoveLight("ELAL2");
			owner.A_Stopsound(22243);
		}
		super.EndEffect();
	}
	void SparkParticle(color col, vector3 mpos, double mz)
	{
		A_SpawnParticle(col,
		flags: SPF_FULLBRIGHT,
		lifetime:15,
		size:random(3,5),
		xoff:mpos.x+random(-5,5),
		yoff:mpos.y+random(-5,5),
		zoff:mz,
		velx:random(-5,5),
		vely:random(-5,5),
		velz:random(-5,5),
		startalphaf:1.0,fadestepf:-1);
	}
	void AuraParticle()
	{
		int rnd = random(1,4);
		TextureID ptx;
		if (rnd == 1) ptx = TexMan.CheckForTexture ("VSPRA0");
		else if (rnd == 2) ptx = TexMan.CheckForTexture ("VSPRB0");
		else if (rnd == 3) ptx = TexMan.CheckForTexture ("VSPRC0");
		else if (rnd == 4) ptx = TexMan.CheckForTexture ("VSPRD0");
		owner.A_SpawnParticleEx("FFFFFF",ptx,
		style: STYLE_Add,
		flags: SPF_FULLBRIGHT,
		lifetime:4,
		size:random(5,30),
		xoff:random(-arad,arad),
		yoff:random(-arad,arad),
		zoff:0,
		startalphaf:0.8,fadestepf:0);
	}
}

class ElectricAuraWarp : Actor
{
	int dist;
	Default
	{
		+WALLSPRITE;
		+NOBLOCKMAP;
		+NOINTERACTION;
		RenderStyle "Add";
		Alpha 0.8;
	}
	States
	{
	Spawn:
		TNT1 A 0 Nodelay
		{
			dist = reactiontime;
		}
		TNT1 A 0 A_Jump (256, 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33);
	Warp:
		VLGB AABBCCDDEEFFGGHHIIJJHHGGFFEEDDCCBB 2 bright 
		{
			angle += 2;
			if (!random(0,1)) bXFLIP = !bXFLIP;
			if (target) warp(target, dist, 0, height, angle, WARPF_ABSOLUTEANGLE|WARPF_NOCHECKPOSITION|WARPF_INTERPOLATE);
			if (!target || !target.FindInventory("ElectricAuraPower")) destroy();
		}
		Loop;
	}
}

class ElectricAuraBeam : Actor
{
	Default
	{
		+FLATSPRITE;
		+NOBLOCKMAP;
		+NOGRAVITY;
		+BLOODLESSIMPACT;
		+FORCEPAIN;
//==============================================================================
		DamageFunction random(14,21); //Aura Damage
//==============================================================================
		DamageType "Electric";
		RenderStyle "Add";
		Alpha 0.8;
	}
	States
	{
	Spawn:
		TNT1 A 0 Nodelay
		{
			if (!random(0,1)) bXFLIP = !bXFLIP;
			if (!random(0,1)) bYFLIP = !bYFLIP;
		}
		TNT1 A 0 A_Jump (256, 1,2,3,4,5,6,7,8,9,10);
		VLGA A 5 bright;
		Stop;
		VLGA B 5 bright;
		Stop;
		VLGA C 5 bright;
		Stop;
		VLGA D 5 bright;
		Stop;
		VLGA E 5 bright;
		Stop;
		VLGA F 5 bright;
		Stop;
		VLGA G 5 bright;
		Stop;
		VLGA H 5 bright;
		Stop;
		VLGA I 5 bright;
		Stop;
		VLGA J 5 bright;
		Stop;
	}
}