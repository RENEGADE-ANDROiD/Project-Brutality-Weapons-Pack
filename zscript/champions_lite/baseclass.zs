class cl_BaseController : Thinker
	{
	actor champion;
	int tic;
	int eftic;
	int mutation;
	state prevState;
	int oldhealth;
	int starthealth;
	int lastHitTick;
	bool markers;
	double markerScale;
	bool particles;
	bool spawnFX;
	bool hitFX;
	bool traitFX;
	bool setup;
	bool rampaging;
	bool deathHandled;
	int particleTic;
	double baseDamageMultiply;

	virtual void cl_GiveToken() {}
	virtual void cl_InitEffect() {}
	virtual void cl_TickEffect() {}
	virtual void cl_HitEffect() {}
	virtual void cl_DeathEffect() {}

	virtual color GetParticleColour()
		{
		static const color DefaultColours[] = { "cccccc", "ffffff", "999999" };
		return DefaultColours[random(0, DefaultColours.Size() - 1)];
		}

	bool cl_CosmeticFXAllowed()
		{
		if (!cl_Static.cl_ActorIsUsable(champion))
			return false;
		if (cl_FXThrottleHandler.PerformanceFireEnabled())
			return false;
		if (!cl_FXThrottleHandler.ShouldSpawnCosmeticFX(champion))
			return false;
		return cl_Static.cl_CosmeticFXVisible(champion);
		}

	bool cl_CosmeticFXVisible()
		{
		if (!cl_Static.cl_ActorIsUsable(champion))
			return false;
		return cl_Static.cl_CosmeticFXVisible(champion);
		}

	void cl_RegisterCombatFX()
		{
		if (!cl_Static.cl_ActorIsUsable(champion))
			return;
		cl_FXThrottleHandler.RegisterCombatEvent(champion);
		}

	void cl_SpawnParticles()
		{
		if (!champion || !particles || !cl_CosmeticFXAllowed())
			return;

		color pColor = GetParticleColour();
		if (mutation == mutation_Spectral)
			{
			static const color WispColours[] = { "aaccff", "ccdfff", "8899ff", "ffffff" };
			pColor = WispColours[random(0, WispColours.Size() - 1)];
			}

		champion.A_SpawnParticle(pColor,
			flags: SPF_FULLBRIGHT | SPF_RELPOS,
			lifetime: 35,
			size: frandom(3.0, 5.0),
			angle: frandom(0.0, 359.9),
			xoff: champion.Radius,
			zoff: frandom(champion.height * 0.25, champion.height * 0.75),
			velz: frandom(0.3, 0.6),
			accelz: 0.01);
		}

	void cl_SpawnHitFX()
		{
		if (!champion || !hitFX || !cl_CosmeticFXAllowed())
			return;
		cl_RegisterCombatFX();
		for (int i = 0; i < 4; i++)
			{
			double pAngle = frandom(0.0, 359.9);
			double pVel = frandom(0.4, 1.0);
			champion.A_SpawnParticle(GetParticleColour(),
				flags: SPF_FULLBRIGHT | SPF_RELPOS,
				lifetime: 20,
				size: frandom(2.0, 4.0),
				angle: pAngle,
				xoff: frandom(-champion.Radius, champion.Radius),
				zoff: frandom(champion.height * 0.2, champion.height * 0.8),
				velx: cos(pAngle) * pVel,
				vely: sin(pAngle) * pVel,
				velz: frandom(0.2, 0.8));
			}
		}

	void cl_SpawnBurstFX()
		{
		if (!champion || !spawnFX || !cl_CosmeticFXAllowed())
			return;
		cl_RegisterCombatFX();
		champion.A_SpawnItemEx("cl_SpawnBurst", flags: SXF_TRANSFERTRANSLATION | SXF_NOCHECKPOSITION);
		}

	void cl_SpawnSpectralWisps()
		{
		if (!champion || !traitFX || !cl_CosmeticFXAllowed())
			return;
		cl_RegisterCombatFX();
		for (int i = 0; i < 3; i++)
			champion.A_SpawnItemEx("cl_SpectralWisp", flags: SXF_SETMASTER | SXF_NOCHECKPOSITION);
		}

	void cl_SpawnGiantAura()
		{
		if (!champion || !traitFX || !cl_CosmeticFXAllowed())
			return;
		cl_RegisterCombatFX();
		champion.A_SpawnItemEx("cl_GiantAura", flags: SXF_SETMASTER | SXF_NOCHECKPOSITION);
		}

	void cl_SpawnBlinkTrail()
		{
		if (!champion || !traitFX || !cl_CosmeticFXAllowed())
			return;
		cl_RegisterCombatFX();

		let trail = cl_BlinkTrail(champion.Spawn("cl_BlinkTrail", champion.pos));
		if (trail)
			{
			trail.Sprite = champion.Sprite;
			trail.Frame = champion.Frame;
			trail.Angle = champion.Angle;
			trail.Translation = champion.Translation;
			trail.A_SetSize(champion.radius, champion.height);
			}

		if (particles)
			{
			for (int i = 0; i < 3; i++)
				{
				champion.A_SpawnParticle("99ff99",
					flags: SPF_FULLBRIGHT | SPF_RELPOS,
					lifetime: 24,
					size: frandom(2.0, 4.0),
					angle: frandom(0.0, 359.9),
					xoff: frandom(-12.0, 12.0),
					yoff: frandom(-12.0, 12.0),
					zoff: frandom(0.0, champion.height * 0.5),
					velz: frandom(0.2, 0.6));
				}
			}
		}

	double cl_GetHealthFactor(int amt, bool minorboss, bool mainboss)
		{
		double factor = 1.75;
		double fac2 = 1.35;
		if (minorboss) { fac2 = 1.1; factor = 1.4; }
		if (mainboss) { fac2 = 1.0; factor = 1.12; }
		return ((amt * fac2) + 100) * factor;
		}

	void cl_ApplyMarkerVisual()
		{
		if (champion && markers)
			champion.Scale *= markerScale;
		}

	void cl_InitMutation()
		{
		switch (mutation)
			{
			case mutation_Giant:
				champion.Scale *= 1.25;
				champion.Health = int(cl_GetHealthFactor(champion.Health, champion.bBOSSDEATH, champion.bBOSS));
				champion.DamageMultiply *= 1.5;
				champion.PainChance = int(champion.PainChance * 0.5);
				champion.A_GiveInventory("cl_GiantToken");
				cl_SpawnBurstFX();
				cl_SpawnGiantAura();
				break;

			case mutation_Spectral:
				champion.bVISIBILITYPULSE = true;
				champion.bBRIGHT = true;
				champion.A_GiveInventory("cl_SpectralToken");
				cl_SpawnSpectralWisps();
				break;

			case mutation_Rampage:
				champion.A_GiveInventory("cl_RampageToken");
				break;
			}
		}

	void cl_UpdateRampage()
		{
		if (mutation != mutation_Rampage || !champion || starthealth < 1)
			return;

		bool shouldRampage = champion.Health <= int(starthealth * 0.5);
		if (shouldRampage && !rampaging)
			{
			rampaging = true;
			cl_Sounds.PlayPickup(champion, 0.6, 0.85);
			if (particles && cl_CosmeticFXAllowed())
				{
				cl_RegisterCombatFX();
				for (int i = 0; i < 8; i++)
					{
					champion.A_SpawnParticle("ff4400",
						flags: SPF_FULLBRIGHT | SPF_RELPOS,
						lifetime: 28,
						size: frandom(4.0, 7.0),
						angle: frandom(0.0, 359.9),
						xoff: frandom(-champion.Radius, champion.Radius),
						zoff: frandom(0.0, champion.height),
						velz: frandom(0.8, 1.6));
					}
				}
			}
		if (!shouldRampage && rampaging)
			rampaging = false;

		if (mutation == mutation_Rampage)
			champion.bALWAYSFAST = rampaging ? true : champion.default.bALWAYSFAST;
		}

	double cl_GetSpeedFactor()
		{
		double factor = 1.0;
		if (rampaging)
			factor = 1.65;
		return factor;
		}

	override void Tick()
		{
		super.Tick();

		if (level.isFrozen())
			return;

		if (!cl_Static.cl_ActorIsUsable(champion))
			{
			Destroy();
			return;
			}

		if (!setup)
			{
			cl_GiveToken();
			cl_InitEffect();
			cl_InitMutation();
			cl_ApplyMarkerVisual();
			champion.starthealth = int(champion.health / G_SkillPropertyFloat(SKILLP_MonsterHealth));
			starthealth = champion.starthealth;
			oldhealth = champion.Health;
			baseDamageMultiply = champion.DamageMultiply;
			setup = true;
			cl_SpawnBurstFX();
			}

		if (champion.Health < 1)
			{
			if (!deathHandled)
				{
				deathHandled = true;
				cl_DeathEffect();
				}
			champion.StartHealth = champion.Default.StartHealth;
			champion.PainChance = champion.Default.PainChance;
			champion.DamageFactor = champion.Default.DamageFactor;
			champion.DamageMultiply = champion.Default.DamageMultiply;
			Destroy();
			return;
			}

		cl_UpdateRampage();

		if (particles)
			{
			if ((++particleTic % 3) == 0)
				cl_SpawnParticles();
			}

		if (champion.Health > oldhealth)
			oldhealth = champion.Health;

		if (champion.Health < oldhealth && champion.Health > 0)
			{
			oldhealth = champion.Health;
			if (level.Time != lastHitTick)
				{
				lastHitTick = level.Time;
				cl_HitEffect();
				cl_SpawnHitFX();
				}
			}

		if (eftic && ++tic >= eftic)
			{
			cl_TickEffect();
			tic = 0;
			}

		if (mutation == mutation_Spectral)
			{
			champion.bSPECTRAL = champion.alpha < 0.5;
			}

		if (rampaging)
			champion.DamageMultiply = baseDamageMultiply * 1.35;
		else if (mutation == mutation_Rampage)
			champion.DamageMultiply = baseDamageMultiply;
		}
	}

class cl_PersistentInfo : Inventory
	{
	class<thinker> c;
	int i;
	int m;
	default
		{
		Inventory.MaxAmount 1;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.HUBPOWER;
		+INVENTORY.UNTOSSABLE;
		}
	}
