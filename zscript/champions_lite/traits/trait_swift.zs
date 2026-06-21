class cl_SwiftController : cl_BaseController
	{
	double factor;

	override color GetParticleColour()
		{
		static const color Colours[] = { "ffffff", "ffffb3", "ffff4d", "e6e600" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_SwiftToken");
		}

	override void cl_InitEffect()
		{
		eftic = 1;
		factor = 1.5;
		}

	override void cl_TickEffect()
		{
		if (!champion || champion.health < 1 || champion.tics <= 0)
			return;

		double speed = factor * cl_GetSpeedFactor();
		if (prevState != champion.curState)
			champion.A_SetTics(int(champion.tics / speed));
		prevState = champion.curState;
		}
	}
