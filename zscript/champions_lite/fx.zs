class cl_SpawnBurst : Actor
	{
	default
		{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+ZDOOMTRANS;
		RenderStyle "Add";
		Alpha 1;
		}
	states
		{
		Spawn:
			FIRE A 2 Bright;
			FIRE BAB 2 Bright;
			FIRE C 2 Bright;
			FIRE BCBCDCDCDEDED 2 Bright;
			FIRE E 2 Bright;
			FIRE FEFEFGHGHGH 2 Bright;
			stop;
		}
	}

class cl_GiantAura : Actor
	{
	int visDir;
	int sightTic;

	default
		{
		+NOINTERACTION;
		+FLATSPRITE;
		+ROLLSPRITE;
		RenderStyle "Translucent";
		scale 0.75;
		Alpha 0.35;
		}

	override void Tick()
		{
		super.Tick();

		if (master && (++sightTic % 15) == 0 && !cl_Static.cl_CosmeticFXVisible(master))
			{
			Alpha = 0;
			return;
			}
		if (master)
			Alpha = max(Alpha, 0.2);

		if (visDir > 0)
			{
			Alpha += 1 / 16.0;
			if (Alpha >= 0.85)
				{
				Alpha = 0.85;
				visDir = -1;
				}
			}
		else
			{
			Alpha -= 1 / 16.0;
			if (Alpha <= 0.2)
				{
				Alpha = 0.2;
				visDir = 1;
				}
			}

		if (master && master.health > 0)
			{
			double auraScale = max(0.5, master.radius * 0.22);
			scale.x = scale.y = auraScale;
			SetOrigin((master.pos.x, master.pos.y, master.floorz + 1), true);
			return;
			}
		Destroy();
		}

	states
		{
		Spawn:
			PENT A 1 Bright;
			loop;
		}
	}

class cl_SpectralWisp : Actor
	{
	int visDir;
	double orbitAngle;
	double orbitDist;
	double heightFactor;
	double driftSpeed;
	int sightTic;

	default
		{
		+NOINTERACTION;
		+NOGRAVITY;
		+BRIGHT;
		RenderStyle "Add";
		Alpha 0.45;
		scale 0.35;
		}

	override void PostBeginPlay()
		{
		super.PostBeginPlay();
		orbitAngle = frandom(0.0, 360.0);
		orbitDist = frandom(20.0, 36.0);
		heightFactor = frandom(0.25, 0.85);
		driftSpeed = frandompick(-2.0, 2.0);
		visDir = 1;
		}

	override void Tick()
		{
		super.Tick();

		if (master && (++sightTic % 15) == 0 && !cl_Static.cl_CosmeticFXVisible(master))
			{
			Alpha = 0;
			return;
			}
		if (master)
			Alpha = max(Alpha, 0.2);

		if (visDir > 0)
			{
			Alpha += 1 / 24.0;
			if (Alpha >= 0.7) { Alpha = 0.7; visDir = -1; }
			}
		else
			{
			Alpha -= 1 / 24.0;
			if (Alpha <= 0.15) { Alpha = 0.15; visDir = 1; }
			}

		if (!master || master.health < 1)
			{
			Destroy();
			return;
			}

		orbitAngle += driftSpeed;
		double rad = orbitAngle;
		double xoff = cos(rad) * orbitDist;
		double yoff = sin(rad) * orbitDist;
		A_Warp(AAPTR_MASTER,
			xofs: xoff,
			yofs: yoff,
			flags: WARPF_INTERPOLATE | WARPF_NOCHECKPOSITION,
			heightoffset: heightFactor);
		}

	states
		{
		Spawn:
			GLOW A 1 Bright;
			loop;
		}
	}

class cl_BlinkTrail : Actor
	{
	default
		{
		+NOBLOCKMAP;
		+NOGRAVITY;
		RenderStyle "Translucent";
		Alpha 0.6;
		}

	override void Tick()
		{
		super.Tick();
		A_FadeOut(0.04);
		if (Alpha <= 0.05)
			Destroy();
		}

	states
		{
		Spawn:
			"####" "#" 1;
			loop;
		}
	}

class cl_MissileGlow : Actor
	{
	int traitFrame;

	default
		{
		+NOINTERACTION;
		+NOGRAVITY;
		+BRIGHT;
		RenderStyle "Translucent";
		alpha 0.35;
		scale 0.55;
		}

	override void Tick()
		{
		super.Tick();

		if (!master)
			{
			Destroy();
			return;
			}

		if (!master.bMISSILE)
			{
			Destroy();
			return;
			}

		int zofs = int(master.height * 0.35);
		A_Warp(AAPTR_MASTER, zofs: zofs, flags: WARPF_INTERPOLATE | WARPF_NOCHECKPOSITION);

		State death = master.FindState("Death");
		if (death && Actor.InStateSequence(master.CurState, death))
			{
			Destroy();
			return;
			}

		if (master.vel.x == 0 && master.vel.y == 0)
			Destroy();
		}

	states
		{
		Spawn:
			GLOW "#" 1;
			wait;
		}
	}

class cl_Fireball : FastProjectile
	{
	default
		{
		+BRIGHT;
		-NOGRAVITY;
		Speed 10;
		Damage 3;
		Gravity 0.1;
		Radius 6;
		Height 8;
		}
	override int SpecialMissileHit(actor victim)
		{
		if (victim && target && (victim == target || victim is target.GetClassName()))
			return 1;
		if (victim && victim.CountInv("cl_PersistentInfo"))
			return 1;
		return -1;
		}
	States
		{
		Spawn:
			CBAL AB 4 Bright;
			loop;
		Death:
			CBAL CDE 4 Bright;
			stop;
		}
	}

class cl_Explosion : Actor
	{
	default
		{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+BRIGHT;
		+DONTSPLASH;
		Radius 8;
		Height 8;
		}

	override void PostBeginPlay()
		{
		Super.PostBeginPlay();
		SetStateLabel("Death");
		}

	states
		{
		Spawn:
			TNT1 A 0 NoDelay
				{
				cl_Sounds.PlayExplosion(self);
				}
			Goto Death;
		Death:
			OEXP A 8 Bright A_Explode(128, 128);
			OEXP B 6 Bright;
			OEXP C 4 Bright;
			stop;
		}
	}

class cl_CreepBase : Actor
	{
	int count;
	property CreepEffect: CreepEffect; class<Inventory> CreepEffect;
	property CreepRadius: CreepRadius; int CreepRadius;
	property CreepTick: CreepTick; int CreepTick;
	property CreepLife: CreepLife; int CreepLife;
	property SpriteScale: SpriteScale; double SpriteScale;
	property FlatScale: FlatScale; double FlatScale;

	default
		{
		+NOGRAVITY;
		+BRIGHT;
		alpha 0.0;
		RenderStyle "Stencil";
		StencilColor "448844";
		cl_CreepBase.CreepRadius 48;
		cl_CreepBase.CreepLife 3;
		cl_CreepBase.CreepTick 35;
		cl_CreepBase.SpriteScale 0.6;
		cl_CreepBase.FlatScale 0.3;
		}

	override void BeginPlay()
		{
		Super.BeginPlay();
		bFLATSPRITE = true;
		bSPRITEFLIP = random(0, 1);
		SetOrigin((pos.x, pos.y, floorz + 1), false);
		scale.x = scale.y = frandom(FlatScale, FlatScale + (FlatScale * 0.2));
		angle = frandom(0.0, 360.0);
		}

	override void Tick()
		{
		Super.Tick();
		if (isFrozen())
			return;
		if (level.Time % CreepTick == 0)
			A_RadiusGive(CreepEffect, CreepRadius, RGF_CUBE | RGF_PLAYERS, 1);
		if (GetAge() % 35 == 0)
			{
			count++;
			if (count > CreepLife)
				SetStateLabel("Disappear");
			}
		SetOrigin((pos.x, pos.y, floorz + 1), true);
		}

	states
		{
		Spawn:
			BSPL AAAAA 1 A_FadeIn(0.1);
		Idle:
			BSPL A 35;
			loop;
		Disappear:
			"####" "#" 1
				{
				A_FadeOut(0.1);
				A_SetScale(scale.x - (scale.x * 0.05));
				if (scale.x < 0.00001) { Destroy(); }
				}
			wait;
		}
	}

class cl_ToxicCreep : cl_CreepBase
	{
	default
		{
		cl_CreepBase.CreepEffect 'cl_CreepDamage';
		}
	}

class cl_CreepDamage : CustomInventory
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
				if (invoker.owner && cl_Static.cl_OwnerResistsToxic(invoker.owner))
					return;
				A_DamageSelf(5, "cl_Poison");
				}
			stop;
		}
	}

class cl_VeteranFrontArmor : Powerup
	{
	override void ModifyDamage(int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags)
		{
		newdamage = damage;
		if (passive && Owner && inflictor)
			{
			double facing = abs(deltaangle(Owner.angle, Owner.angleTo(inflictor)));
			if (facing <= 90)
				newdamage = max(1, int(damage * 0.45));
			}
		}
	}

class cl_VeteranFrontArmorGiver : PowerupGiver
	{
	default
		{
		Powerup.Type "cl_VeteranFrontArmor";
		Powerup.Duration -5;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		}
	}

class cl_BulwarkArmor : Powerup
	{
	int armorHP;
	int maxArmorHP;
	bool broken;

	override void InitEffect()
		{
		super.InitEffect();
		if (!Owner)
			return;

		int baseHP = Owner.health;
		if (baseHP <= 0)
			baseHP = 50;

		double mul = cl_Static.cl_ReturnCVAR("cl_bulwark_armor_mul");
		if (mul < 1.0)
			mul = 1.0;
		if (mul > 8.0)
			mul = 8.0;

		maxArmorHP = max(75, int(double(baseHP) * mul));
		armorHP = maxArmorHP;
		}

	override void ModifyDamage(int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags)
		{
		newdamage = damage;
		if (!passive || broken || armorHP <= 0 || damage <= 0)
			return;

		int armorLoss;
		if (cl_Static.cl_IsFireDamage(damageType) || cl_Static.cl_IsExplosionDamage(damageType))
			armorLoss = damage;
		else
			armorLoss = max(1, int(damage * 0.25));

		if (armorLoss >= armorHP)
			{
			newdamage = max(1, damage - int(double(armorHP) * (cl_Static.cl_IsFireDamage(damageType) ? 1.0 : 0.75)));
			armorHP = 0;
			broken = true;
			if (Owner)
				{
				cl_Sounds.PlayArmorBreak(Owner, 0.5, 1.2);
				Owner.A_SpawnItemEx("cl_ArmorBreakFX", flags: SXF_NOCHECKPOSITION);
				}
			return;
			}

		armorHP -= armorLoss;
		newdamage = max(0, int(damage * 0.05));
		}

	override void DoEffect()
		{
		super.DoEffect();
		if (Owner && !broken && armorHP > 0 && (level.time % 35) == 0)
			{
			if (cl_Static.cl_CosmeticFXVisible(Owner))
				Owner.A_SpawnParticle("44ff44",
					flags: SPF_FULLBRIGHT | SPF_RELPOS,
					lifetime: 12,
					size: frandom(1.0, 2.0),
					zoff: frandom(Owner.height * 0.2, Owner.height * 0.8));
			}
		}
	}

class cl_BulwarkArmorGiver : PowerupGiver
	{
	default
		{
		Powerup.Type "cl_BulwarkArmor";
		Powerup.Duration -5;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		}
	}

class cl_ArmorBreakFX : Actor
	{
	default
		{
		+NOBLOCKMAP;
		+NOGRAVITY;
		RenderStyle "Add";
		Alpha 0.85;
		}
	states
		{
		Spawn:
			GLOW A 2 Bright A_FadeOut(0.15);
			stop;
		}
	}

class cl_CaptainBuffPower : Powerup
	{
	override void InitEffect()
		{
		super.InitEffect();
		if (Owner)
			Owner.A_SetRenderStyle(Owner.Alpha, STYLE_Translucent);
		}

	override void ModifyDamage(int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags)
		{
		newdamage = damage;
		if (passive && damage > 0)
			{
			int drPct = cl_Static.cl_ReturnCVAR("cl_captain_buff_dr");
			double dr = max(0.1, min(1.0, double(drPct) / 100.0));
			newdamage = max(1, int(damage * dr));
			}
		}

	override double GetSpeedFactor()
		{
		int spdPct = cl_Static.cl_ReturnCVAR("cl_captain_buff_speed");
		double spd = max(1.0, min(2.0, double(spdPct) / 100.0));
		return spd;
		}
	}

class cl_CaptainBuffGiver : PowerupGiver
	{
	default
		{
		Powerup.Type "cl_CaptainBuffPower";
		Powerup.Duration 45;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		}
	}

class cl_CaptainShield : Powerup
	{
	override void ModifyDamage(int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags)
		{
		newdamage = damage;
		if (!passive || !Owner || damage <= 0)
			return;

		int radius = cl_Static.cl_ReturnCVAR("cl_captain_radius");
		BlockThingsIterator it = BlockThingsIterator.Create(Owner, radius);
		while (it.Next())
			{
			Actor mo = it.thing;
			if (mo == Owner)
				continue;
			if (!cl_Static.cl_ActorIsUsable(mo))
				continue;
			if (mo.bBOSS)
				continue;
			if (!Owner.CheckSight(mo))
				continue;
			if (mo.CountInv("cl_CaptainBuffPower") || mo.CountInv("cl_CaptainBuffGiver"))
				{
				newdamage = 0;
				return;
				}
			}
		}
	}

class cl_CaptainShieldGiver : PowerupGiver
	{
	default
		{
		Powerup.Type "cl_CaptainShield";
		Powerup.Duration -5;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		}
	}

class cl_CaptainRing : Actor
	{
	int visDir;
	int sightTic;

	default
		{
		+NOINTERACTION;
		+FLATSPRITE;
		+BRIGHT;
		RenderStyle "Add";
		scale 1.1;
		Alpha 0.4;
		}

	override void PostBeginPlay()
		{
		super.PostBeginPlay();
		visDir = 1;
		}

	override void Tick()
		{
		super.Tick();

		if (!master || master.health < 1)
			{
			Destroy();
			return;
			}

		if ((++sightTic % 15) == 0 && !cl_Static.cl_CosmeticFXVisible(master))
			{
			Alpha = 0;
			return;
			}
		if (Alpha < 0.2)
			Alpha = 0.2;

		if (visDir > 0)
			{
			Alpha += 1 / 20.0;
			if (Alpha >= 0.55) { Alpha = 0.55; visDir = -1; }
			}
		else
			{
			Alpha -= 1 / 20.0;
			if (Alpha <= 0.2) { Alpha = 0.2; visDir = 1; }
			}

		double ringScale = max(0.6, master.radius * 0.35);
		scale.x = scale.y = ringScale;
		SetOrigin((master.pos.x, master.pos.y, master.floorz + 2), true);
		angle += 2.0;
		}

	states
		{
		Spawn:
			PENT A 1 Bright;
			loop;
		}
	}

class cl_Shadow : Actor
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
			"####" "#" 1 A_FadeOut(0.05);
			loop;
		}
	}

class cl_ShadowSpawner : Inventory
	{
	const lifespan = 20;
	int age;
	default { inventory.MaxAmount 1; }

	override void AttachToOwner(Actor other)
		{
		super.AttachToOwner(other);
		age = lifespan;
		}

	override void DoEffect()
		{
		super.DoEffect();
		age--;
		if (owner)
			{
			let shadow = owner.Spawn("cl_Shadow", owner.pos);
			if (shadow)
				{
				shadow.Sprite = owner.Sprite;
				shadow.Frame = owner.Frame;
				shadow.Angle = owner.Angle;
				shadow.Translation = owner.Translation;
				shadow.A_SetSize(owner.radius, owner.height);
				}
			}
		if (age <= 0)
			Destroy();
		}
	}
