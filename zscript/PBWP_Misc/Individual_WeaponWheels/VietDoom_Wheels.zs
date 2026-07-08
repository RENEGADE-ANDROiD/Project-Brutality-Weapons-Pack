// VietDoom weapon-special wheels — reuse PB Staging pywheel icons (load before PBWP).

Class PBWP_VietSemiAutoWheel : WheelInfoContainer
{
	override int GetSPCount(actor requester)
	{
		return 2;
	}

	override void GetSpecials(in out array<PB_SpecialWheel_Mode> spw, actor requester)
	{
		if (!spw || !requester)
			return;

		vector2 iconScale = (0.65, 0.65);

		PB_SpecialWheel_Mode fullauto = new ("PB_SpecialWheel_Mode");
		fullauto.img = "graphics/pywheel/Carbine_Auto.png";
		fullauto.Alias = "$PB_WHEEL_FULL";
		fullauto.tokentogive = "SelectViet_FullAuto";
		fullauto.scalex = iconScale.x;
		fullauto.scaley = iconScale.y;
		spw.Push(fullauto);

		PB_SpecialWheel_Mode semi = new ("PB_SpecialWheel_Mode");
		semi.img = "graphics/pywheel/Carbine_Semi.png";
		semi.Alias = "$PB_WHEEL_SEMI";
		semi.tokentogive = "SelectViet_Semi";
		semi.scalex = iconScale.x;
		semi.scaley = iconScale.y;
		spw.Push(semi);
	}
}

// BAR slow/fast ROF — map to Semi/Auto pywheel icons for familiarity.
Class PBWP_VietBARWheel : WheelInfoContainer
{
	override int GetSPCount(actor requester)
	{
		return 2;
	}

	override void GetSpecials(in out array<PB_SpecialWheel_Mode> spw, actor requester)
	{
		if (!spw || !requester)
			return;

		vector2 iconScale = (0.65, 0.65);

		PB_SpecialWheel_Mode fast = new ("PB_SpecialWheel_Mode");
		fast.img = "graphics/pywheel/Carbine_Auto.png";
		fast.Alias = "Fast ROF";
		fast.tokentogive = "SelectViet_BARFast";
		fast.scalex = iconScale.x;
		fast.scaley = iconScale.y;
		spw.Push(fast);

		PB_SpecialWheel_Mode slow = new ("PB_SpecialWheel_Mode");
		slow.img = "graphics/pywheel/Carbine_Semi.png";
		slow.Alias = "Slow ROF";
		slow.tokentogive = "SelectViet_BARSlow";
		slow.scalex = iconScale.x;
		slow.scaley = iconScale.y;
		spw.Push(slow);
	}
}

// M16 / ACR — Semi / Burst / Full Auto (Staging carbine pywheel icons).
Class PBWP_VietBurstWheel : WheelInfoContainer
{
	override int GetSPCount(actor requester)
	{
		return 3;
	}

	override void GetSpecials(in out array<PB_SpecialWheel_Mode> spw, actor requester)
	{
		if (!spw || !requester)
			return;

		vector2 iconScale = (0.65, 0.65);

		PB_SpecialWheel_Mode fullauto = new ("PB_SpecialWheel_Mode");
		fullauto.img = "graphics/pywheel/Carbine_Auto.png";
		fullauto.Alias = "$PB_WHEEL_FULL";
		fullauto.tokentogive = "SelectViet_FullAuto";
		fullauto.scalex = iconScale.x;
		fullauto.scaley = iconScale.y;
		spw.Push(fullauto);

		PB_SpecialWheel_Mode burst = new ("PB_SpecialWheel_Mode");
		burst.img = "graphics/pywheel/Carbine_Burst.png";
		burst.Alias = "$PB_WHEEL_BURST";
		burst.tokentogive = "SelectViet_Burst";
		burst.scalex = iconScale.x;
		burst.scaley = iconScale.y;
		spw.Push(burst);

		PB_SpecialWheel_Mode semi = new ("PB_SpecialWheel_Mode");
		semi.img = "graphics/pywheel/Carbine_Semi.png";
		semi.Alias = "$PB_WHEEL_SEMI";
		semi.tokentogive = "SelectViet_Semi";
		semi.scalex = iconScale.x;
		semi.scaley = iconScale.y;
		spw.Push(semi);
	}
}

Class PBWP_VietIthacaWheel : WheelInfoContainer
{
	override int GetSPCount(actor requester)
	{
		return 2;
	}

	override void GetSpecials(in out array<PB_SpecialWheel_Mode> spw, actor requester)
	{
		if (!spw || !requester)
			return;

		vector2 iconScale = (0.7, 0.7);

		PB_SpecialWheel_Mode buck = new ("PB_SpecialWheel_Mode");
		buck.img = "graphics/pywheel/SG_Buck.png";
		buck.Alias = "$PB_SG_WHEEL_BUCKSHOT";
		buck.tokentogive = "SelectViet_IthacaBuck";
		buck.scalex = iconScale.x;
		buck.scaley = iconScale.y;
		spw.Push(buck);

		PB_SpecialWheel_Mode db = new ("PB_SpecialWheel_Mode");
		db.img = "graphics/pywheel/SG_DB.png";
		db.Alias = "$PB_SG_WHEEL_DBREATH";
		db.tokentogive = "SelectViet_IthacaDragon";
		db.scalex = iconScale.x;
		db.scaley = iconScale.y;
		spw.Push(db);
	}
}
