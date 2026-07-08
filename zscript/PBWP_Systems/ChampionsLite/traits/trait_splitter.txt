class cl_SplitterController : cl_BaseController
	{
	int projectiles;
	int hitPause;
	int tiers;

	override color GetParticleColour()
		{
		static const color Colours[] = { "5959ff", "8080ff", "b3b3ff", "ffffff" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_SplitterToken");
		}

	override void cl_InitEffect()
		{
		eftic = 20;
		projectiles = max(4, min(16, int((champion.radius * 0.33) * 2)));
		tiers = min(4, int(max(1, champion.Height / 32)));
		if (champion.bBOSS)
			tiers = min(4, int(tiers * 1.5));
		}

	override void cl_TickEffect()
		{
		if (hitPause)
			hitPause--;
		}

	override void cl_DeathEffect()
		{
		if (!champion || projectiles < 1)
			return;

		double step = 360.0 / double(projectiles);
		for (int j = 0; j < tiers; j++)
			{
			for (int i = 0; i < projectiles; i++)
				{
				double ang = ((step * 0.5) * j) + (i * step);
				champion.A_SpawnProjectile("cl_Fireball", spawnHeight: random(-4, 4) + (24 + (j * 24)),
					angle: ang, flags: CMF_AIMDIRECTION, pitch: -6.125);
				}
			}
		}

	override void cl_HitEffect()
		{
		if (random(0, 4) || hitPause || projectiles < 1)
			return;
		hitPause = random(1, 4);
		int proj2 = max(1, int(projectiles * 0.25));
		double step = 360.0 / double(proj2);
		for (int i = 0; i < proj2; i++)
			champion.A_SpawnProjectile("cl_Fireball", angle: i * step, flags: CMF_AIMDIRECTION, pitch: -6.125);
		}
	}
