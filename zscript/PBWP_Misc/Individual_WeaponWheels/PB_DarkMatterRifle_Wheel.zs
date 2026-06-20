Class PB_DarkMatterRifleWheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		return 2;
	}

	override void GetSpecials(in out array <PB_SpecialWheel_Mode> spw, actor requester)
	{
		if (!spw || !requester)
			return;

		vector2 iconScale = (0.75, 0.75);

		PB_SpecialWheel_Mode dmr_super = new ("PB_SpecialWheel_Mode");
		dmr_super.img = "graphics/pywheel/Minigun_2.png";
		dmr_super.Alias = "Alt: Super Plasma Ball";
		dmr_super.tokentogive = "Select_PB_DMR_SuperBall";
		dmr_super.scalex = iconScale.x;
		dmr_super.scaley = iconScale.y;
		spw.Push(dmr_super);

		PB_SpecialWheel_Mode dmr_grav = new ("PB_SpecialWheel_Mode");
		dmr_grav.img = "graphics/pywheel/rocket_standard.png";
		dmr_grav.Alias = "Alt: Gravity Singularity";
		dmr_grav.tokentogive = "Select_PB_DMR_GravityBomb";
		dmr_grav.scalex = iconScale.x;
		dmr_grav.scaley = iconScale.y;
		spw.Push(dmr_grav);
	}
}
