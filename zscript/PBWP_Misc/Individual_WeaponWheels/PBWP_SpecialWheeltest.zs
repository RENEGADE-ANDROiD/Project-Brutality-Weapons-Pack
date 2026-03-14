Class Autocannon_Wheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		return 3;
	}
	
	override void GetSpecials(in out array <PB_SpecialWheel_Mode> spw, actor requester)
	{
		super.GetSpecials(spw,requester);
		
		PB_SpecialWheel_Mode Autocannon_HEAT = new ("PB_SpecialWheel_Mode");
		Autocannon_HEAT.img = "SPRITES/WEAPONS/Slot 5/Autocannon/ACNZA0.png";
		Autocannon_HEAT.Alias = "High Explosive Anti-Tank Mode";
		Autocannon_HEAT.tokentogive = "Autocannon_HEAT_Selected";
		Autocannon_HEAT.scalex = 0.6;
		Autocannon_HEAT.scaley = 0.6;
		spw.push(Autocannon_HEAT);
		
		PB_SpecialWheel_Mode Autocannon_HEIAP = new ("PB_SpecialWheel_Mode");
		Autocannon_HEIAP.img = "SPRITES/WEAPONS/Slot 5/Autocannon/ACNZA0.png";
		Autocannon_HEIAP.Alias = "High Explosive Incendiary Armor Pircing Mode";
		Autocannon_HEIAP.tokentogive = "Autocannon_HEIAP_Selected";
		Autocannon_HEIAP.scalex = 0.6;
		Autocannon_HEIAP.scaley = 0.6;
		spw.push(Autocannon_HEIAP);
		
		PB_SpecialWheel_Mode Autocannon_AP = new ("PB_SpecialWheel_Mode");
		Autocannon_AP.img = "SPRITES/WEAPONS/Slot 5/Autocannon/ACNZA0.png";
		Autocannon_AP.Alias = "Armor Piercing Mode";
		Autocannon_AP.tokentogive = "Autocannon_AP_Selected";
		Autocannon_AP.scalex = 0.6;
		Autocannon_AP.scaley = 0.6;
		spw.push(Autocannon_AP);
		
	}
}