class cl_BulwarkController : cl_BaseController
	{
	override color GetParticleColour()
		{
		static const color Colours[] = { "ff0000", "ff4d4d", "ff9999", "ffffff" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_BulwarkToken");
		}

	override void cl_InitEffect()
		{
		champion.Health *= 2;
		champion.PainChance = int(champion.PainChance * 0.75);
		}
	}
