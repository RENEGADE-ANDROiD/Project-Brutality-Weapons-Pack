class cl_BlinkController : cl_BaseController
	{
	int steps;
	int chance;
	int cooldown;
	int blinkRemaining;
	bool blinkActive;

	override color GetParticleColour()
		{
		static const color Colours[] = { "ffffff", "33cc33", "70db70", "1f7a1f", "99ff99" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_BlinkToken");
		}

	override void cl_InitEffect()
		{
		eftic = 35;
		steps = 50;
		chance = 4;
		}

	override void Tick()
		{
		if (blinkActive && !cl_Static.cl_ActorIsUsable(champion))
			{
			blinkActive = false;
			Destroy();
			return;
			}

		if (blinkActive && cl_Static.cl_ActorIsUsable(champion))
			{
			if (champion.Health < 1)
				{
				blinkActive = false;
				champion.bJUMPDOWN = champion.default.bJUMPDOWN;
				champion.bTHRUACTORS = champion.default.bTHRUACTORS;
				champion.MaxDropOffHeight = champion.default.MaxDropOffHeight;
				champion.MaxStepHeight = champion.Default.MaxStepHeight;
				super.Tick();
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

			champion.A_Chase(null, null, CHF_NORANDOMTURN);
			if (traitFX && blinkRemaining % 8 == 0)
				cl_SpawnBlinkTrail();

			if (--blinkRemaining <= 0)
				cl_EndBlink();

			cl_UpdateRampage();

			if (champion.Health > oldhealth)
				oldhealth = champion.Health;

			if (champion.Health < oldhealth && champion.Health > 0)
				{
				oldhealth = champion.Health;
				if (level.Time != lastHitTick)
					{
					lastHitTick = level.Time;
					cl_SpawnHitFX();
					}
				}

			if (mutation == mutation_Spectral)
				champion.bSPECTRAL = champion.alpha < 0.5;

			if (rampaging)
				champion.DamageMultiply = baseDamageMultiply * 1.35;
			else if (mutation == mutation_Rampage)
				champion.DamageMultiply = baseDamageMultiply;
			return;
			}

		super.Tick();
		}

	override void cl_TickEffect()
		{
		if (cooldown)
			{
			cooldown--;
			return;
			}

		if (champion.target && cl_Static.cl_ActorIsUsable(champion) && !random(0, chance))
			cl_StartBlink();
		}

	override void cl_HitEffect()
		{
		if (!random(0, 2))
			cl_StartBlink();
		}

	void cl_StartBlink()
		{
		if (blinkActive || cooldown || !cl_Static.cl_ActorIsUsable(champion))
			return;

		blinkRemaining = random(steps, steps * 2);
		blinkActive = true;

		champion.A_SpawnItemEx("TeleportFog");
		if (traitFX)
			cl_SpawnBlinkTrail();

		champion.bJUMPDOWN = true;
		champion.bTHRUACTORS = true;
		champion.MaxDropOffHeight = 512;
		champion.MaxStepHeight = 512;
		champion.A_SetAngle(champion.angle + randompick(-90, -45, 0, 45, 90));
		}

	void cl_EndBlink()
		{
		blinkActive = false;

		if (!cl_Static.cl_ActorIsUsable(champion))
			{
			cooldown = random(2, 5);
			return;
			}

		champion.bJUMPDOWN = champion.default.bJUMPDOWN;
		champion.bTHRUACTORS = champion.default.bTHRUACTORS;
		champion.MaxDropOffHeight = champion.default.MaxDropOffHeight;
		champion.MaxStepHeight = champion.Default.MaxStepHeight;

		champion.A_SpawnItemEx("TeleportFog");
		if (traitFX)
			cl_SpawnBlinkTrail();

		cooldown = random(2, 5);
		}
	}
