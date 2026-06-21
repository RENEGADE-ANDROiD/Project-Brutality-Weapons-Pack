Class PB_CryoShotgunWheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		return 5;
	}

	override void GetSpecials(in out array<PB_SpecialWheel_Mode> spw, actor requester)
	{
		if (!spw || !requester)
			return;

		vector2 iconScale = (0.55, 0.55);

		PB_SpecialWheel_Mode buck = new ("PB_SpecialWheel_Mode");
		buck.img = "FZSGA0";
		buck.Alias = "Cryo Buckshot";
		buck.tokentogive = "Select_PB_CryoShotgun_Buck";
		buck.scalex = iconScale.x;
		buck.scaley = iconScale.y;
		spw.Push(buck);

		PB_SpecialWheel_Mode pellet = new ("PB_SpecialWheel_Mode");
		pellet.img = "FZSGA0";
		pellet.Alias = "Cryo Pellets";
		pellet.tokentogive = "Select_PB_CryoShotgun_Pellet";
		pellet.scalex = iconScale.x;
		pellet.scaley = iconScale.y;
		spw.Push(pellet);

		PB_SpecialWheel_Mode orb = new ("PB_SpecialWheel_Mode");
		orb.img = "FZSGA0";
		orb.Alias = "Cryo Orb";
		orb.tokentogive = "Select_PB_CryoShotgun_Orb";
		orb.scalex = iconScale.x;
		orb.scaley = iconScale.y;
		spw.Push(orb);

		PB_SpecialWheel_Mode electric = new ("PB_SpecialWheel_Mode");
		electric.img = "FZSGA0";
		electric.Alias = "Electric Bolt";
		electric.tokentogive = "Select_PB_CryoShotgun_Electric";
		electric.scalex = iconScale.x;
		electric.scaley = iconScale.y;
		spw.Push(electric);

		PB_SpecialWheel_Mode wind = new ("PB_SpecialWheel_Mode");
		wind.img = "FZSGA0";
		wind.Alias = "Cryo Wind";
		wind.tokentogive = "Select_PB_CryoShotgun_Wind";
		wind.scalex = iconScale.x;
		wind.scaley = iconScale.y;
		spw.Push(wind);
	}
}
