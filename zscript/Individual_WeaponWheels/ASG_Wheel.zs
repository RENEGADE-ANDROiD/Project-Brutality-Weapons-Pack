Class PB_ASGWheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		return 2;
	}
	
	override void GetSpecials(in out array <PB_SpecialWheel_Mode> spw, actor requester)
	{
		if(!spw || !requester)
			return;
			
		vector2 iconScale = (0.55, 0.55);
		
		
		if(requester.FindInventory("DualWieldingAutoshotguns"))
		{
			PB_SpecialWheel_Mode asg_single = new ("PB_SpecialWheel_Mode");
			asg_single.img = "graphics/ZoomAutoShotgun/ASS2.png";
			asg_single.Alias = "Single Auto Shotgun";
			asg_single.tokentogive = "DualWieldingAutoshotguns";
			asg_single.scalex = iconscale.x;
			asg_single.scaley = iconscale.y;
			
			spw.Push(asg_single);
		}
		else 
		{
			PB_SpecialWheel_Mode asg_dual = new ("PB_SpecialWheel_Mode");
			asg_dual.img = "graphics/ZoomAutoShotgun/ASS3.png";
			asg_dual.Alias = "Akimbo Auto Shotguns";
			asg_dual.tokentogive = "DualWieldingAutoshotguns";
			asg_dual.scalex = iconscale.x;
			asg_dual.scaley = iconscale.y;
			
			spw.Push(asg_dual);
		}
		
		if(requester.FindInventory("ZOOMMode"))
		{
			PB_SpecialWheel_Mode asg_flak = new ("PB_SpecialWheel_Mode");
			asg_flak.img = "graphics/ZoomAutoShotgun/ASS4.png";
			asg_flak.Alias = "Flak Altfire";
			asg_flak.tokentogive = "ZOOMToggle";
			asg_flak.scalex = iconscale.x;
			asg_flak.scaley = iconscale.y;
			
			spw.Push(asg_flak);
		}
		else 
		{
			PB_SpecialWheel_Mode asg_zoom = new ("PB_SpecialWheel_Mode");
			asg_zoom.img = "graphics/ZoomAutoShotgun/ASS1.png";
			asg_zoom.Alias = "Zoom Altfire";
			asg_zoom.tokentogive = "ZOOMToggle";
			asg_zoom.scalex = iconscale.x;
			asg_zoom.scaley = iconscale.y;
			
			spw.Push(asg_zoom);
		}
	}
}
