class cl_CaptainController : cl_BaseController
	{
	int minionCount;
	int auraFXTic;

	override color GetParticleColour()
		{
		static const color Colours[] = { "ffd700", "ffcc00", "ffe066", "ffffff" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_CaptainToken");
		}

	override void cl_InitEffect()
		{
		eftic = 8;
		champion.Health = int(champion.Health * 1.35);
		champion.A_GiveInventory("cl_CaptainShieldGiver");
		if (traitFX && cl_CosmeticFXVisible())
			champion.A_SpawnItemEx("cl_CaptainRing", flags: SXF_SETMASTER | SXF_NOCHECKPOSITION);
		}

	override void cl_TickEffect()
		{
		if (!cl_Static.cl_ActorIsUsable(champion))
			return;

		int radius = cl_Static.cl_ReturnCVAR("cl_captain_radius");
		minionCount = 0;

		BlockThingsIterator it = BlockThingsIterator.Create(champion, radius);
		while (it.Next())
			{
			Actor mo = it.thing;
			if (mo == champion)
				continue;
			if (!cl_Static.cl_ActorIsUsable(mo))
				continue;
			if (mo.bBOSS || mo.bSPECIAL)
				continue;
			if (mo.CountInv("cl_CaptainToken") || mo.CountInv("cl_BulwarkToken"))
				continue;
			if (!champion.CheckSight(mo))
				continue;

			mo.A_GiveInventory("cl_CaptainBuffGiver");
			minionCount++;
			}

		if (traitFX && cl_CosmeticFXVisible() && (++auraFXTic % 15) == 0)
			{
			bool hasRing;
			ThinkerIterator tit = ThinkerIterator.Create("cl_CaptainRing");
			cl_CaptainRing ring;
			while (ring = cl_CaptainRing(tit.Next()))
				{
				if (ring.master == champion)
					{
					hasRing = true;
					break;
					}
				}
			if (!hasRing)
				champion.A_SpawnItemEx("cl_CaptainRing", flags: SXF_SETMASTER | SXF_NOCHECKPOSITION);
			}
		}

	override void cl_DeathEffect()
		{
		if (traitFX && cl_CosmeticFXVisible())
			champion.A_SpawnItemEx("cl_SpawnBurst", flags: SXF_TRANSFERTRANSLATION | SXF_NOCHECKPOSITION);
		}
	}
