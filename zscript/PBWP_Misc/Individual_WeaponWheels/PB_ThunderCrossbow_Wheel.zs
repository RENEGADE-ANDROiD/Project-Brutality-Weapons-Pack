Class PB_ThunderCrossbowWheel : WheelInfoContainer
{
	override int GetSPCount(Actor requester)
	{
		return 4;
	}

	override void GetSpecials(in out array<PB_SpecialWheel_Mode> spw, Actor requester)
	{
		if (!spw || !requester)
			return;

		vector2 iconScale = (0.55, 0.55);

		PB_SpecialWheel_Mode beam = new ("PB_SpecialWheel_Mode");
		beam.img = "WBOWA0";
		beam.Alias = "Storm Beam";
		beam.tokentogive = "Select_PB_ThunderCrossbow_Beam";
		beam.scalex = iconScale.x;
		beam.scaley = iconScale.y;
		spw.Push(beam);

		PB_SpecialWheel_Mode bolt = new ("PB_SpecialWheel_Mode");
		bolt.img = "WBOWA0";
		bolt.Alias = "Thunder Bolt";
		bolt.tokentogive = "Select_PB_ThunderCrossbow_Bolt";
		bolt.scalex = iconScale.x;
		bolt.scaley = iconScale.y;
		spw.Push(bolt);

		PB_SpecialWheel_Mode shock = new ("PB_SpecialWheel_Mode");
		shock.img = "WBOWA0";
		shock.Alias = "Shockwave";
		shock.tokentogive = "Select_PB_ThunderCrossbow_Shockwave";
		shock.scalex = iconScale.x;
		shock.scaley = iconScale.y;
		spw.Push(shock);

		PB_SpecialWheel_Mode cluster = new ("PB_SpecialWheel_Mode");
		cluster.img = "WBOWA0";
		cluster.Alias = "Cluster";
		cluster.tokentogive = "Select_PB_ThunderCrossbow_Cluster";
		cluster.scalex = iconScale.x;
		cluster.scaley = iconScale.y;
		spw.Push(cluster);
	}
}
