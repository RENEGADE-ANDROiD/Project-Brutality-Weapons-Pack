Class HellPistoler_Wheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		return 3;
	}

	override void GetSpecials(in out array<PB_SpecialWheel_Mode> spw, actor requester)
	{
		if (!spw || !requester)
			return;

		vector2 iconScale = (0.55, 0.55);

		PB_SpecialWheel_Mode hellfire = new ("PB_SpecialWheel_Mode");
		hellfire.img = "ARMZA0";
		hellfire.Alias = "Hell Rounds";
		hellfire.tokentogive = "Select_HP_Hellfire";
		hellfire.scalex = iconScale.x;
		hellfire.scaley = iconScale.y;
		spw.Push(hellfire);

		PB_SpecialWheel_Mode shrink = new ("PB_SpecialWheel_Mode");
		shrink.img = "ARMZA0";
		shrink.Alias = "Shrink Beam";
		shrink.tokentogive = "Select_HP_Shrink";
		shrink.scalex = iconScale.x;
		shrink.scaley = iconScale.y;
		spw.Push(shrink);

		PB_SpecialWheel_Mode rof = new ("PB_SpecialWheel_Mode");
		rof.img = "ARMZA0";
		rof.Alias = "Toggle Fire Rate";
		rof.tokentogive = "Select_HP_ToggleROF";
		rof.scalex = iconScale.x;
		rof.scaley = iconScale.y;
		spw.Push(rof);
	}
}
