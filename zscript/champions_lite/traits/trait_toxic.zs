class cl_ToxicController : cl_BaseController
	{
	override color GetParticleColour()
		{
		static const color Colours[] = { "00b300", "008000", "004d00", "88ff88" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_ToxicToken");
		}

	override void cl_InitEffect()
		{
		eftic = 10;
		}

	override void cl_TickEffect()
		{
		if (champion.target)
			champion.A_SpawnItemEx("cl_ToxicCreep", xofs: -16, yofs: frandom(-16.0, 16.0),
				angle: frandom(0.0, 360.0), flags: SXF_SETTARGET);
		}
	}
