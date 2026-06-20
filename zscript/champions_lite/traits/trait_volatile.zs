class cl_VolatileController : cl_BaseController
	{
	double missileofs;

	override color GetParticleColour()
		{
		static const color Colours[] = { "ffffff", "ff9900", "ffad33", "ff5c33", "ff3300" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_VolatileToken");
		}

	override void cl_InitEffect()
		{
		missileofs = champion.Height * 0.5;
		}

	override void cl_DeathEffect()
		{
		let explosion = champion.Spawn("cl_Explosion", (champion.pos.x, champion.pos.y, champion.pos.z + missileofs), 0);
		if (explosion)
			explosion.target = champion.target;
		}
	}
