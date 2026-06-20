class cl_BruteController : cl_BaseController
	{
	override color GetParticleColour()
		{
		static const color Colours[] = { "000000", "4d4d4d", "999999", "cccccc" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_BruteToken");
		}

	override void cl_InitEffect()
		{
		champion.DamageMultiply *= 2.0;
		champion.DamageFactor *= 2.0;
		}
	}
