//
//	the info object that holds the data for the wheel handler to read
//
Class D2016ShotgunWeaponWheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		int sp = 2;	//total amount of specials available for this weapon
		
		//basically, add one if the requester has the respective item
		if(requester.FindInventory("BurstModeUpgrade"))
			sp++;
		if(requester.FindInventory("ExplosiveModeUpgrade"))
			sp++;
		
		return sp;
	}
	
	override void GetSpecials(in out array <PB_SpecialWheel_Mode> spw, actor requester)
	{
		super.GetSpecials(spw,requester);
		vector2 iconScale = (0.7, 0.7);
		
		PB_SpecialWheel_Mode D2016SG_Normal = new ("PB_SpecialWheel_Mode");
		D2016SG_Normal.img = "graphics/D4SG_NORMAL.png";
		D2016SG_Normal.Alias = "Normal Mode";
		D2016SG_Normal.tokentogive = "SelectD2016Shotgun_Normal";
		D2016SG_Normal.scalex = iconscale.x;
		D2016SG_Normal.scaley = iconscale.y;
		spw.Push(D2016SG_Normal);

		if(requester.FindInventory("BurstModeUpgrade")) 
		{
			PB_SpecialWheel_Mode D2016SG_Burst = new ("PB_SpecialWheel_Mode");
			D2016SG_Burst.img = "graphics/D4SG_BURSTNO.png";
			D2016SG_Burst.Alias = "Burst Mode";
			D2016SG_Burst.tokentogive = "SelectD2016Shotgun_Burst";
			D2016SG_Burst.scalex = iconscale.x;
			D2016SG_Burst.scaley = iconscale.y;
			spw.Push(D2016SG_Burst);
		}

		if(requester.FindInventory("ExplosiveModeUpgrade")) 
		{
			PB_SpecialWheel_Mode D2016SG_Explosive = new ("PB_SpecialWheel_Mode");
			D2016SG_Explosive.img = "graphics/D4SG_EXPLOSIVENO.png";
			D2016SG_Explosive.Alias = "Explosive mode";
			D2016SG_Explosive.tokentogive = "SelectD2016Shotgun_Explosive";
			D2016SG_Explosive.scalex = iconscale.x;
			D2016SG_Explosive.scaley = iconscale.y;
			spw.Push(D2016SG_Explosive);
		}
		
	}
}
