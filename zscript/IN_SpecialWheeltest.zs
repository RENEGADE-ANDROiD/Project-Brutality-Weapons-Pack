Class MetalSniperWheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		return 2;
	}
	
	override void GetSpecials(in out array <PB_SpecialWheel_Mode> spw, actor requester)
	{
		super.GetSpecials(spw,requester);
		
		PB_SpecialWheel_Mode MS_AimMode = new ("PB_SpecialWheel_Mode");
		MS_AimMode.img = "graphics/weap/ADSAlt.png";
		MS_AimMode.Alias = "Aim Secondary";
		MS_AimMode.tokentogive = "MS_Select_AimMode";
		MS_AimMode.scalex = 0.6;
		MS_AimMode.scaley = 0.6;
		spw.push(MS_AimMode);
		
		PB_SpecialWheel_Mode MS_GrenMode = new ("PB_SpecialWheel_Mode");
		MS_GrenMode.img = "graphics/weap/GrenadeAlt.png";
		MS_GrenMode.Alias = "Grenade Secondary";
		MS_GrenMode.tokentogive = "MS_Select_GrenMode";
		MS_GrenMode.scalex = 0.6;
		MS_GrenMode.scaley = 0.6;
		spw.push(MS_GrenMode);
		
		
	}
}


//in Progress

Class BlackRemintongWheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		return 3;
	}
	
	override void GetSpecials(in out array <PB_SpecialWheel_Mode> spw, actor requester)
	{
		super.GetSpecials(spw,requester);
		
		if(requester.FindInventory("DragonBreathUpgrade")) 
		{
			PB_SpecialWheel_Mode BSG_DRBT = new ("PB_SpecialWheel_Mode");
			BSG_DRBT.img = "graphics/hasg/SG_DB.png";
			BSG_DRBT.Alias = "Dragon's Breath";
			BSG_DRBT.tokentogive = "BSG_SelectDRBT";
			BSG_DRBT.scalex = 0.6;
			BSG_DRBT.scaley = 0.6;
			
			spw.Push(BSG_DRBT);
		}
		else 
		{
			PB_SpecialWheel_Mode BSG_NO = new ("PB_SpecialWheel_Mode");
			BSG_NO.img = "graphics/hasg/SG_NO.png";
			BSG_NO.Alias = "Unavailable";
			BSG_NO.tokentogive = "BSG_SelectNO";
			BSG_NO.scalex = 0.6;
			BSG_NO.scaley = 0.6;
			
			spw.Push(BSG_NO);
		}
		
		PB_SpecialWheel_Mode BSG_Slug = new ("PB_SpecialWheel_Mode");
		BSG_Slug.img = "graphics/hasg/SG_Slug.png";
		BSG_Slug.Alias = "Slug";
		BSG_Slug.tokentogive = "BSG_SelectSlug";
		BSG_Slug.scalex = 0.6;
		BSG_Slug.scaley = 0.6;
		
		PB_SpecialWheel_Mode BSG_Buck = new ("PB_SpecialWheel_Mode");
		BSG_Buck.img = "graphics/hasg/SG_Buck.png";
		BSG_Buck.Alias = "Buckshot";
		BSG_Buck.tokentogive = "BSG_SelectBuck";
		BSG_Buck.scalex = 0.6;
		BSG_Buck.scaley = 0.6;
		
		spw.Push(BSG_Slug);
		spw.Push(BSG_Buck);
		
	}
}
		

Class HASGWheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		if(requester.FindInventory("ASGDrum"))
			return 7;
		return 4;
	}

	override void GetSpecials(in out array <PB_SpecialWheel_Mode> spw, actor requester)
	{
		super.GetSpecials(spw,requester);
		
		if(requester.FindInventory("DragonBreathUpgrade")) 
		{
			PB_SpecialWheel_Mode HASG_DRBT = new ("PB_SpecialWheel_Mode");
			HASG_DRBT.img = "graphics/hasg/SG_DB.png";
			HASG_DRBT.Alias = "Dragon's Breath";
			HASG_DRBT.tokentogive = "HASG_SelectDRBT";
			HASG_DRBT.scalex = 0.6;
			HASG_DRBT.scaley = 0.6;
			
			spw.Push(HASG_DRBT);
		}
		else 
		{
			PB_SpecialWheel_Mode HASG_NO = new ("PB_SpecialWheel_Mode");
			HASG_NO.img = "graphics/hasg/SG_NO.png";
			HASG_NO.Alias = "Unavailable";
			HASG_NO.tokentogive = "HASG_SelectNO";
			HASG_NO.scalex = 0.6;
			HASG_NO.scaley = 0.6;
			
			spw.Push(HASG_NO);
		}
		
		PB_SpecialWheel_Mode HASG_Slug = new ("PB_SpecialWheel_Mode");
		HASG_Slug.img = "graphics/hasg/SG_Slug.png";
		HASG_Slug.Alias = "Slug";
		HASG_Slug.tokentogive = "HASG_SelectSlug";
		HASG_Slug.scalex = 0.6;
		HASG_Slug.scaley = 0.6;
		
		PB_SpecialWheel_Mode HASG_Flech = new ("PB_SpecialWheel_Mode");
		HASG_Flech.img = "graphics/hasg/SG_Flechette.png";
		HASG_Flech.Alias = "Flechette";
		HASG_Flech.tokentogive = "HASG_SelectFlech";
		HASG_Flech.scalex = 0.6;
		HASG_Flech.scaley = 0.6;
		
		PB_SpecialWheel_Mode HASG_Buck = new ("PB_SpecialWheel_Mode");
		HASG_Buck.img = "graphics/hasg/SG_Buck.png";
		HASG_Buck.Alias = "Buckshot";
		HASG_Buck.tokentogive = "HASG_SelectBuck";
		HASG_Buck.scalex = 0.6;
		HASG_Buck.scaley = 0.6;
		
		spw.push(HASG_Buck);
		spw.push(HASG_Slug);
		spw.push(HASG_Flech);
		
		if(requester.FindInventory("ASGDrum")) 
		{
//		PB_SpecialWheel_Mode HASG_EXP = new ("PB_SpecialWheel_Mode");
//		HASG_EXP.img = "graphics/hasg/SG_Explosive.png";
//		HASG_EXP.Alias = "Explosive";
//		HASG_EXP.tokentogive = "HASG_SelectExplosive";
//		HASG_EXP.scalex = 0.6;
//		HASG_EXP.scaley = 0.6;
		
		PB_SpecialWheel_Mode HASG_DANM = new ("PB_SpecialWheel_Mode");
		HASG_DANM.img = "graphics/hasg/SG_Danmaku.png";
		HASG_DANM.Alias = "Danmaku";
		HASG_DANM.tokentogive = "HASG_SelectDanmaku";
		HASG_DANM.scalex = 0.6;
		HASG_DANM.scaley = 0.6;
		
		PB_SpecialWheel_Mode HASG_WP = new ("PB_SpecialWheel_Mode");
		HASG_WP.img = "graphics/hasg/SG_WPhosphorus.png";
		HASG_WP.Alias = "White Phosphorus";
		HASG_WP.tokentogive = "HASG_SelectWPhos";
		HASG_WP.scalex = 0.6;
		HASG_WP.scaley = 0.6;
		
//		spw.push(HASG_EXP);
		spw.push(HASG_DANM);
		spw.push(HASG_WP);
		}
	}
}

