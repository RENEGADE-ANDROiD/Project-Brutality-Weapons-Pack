class cl_StalkerController : cl_BaseController
	{
	override color GetParticleColour()
		{
		static const color Colours[] = { "ffffff", "808080", "404040", "cccccc" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_StalkerToken");
		}

	override void cl_InitEffect()
		{
		eftic = 8;
		}

	override void cl_TickEffect()
		{
		if (!champion.target || !random(0, 1) || !champion.CheckSight(champion.target))
			return;

		if (random(0, 1) && champion.CheckIfInTargetLOS(30, 0, 500))
			{
			champion.A_FaceTarget();
			champion.A_SkelWhoosh();
			champion.A_ChangeVelocity(0, frandompick(-16, 16), 0, CVF_RELATIVE);
			champion.GiveInventory("cl_ShadowSpawner", 1);
			return;
			}

		if (!random(0, 3) && champion.CheckIfInTargetLOS(30, 0, 500))
			{
			champion.A_FaceTarget();
			champion.A_ChangeVelocity(48.0, 0, 2.0, CVF_RELATIVE);
			champion.A_SkelWhoosh();
			champion.GiveInventory("cl_ShadowSpawner", 1);
			}
		}
	}
