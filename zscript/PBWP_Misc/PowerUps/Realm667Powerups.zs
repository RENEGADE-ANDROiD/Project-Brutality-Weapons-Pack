// Credits: DeVloek (FireAuraSphere, FrostAuraSphere; Grim Dawn aura prompt); Ghastly_dragon (HandOfTheWraith). DECORATE: actors/Items/Realm667Powerups/Realm667Powerups.dec.

class FireAuraSphere : PowerupGiver
{
	Default
	{
		//$Category Powerups
		//$Sprite VFIAF0
		//$Title "Fire Aura Sphere"
		+COUNTITEM;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.BIGPOWERUP;
		Inventory.MaxAmount 0;
		Powerup.Type "FireAuraPower";
		Powerup.Duration -20;
		Powerup.Color "FF3000", 0.002;
		Inventory.PickupMessage "Fire Aura! Incinerates anything that gets close.";
	}
	States
	{
	Spawn:
		VFIA ABCDEFGH 5 bright;
		Loop;
	}
}

class FireAuraPower : Powerup
{
	int arad;

	override void InitEffect()
	{
		super.InitEffect();
		arad = 160;
		if (owner)
		{
			owner.A_StartSound("FireAura/aura", 2, CHANF_LOOPING | ATTN_NONE);
			owner.A_AttachLight("FIAL1", DynamicLight.FlickerLight, "FF8000", arad * 1.0, arad * 1.05,
				flags: DYNAMICLIGHT.LF_NOSHADOWMAP,
				ofs: (0, 0, owner.height / 2), param: 0.5);
			owner.A_AttachLight("FIAL2", DynamicLight.PulseLight, "FFE000", arad * 1.0, arad * 1.05,
				flags: DYNAMICLIGHT.LF_NOSHADOWMAP | DYNAMICLIGHT.LF_ATTENUATE,
				ofs: (0, 0, owner.height / 2), param: 0.5);
			owner.A_AttachLight("FIAL3", DynamicLight.PulseLight, "FFFFFF", arad * 0.1, arad * 0.4,
				flags: DYNAMICLIGHT.LF_NOSHADOWMAP | DYNAMICLIGHT.LF_ATTENUATE,
				ofs: (0, 0, owner.height / 2), param: 2.5);
		}
	}

	override void Tick()
	{
		if (owner)
		{
			if (GetAge() % 5 == 0)
			{
				array<actor> monsters;
				let it = BlockThingsIterator.Create(owner, arad);
				while (it.Next())
				{
					actor mon = it.thing;
					if (mon) mon.A_RemoveLight("FIATL");
					if (mon && mon.bIsMonster && !mon.bKilled && monsters.Find(mon) == monsters.Size()
						&& owner.Distance3D(mon) <= arad && owner.CheckSight(mon))
					{
						monsters.Push(mon);
					}
				}

				if (monsters.Size() > 0)
				{
					int index = random(0, monsters.Size() - 1);
					actor mon = monsters[index];
					if (mon && !mon.bKilled && owner.Distance3D(mon) <= arad && owner.CheckSight(mon))
					{
						int ht = int(mon.height / 2);
						for (int i = 0; i < 4; i++) SparkParticle("FFFFFF", mon.pos, ht);
						for (int i = 0; i < 4; i++) SparkParticle("FFE060", mon.pos, ht);
						for (int i = 0; i < 4; i++) SparkParticle("FF8040", mon.pos, ht);

						mon.A_AttachLight("FIATL", DynamicLight.PointLight, "FFB060", mon.radius, mon.radius,
							flags: DYNAMICLIGHT.LF_NOSHADOWMAP | DYNAMICLIGHT.LF_ATTENUATE,
							ofs: (0, 0, mon.height / 2));

						mon.A_StartSound("FireAura/fire");

						if (mon.tics > 0) mon.tics += 4;

						if (mon.health > 6)
						{
							actor firedmg = Spawn("FireAuraFire", mon.pos);
							if (firedmg)
							{
								firedmg.target = owner;
								firedmg.scale.x = 0.8 + (mon.radius * 0.005 * mon.scale.x);
								firedmg.scale.y = 0.4 + (mon.height * 0.0075 * mon.scale.y);
								firedmg.DoMissileDamage(mon);
							}
						}
						if (mon.health <= 6)
						{
							int stxW = 0, stxH = 0;
							TextureID stx;
							if (mon.CurState != null)
							{
								stx = mon.CurState.GetSpriteTexture(0);
								if (stx.IsValid()) [stxW, stxH] = TexMan.GetSize(stx);
							}
							let monScale = mon.scale;
							let monSprite = mon.sprite;
							let monFrame = mon.frame;

							mon.A_Die();
							if (mon.bBossDeath || mon.bBoss) mon.A_BossDeath();
							actor burned;
							if (!mon.bNOICEDEATH) burned = Spawn("FireAuraVictim", mon.pos);
							if (burned)
							{
								burned.scale = monScale;
								burned.sprite = monSprite;
								burned.frame = monFrame;
								if (stxW > 0 && stxH > 0)
								{
									burned.A_SetSize(stxW / 3 * monScale.x, stxH / 1.2 * monScale.y);
								}
								double ptch = 1 - (stxW * 0.002 * monScale.x);
								burned.A_StartSound("FireAura/firedeath", pitch: ptch);
								mon.destroy();
							}
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
			owner.A_RemoveLight("FIAL1");
			owner.A_RemoveLight("FIAL2");
			owner.A_RemoveLight("FIAL3");
			owner.A_StopSound(2);
		}
		super.EndEffect();
	}

	void SparkParticle(color col, vector3 mpos, double mz)
	{
		A_SpawnParticle(col,
			flags: SPF_FULLBRIGHT,
			lifetime: 15,
			size: random(3, 5),
			xoff: mpos.x + random(-5, 5),
			yoff: mpos.y + random(-5, 5),
			zoff: mz,
			velx: random(-5, 5),
			vely: random(-5, 5),
			velz: random(-5, 5),
			startalphaf: 1.0, fadestepf: -1);
	}

	void AuraParticle()
	{
		int rnd = random(1, 4);
		TextureID ptx;
		if (rnd == 1)      ptx = TexMan.CheckForTexture("VFIRD0");
		else if (rnd == 2) ptx = TexMan.CheckForTexture("VFIRE0");
		else if (rnd == 3) ptx = TexMan.CheckForTexture("VFIRF0");
		else               ptx = TexMan.CheckForTexture("VFIRG0");

		owner.A_SpawnParticleEx("FFA060", ptx,
			style: STYLE_Add,
			flags: SPF_FULLBRIGHT,
			lifetime: 4,
			size: random(5, 30),
			xoff: random(-arad, arad),
			yoff: random(-arad, arad),
			zoff: 0,
			startalphaf: 0.8, fadestepf: 0);
	}
}

class FireAuraFire : Actor
{
	Default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+BLOODLESSIMPACT;
		DamageFunction random(2, 12);
		DamageType "Fire";
		RenderStyle "Add";
		Alpha 0.8;
		Translation "0:255=%[0,0,0]:[2.0,0.8,0.4]";
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay
		{
			if (!random(0, 1)) bXFLIP = !bXFLIP;
			A_StartSound("FireAura/fire");
		}
		VFIR ABCDEFGH 3 bright;
		Stop;
	}
}

class FireAuraVictim : Actor
{
	actor fadecopy;
	Default
	{
		+NOBLOCKMAP;
		+NOINTERACTION;
		Renderstyle "Stencil";
		Alpha 0.0;
	}
	States
	{
	Spawn:
		#### # 0 NoDelay
		{
			fadecopy = Spawn("FireAuraVictimFade", pos);
			if (fadecopy)
			{
				fadecopy.scale  = scale;
				fadecopy.sprite = sprite;
				fadecopy.frame  = frame;
			}
		}
	Fadein:
		#### # 1
		{
			A_Smoke();
			A_FadeIn(0.075);
			if (alpha >= 1.0)
			{
				if (fadecopy) fadecopy.destroy();
				destroy();
			}
		}
		Loop;
	}

	void A_Smoke()
	{
		int ht = random(int(height / 2), int(height));
		int loops = int(radius / 10);
		for (int i = 0; i < loops; i += 1)
		{
			A_SpawnParticle("Black",
				lifetime: 280,
				size: random(2, 4),
				xoff: random(int(-radius), int(radius)),
				yoff: random(int(-radius), int(radius)),
				zoff: ht,
				velx: frandom(-1.0, 1.0),
				vely: frandom(-1.0, 1.0),
				velz: frandom(3.0, 5.0),
				startalphaf: 0.4,
				fadestepf: -1,
				sizestep: 1.0);
			actor ashes = Spawn("FireAuraAshes", pos + (random(int(-radius), int(radius)), random(int(-radius), int(radius)), ht));
		}
	}
}

class FireAuraVictimFade : Actor
{
	Default
	{
		+NOBLOCKMAP;
		+NOINTERACTION;
		Renderstyle("Translucent");
		Alpha 1.0;
	}
	States
	{
	Spawn:
		#### # 1
		{
			A_FadeOut(0.075);
		}
		Loop;
	}
}

class FireAuraAshes : Actor
{
	Default
	{
		+NOBLOCKMAP;
		RenderStyle "Translucent";
		Alpha 0.4;
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay
		{
			if (!random(0, 1)) bXFLIP = !bXFLIP;
			if (!random(0, 1)) bYFLIP = !bYFLIP;
			vel.x = frandom(-1.0, 1.0);
			vel.y = frandom(-1.0, 1.0);
			vel.z = frandom(0.0, 0.5);
		}
		VASH A 5;
	See:
		VASH B 5
		{
			if (pos.z == floorz) SetStateLabel("Death");
		}
		Loop;
	Death:
		VASH CDE 5;
	Fadeout:
		VASH F 1
		{
			if (!random(0, 4)) A_FadeOut(0.001);
		}
		Loop;
	}
}

class FrostAuraSphere : PowerupGiver
{
	Default
	{
		//$Category Powerups
		//$Sprite VFRAG0
		//$Title "Frost Aura Sphere"
		+COUNTITEM;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.BIGPOWERUP;
		Inventory.MaxAmount 0;
		Powerup.Type "FrostAuraPower";
		Powerup.Duration -20;
		Powerup.Color "4040FF", 0.002;
		Inventory.PickupMessage "Frost Aura! Slows and freezes anything that gets close.";
	}
	States
	{
	Spawn:
		VFRA ABCDEFGHGFEDCB 3 bright;
		Loop;
	}
}

class FrostAuraPower : Powerup
{
	int arad;

	override void InitEffect()
	{
		super.InitEffect();
		arad = 448;
		if (owner)
		{
			owner.A_StartSound("FrostAura/aura", 3, CHANF_LOOPING | ATTN_NONE);
			owner.A_AttachLight("FRAL1", DynamicLight.PulseLight, "C0C0FF", arad * 1.0, arad * 1.1,
				flags: DYNAMICLIGHT.LF_NOSHADOWMAP | DYNAMICLIGHT.LF_ATTENUATE,
				ofs: (0, 0, owner.height), param: 1.0);
			owner.A_AttachLight("FRAL2", DynamicLight.PulseLight, "4040FF", arad * 0.15, arad * 0.3,
				flags: DYNAMICLIGHT.LF_NOSHADOWMAP | DYNAMICLIGHT.LF_ATTENUATE,
				ofs: (0, 0, owner.height), param: 2.5);
		}
	}

	override void Tick()
	{
		if (owner)
		{
			if (GetAge() % 10 == 0)
			{
				let it = BlockThingsIterator.Create(owner, arad + 128);
				while (it.Next())
				{
					actor mon = it.thing;
					if (mon && mon.bIsMonster) mon.speed = mon.default.speed;
					if (mon && mon.bIsMonster && owner.Distance3D(mon) <= arad && owner.CheckSight(mon))
					{
						if (!mon.bKilled)
						{
							if (mon.tics > 0)
							{
								double shp = mon.spawnhealth();
								double hpcur = mon.health;
								if (hpcur < 1)
									hpcur = 1;
								int hpfactor = int(shp / hpcur * 3);
								hpfactor = clamp(hpfactor, 2, 5);
								mon.tics  += hpfactor;
								mon.speed -= hpfactor;
							}
							actor frostdmg = Spawn("FrostAuraFreeze", mon.pos);
							if (frostdmg)
							{
								int stxW = 0, stxH = 0;
								TextureID stx;
								if (mon.CurState != null)
								{
									stx = mon.CurState.GetSpriteTexture(0);
									if (stx.IsValid()) [stxW, stxH] = TexMan.GetSize(stx);
								}
								frostdmg.target = owner;
								if (stxW > 0 && stxH > 0)
								{
									frostdmg.A_SetSize(stxW / 3 * mon.scale.x, stxH / 1.2 * mon.scale.y);
								}
								frostdmg.DoMissileDamage(mon);
							}
						}
						if (mon.bKilled && !mon.bICECORPSE && !mon.bNOICEDEATH && GetAge() % 20 == 0)
							mon.SetStateLabel("GenericFreezeDeath");
						if (mon.bICECORPSE)
						{
							actor frozen = Spawn("FrostAuraFrozen", mon.pos);
							if (frozen) frozen.A_SetSize(mon.radius, mon.height);
						}
					}
				}
			}

			owner.A_SpawnParticle("FFFFFF", lifetime: 280, size: random(1, 3), xoff: random(-arad, arad), yoff: random(-arad, arad), zoff: 128,
				velx: frandom(-0.3, 0.3), vely: frandom(-0.3, 0.3), velz: frandom(-2.0, -4.0), startalphaf: 0.5);
			owner.A_SpawnParticle("F0F0EF", lifetime: 280, size: random(1, 3), xoff: random(-arad, arad), yoff: random(-arad, arad), zoff: 128,
				velx: frandom(-0.3, 0.3), vely: frandom(-0.3, 0.3), velz: frandom(-2.0, -4.0), startalphaf: 0.5);
			owner.A_SpawnParticle("E0E0DF", lifetime: 280, size: random(1, 3), xoff: random(-arad, arad), yoff: random(-arad, arad), zoff: 128,
				velx: frandom(-0.3, 0.3), vely: frandom(-0.3, 0.3), velz: frandom(-2.0, -4.0), startalphaf: 0.5);
			owner.A_SpawnParticle("D0D0CF", lifetime: 280, size: random(1, 3), xoff: random(-arad, arad), yoff: random(-arad, arad), zoff: 128,
				velx: frandom(-0.3, 0.3), vely: frandom(-0.3, 0.3), velz: frandom(-2.0, -4.0), startalphaf: 0.5);
			owner.A_SpawnParticle("C0C0BF", lifetime: 280, size: random(1, 3), xoff: random(-arad, arad), yoff: random(-arad, arad), zoff: 128,
				velx: frandom(-0.3, 0.3), vely: frandom(-0.3, 0.3), velz: frandom(-2.0, -4.0), startalphaf: 0.5);
		}
		super.Tick();
	}

	override void EndEffect()
	{
		if (owner)
		{
			owner.A_RemoveLight("FRAL1");
			owner.A_RemoveLight("FRAL2");
			owner.A_StopSound(3);
			let it = BlockThingsIterator.Create(owner, arad);
			while (it.Next())
			{
				actor mon = it.thing;
				if (mon && mon.bIsMonster) mon.speed = mon.default.speed;
			}
		}
		super.EndEffect();
	}
}

class FrostAuraFreeze : Actor
{
	Default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+PAINLESS;
		+BLOODLESSIMPACT;
		DamageFunction random(1, 6);
		DamageType "Ice";
	}
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 AAAAAAAAAA 1
		{
			A_SpawnParticle("BFBFFF",
				lifetime: 70,
				size: random(3, 6),
				xoff: random(int(-radius), int(radius)),
				yoff: random(int(-radius), int(radius)),
				zoff: random(int(height / 4), int(height)),
				velx: frandom(-1.0, 1.0),
				vely: frandom(-1.0, 1.0),
				velz: frandom(-1.0, 1.0),
				startalphaf: 0.3, fadestepf: -1, sizestep: 0.4);
		}
		Stop;
	}
}

class FrostAuraFrozen : Actor
{
	Default
	{
		+NOBLOCKMAP;
		+NOINTERACTION;
	}
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 AAAAAAAAAAA 1
		{
			A_SpawnParticle("BFBFFF",
				lifetime: 70,
				size: random(6, 12),
				xoff: random(int(-radius), int(radius)),
				yoff: random(int(-radius), int(radius)),
				zoff: random(int(height / 4), int(height)),
				velx: frandom(-1.1, 1.1),
				vely: frandom(-1.1, 1.1),
				velz: frandom(-1.1, 1.1),
				startalphaf: 0.3, fadestepf: -1, sizestep: 0.5);
		}
		Stop;
	}
}

class WraithHandProjectile : Actor
{
	Default
	{
		Speed 20;
		Damage 1;
		Projectile;
		+FORCEPAIN;
		+THRUGHOST;
		RenderStyle "Add";
		Alpha 0.6;
		Scale 0.65;
		DamageType "HandOfTheWraith";
		SeeSound "HandOfTheWraith/Fire";
	}

	override int DoSpecialDamage(Actor victim, int damage, Name damagetype)
	{
		if (victim && victim.bIsMonster)
		{
			victim.GiveInventory("WraithHandShadow", 1);
			victim.GiveInventory("WraithHandDamage", 1);
		}
		return 0;
	}

	States
	{
	Spawn:
		HWTP A 1 Bright A_SpawnItemEx("WraithHandTrail", 0, 0, 0, 0, 0, 0, 0, 128);
		Loop;
	Death:
		HWTP GHIJK 3 Bright;
		Stop;
	}
}
