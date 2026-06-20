// MetalSniperWheel — provided by PBX-Weapons (PBX_MetalSniper)

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
		PB_SpecialWheel_Mode HASG_EXP = new ("PB_SpecialWheel_Mode");
		HASG_EXP.img = "graphics/hasg/SG_Explosive.png";
		HASG_EXP.Alias = "Explosive";
		HASG_EXP.tokentogive = "HASG_SelectExplosive";
		HASG_EXP.scalex = 0.6;
		HASG_EXP.scaley = 0.6;
		
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
		
		spw.push(HASG_EXP);
		spw.push(HASG_DANM);
		spw.push(HASG_WP);
		}
	}
}

Class HarmonyWheel : wheelinfocontainer
{
	override int GetSPCount(actor requester)
	{
		return 4;
	}

	override void GetSpecials(in out array <PB_SpecialWheel_Mode> spw, actor requester)
	{
		if(!spw || !requester)
			return;

		let weap = PB_WeaponBase(requester.player.readyweapon);
		vector2 iconScale = (0.65, 0.65);

		if(weap.akimboMode)
		{
			PB_SpecialWheel_Mode harmony_single = new ("PB_SpecialWheel_Mode");
			harmony_single.img = "graphics/weap/harmonydetached.png";
			harmony_single.Alias = "Single Wield";
			harmony_single.tokentogive = "SelectDual_Berreta";
			harmony_single.scalex = iconScale.x;
			harmony_single.scaley = iconScale.y;
			spw.Push(harmony_single);
		}
		else
		{
			PB_SpecialWheel_Mode harmony_dual = new ("PB_SpecialWheel_Mode");
			harmony_dual.img = "graphics/weap/harmonydual.png";
			harmony_dual.Alias = "Dual Wield";
			harmony_dual.tokentogive = "SelectDual_Berreta";
			harmony_dual.scalex = iconScale.x;
			harmony_dual.scaley = iconScale.y;
			spw.Push(harmony_dual);
		}

		if(requester.FindInventory("Attached_Berreta"))
		{
			PB_SpecialWheel_Mode harmony_detach = new ("PB_SpecialWheel_Mode");
			harmony_detach.img = "graphics/weap/harmonydetached.png";
			harmony_detach.Alias = "Detach Suppressor";
			harmony_detach.tokentogive = "SelectAttach_Berreta";
			harmony_detach.scalex = iconScale.x;
			harmony_detach.scaley = iconScale.y;
			spw.Push(harmony_detach);
		}
		else
		{
			PB_SpecialWheel_Mode harmony_attach = new ("PB_SpecialWheel_Mode");
			harmony_attach.img = "graphics/weap/harmonyattach.png";
			harmony_attach.Alias = "Attach Suppressor";
			harmony_attach.tokentogive = "SelectAttach_Berreta";
			harmony_attach.scalex = iconScale.x;
			harmony_attach.scaley = iconScale.y;
			spw.Push(harmony_attach);
		}

		if(requester.FindInventory("Bursted_Berreta"))
		{
			PB_SpecialWheel_Mode harmony_semi = new ("PB_SpecialWheel_Mode");
			harmony_semi.img = "graphics/weap/harmony_semi.png";
			harmony_semi.Alias = "Semi-Auto";
			harmony_semi.tokentogive = "SelectBursted_Berreta";
			harmony_semi.scalex = iconScale.x;
			harmony_semi.scaley = iconScale.y;
			spw.Push(harmony_semi);
		}
		else
		{
			PB_SpecialWheel_Mode harmony_burst = new ("PB_SpecialWheel_Mode");
			harmony_burst.img = "graphics/weap/harmony_bursted.png";
			harmony_burst.Alias = "Burst Fire";
			harmony_burst.tokentogive = "SelectBursted_Berreta";
			harmony_burst.scalex = iconScale.x;
			harmony_burst.scaley = iconScale.y;
			spw.Push(harmony_burst);
		}
	}
}

