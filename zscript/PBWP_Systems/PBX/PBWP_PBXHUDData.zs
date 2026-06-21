// PBX-Weapons HUD service bridge — PB core type + consumer (PB Staging has not shipped PBXHUDData yet).
// Included from shadowed zscript/PB_Hud.zs so PBX's PBXHUDService_* classes can compile against it.

class PBXHUDData ui
{
	bool Handled;
	bool SkipAutoDraw;
	String Image1;
	String Image2;
	String Image3;
	vector2 Offset1;
	vector2 Offset2;
	double Scale1;
	double Scale2;
}

extend class PB_Hud_ZS
{
	clearscope static bool PBX_HasRenderableHudImage(String image)
	{
		return image != "" && image != " ";
	}

	ui PBXHUDData PBX_QueryHUDData(PB_WeaponBase weapon)
	{
		if (!weapon)
			return null;

		ServiceIterator it = ServiceIterator.Find("PBXHUDService");
		Service s;
		while (s = it.Next())
		{
			let obj = s.GetObjectUI("PBX_HUD", "", 0, 0, weapon);
			let data = PBXHUDData(obj);
			if (data && data.Handled)
				return data;
		}
		return null;
	}

	// UZDoom 4.14 JIT: out vector2 triggers REGT_ADDROF VM abort — use scalar outs.
	clearscope static int PBX_HudCVarInt(string name, PlayerInfo p, int defaultVal = 0)
	{
		let cv = p ? CVar.GetCVar(name, p) : null;
		if (cv)
			return cv.GetInt();
		cv = CVar.FindCVar(name);
		return cv ? cv.GetInt() : defaultVal;
	}

	clearscope static double PBX_HudCVarFloat(string name, PlayerInfo p, double defaultVal = 0.0)
	{
		let cv = p ? CVar.GetCVar(name, p) : null;
		if (cv)
			return cv.GetFloat();
		cv = CVar.FindCVar(name);
		return cv ? cv.GetFloat() : defaultVal;
	}

	void PBX_GatherWeaponHudCVars(out double weaponPosX, out double weaponPosY,
		out double modePosX, out double modePosY,
		out double weaponScale, out double modeScale, out double weaponAlpha, out double modeAlpha)
	{
		int posX = 0;
		int posY = 0;
		double scale = 1.0;
		double alpha = 1.0;

		let wx = CVar.FindCVar("pbxweapons_Weaponhud_x");
		if (wx)
		{
			posX = PBX_HudCVarInt("pbxweapons_Weaponhud_x", CPlayer, 0);
			posY = PBX_HudCVarInt("pbxweapons_Weaponhud_y", CPlayer, 0);
			scale = PBX_HudCVarFloat("pbxweapons_Weaponhud_scale", CPlayer, 1.0);
			alpha = PBX_HudCVarFloat("pbxweapons_Weaponhud_alpha", CPlayer, 1.0);
		}
		else
		{
			posX = PBX_HudCVarInt("pbwp_weaponhud_x", CPlayer, 0);
			posY = PBX_HudCVarInt("pbwp_weaponhud_y", CPlayer, 0);
			scale = PBX_HudCVarFloat("pbwp_weaponhud_scale", CPlayer, 1.0);
			alpha = PBX_HudCVarFloat("pbwp_weaponhud_alpha", CPlayer, 1.0);
		}

		weaponPosX = posX;
		weaponPosY = posY;
		weaponScale = scale;
		weaponAlpha = alpha;

		int modeX = posX;
		int modeY = posY;
		double modeSc = scale;
		double modeAl = alpha;

		let mx = CVar.FindCVar("pbxweapons_WeaponModehud_x");
		if (mx)
		{
			modeX = PBX_HudCVarInt("pbxweapons_WeaponModehud_x", CPlayer, posX);
			modeY = PBX_HudCVarInt("pbxweapons_WeaponModehud_y", CPlayer, posY);
			modeSc = PBX_HudCVarFloat("pbxweapons_WeaponModehud_scale", CPlayer, scale);
			modeAl = PBX_HudCVarFloat("pbxweapons_WeaponModehud_alpha", CPlayer, alpha);
		}

		modePosX = modeX;
		modePosY = modeY;
		modeScale = modeSc;
		modeAlpha = modeAl;
	}

	void PBX_DrawServiceHudImage(String image, vector2 pos, double alpha, vector2 scale)
	{
		if (!PBX_HasRenderableHudImage(image))
			return;

		PBHud_DrawImage(image, pos, DI_SCREEN_RIGHT_BOTTOM | DI_ITEM_RIGHT_BOTTOM,
			alpha * playerBoxAlpha, scale: scale);
	}

	void PBX_DrawWeaponHudFromServices()
	{
		if (!CPlayer || !weap || !pbWeap)
			return;

		let pbx = CVar.FindCVar("isPBXLoaded");
		if (!pbx || !pbx.GetBool())
			return;

		if (String.Format("%s", pbWeap.GetClassName()).IndexOf("PBX_") != 0)
			return;

		let data = PBX_QueryHUDData(pbWeap);
		if (!data || !data.Handled)
			return;

		double weaponPosX;
		double weaponPosY;
		double modePosX;
		double modePosY;
		double weaponScale;
		double modeScale;
		double weaponAlpha;
		double modeAlpha;
		PBX_GatherWeaponHudCVars(weaponPosX, weaponPosY, modePosX, modePosY,
			weaponScale, modeScale, weaponAlpha, modeAlpha);
		vector2 weaponPos = (weaponPosX, weaponPosY);
		vector2 modePos = (modePosX, modePosY);

		String img1 = data.Image1;
		if (!data.SkipAutoDraw && !PBX_HasRenderableHudImage(img1))
		{
			TextureID iconID = weap.AltHudIcon.IsValid() ? weap.AltHudIcon : weap.Icon;
			if (!iconID.IsValid() && weap.SpawnState && weap.SpawnState.Sprite != 0)
				iconID = weap.SpawnState.GetSpriteTexture(0);
			if (iconID.IsValid())
			{
				img1 = TexMan.GetName(iconID);
				if (img1 == "TNT1A0")
					img1 = "";
			}
		}

		PBX_DrawServiceHudImage(img1, weaponPos + data.Offset1, weaponAlpha,
			(weaponScale * data.Scale1, weaponScale * data.Scale1));

		PBX_DrawServiceHudImage(data.Image2, modePos + data.Offset2, modeAlpha,
			(modeScale * data.Scale2, modeScale * data.Scale2));
		PBX_DrawServiceHudImage(data.Image3, modePos + data.Offset2 + (0, -10), modeAlpha,
			(modeScale * data.Scale2, modeScale * data.Scale2));
	}
}
