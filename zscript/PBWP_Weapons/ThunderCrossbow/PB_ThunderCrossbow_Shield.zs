// Orbiting flat electric shield panels for Thunder Crossbow alt-fire hold.

class PB_ThunderCrossbowShieldPanel : Actor
{
	int segIndex;
	int segCount;

	default
	{
		+NOINTERACTION;
		+NOGRAVITY;
		+FORCEXYBILLBOARD;
		RenderStyle "Add";
		Alpha 0.55;
		XScale 0.22;
		YScale 0.07;
	}

	states
	{
	Spawn:
		STFL A 1 Bright A_SetScale(Scale.X, Scale.Y);
		Loop;
	}
}

class PB_ThunderCrossbowShieldRing : Actor
{
	int orbitAngle;
	int segCount;
	int fxTic;
	Array<Actor> panels;

	default
	{
		+NOINTERACTION;
		+NOGRAVITY;
	}

	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		segCount = 10;
		orbitAngle = random(0, 359);

		for (int i = 0; i < segCount; i++)
		{
			let p = PB_ThunderCrossbowShieldPanel(Actor.Spawn("PB_ThunderCrossbowShieldPanel", Pos));
			if (!p)
				continue;
			p.segIndex = i;
			p.segCount = segCount;
			p.target = self;
			panels.Push(p);
		}
	}

	void UpdatePanelOrbit(PB_ThunderCrossbowShieldPanel panel)
	{
		if (!panel || !master)
			return;

		double step = 360.0 / segCount;
		double a = orbitAngle + panel.segIndex * step;
		double rad = 44.0;
		double z = master.pos.z + master.height * 0.42;
		panel.SetOrigin((master.pos.x + cos(a) * rad, master.pos.y + sin(a) * rad, z), false);
		panel.Angle = a;
	}

	override void Tick()
	{
		Super.Tick();

		if (!master || master.health < 1 || master.CountInv("PB_ThunderCrossbowShieldActive") < 1)
		{
			CleanupAndDestroy();
			return;
		}

		orbitAngle = (orbitAngle + 4) % 360;
		A_Warp(AAPTR_MASTER, flags: WARPF_NOCHECKPOSITION);

		for (int i = 0; i < panels.Size(); i++)
		{
			let pan = PB_ThunderCrossbowShieldPanel(panels[i]);
			if (pan)
				UpdatePanelOrbit(pan);
		}

		if ((fxTic++ & 3) == 0)
		{
			double a0 = orbitAngle;
			double rad = 44.0;
			double z = master.pos.z + master.height * 0.42;
			Actor.Spawn("LightningBeamSpark",
				(master.pos.x + cos(a0) * rad, master.pos.y + sin(a0) * rad, z));
		}
	}

	void DestroyPanels()
	{
		for (int i = 0; i < panels.Size(); i++)
		{
			if (panels[i])
				panels[i].Destroy();
		}
		panels.Clear();
	}

	void CleanupAndDestroy()
	{
		if (master)
			master.A_TakeInventory("PB_ThunderCrossbowShieldRingLive", 1);

		DestroyPanels();
		Destroy();
	}
}
