// PBWP addon weapon pickup icon + HUD tweaks (replaces PBWP_PBXHudCompat / PBX_DrawImage path).
extend class PB_Hud_ZS
{
	clearscope static bool PBWP_IsStagingBaseWeapon(string cn)
	{
		return cn == "PB_Pistol"
			|| cn == "PB_SMG"
			|| cn == "PB_Revolver"
			|| cn == "PB_Deagle"
			|| cn == "PB_Shotgun"
			|| cn == "PB_AutoShotgun"
			|| cn == "PB_QuadSG"
			|| cn == "PB_SSG"
			|| cn == "PB_Carbine"
			|| cn == "PB_DMR"
			|| cn == "PB_Minigun"
			|| cn == "PB_M1Plasma"
			|| cn == "PB_M2Plasma"
			|| cn == "PB_Flamethrower"
			|| cn == "PB_ChexRifle"
			|| cn == "PB_LMG"
			|| cn == "PB_SuperGL"
			|| cn == "PB_RocketLauncher"
			|| cn == "PB_Railgun"
			|| cn == "PB_BFG9000"
			|| cn == "PB_Unmaker"
			|| cn == "PB_DemonTech"
			|| cn == "PB_MG42"
			|| cn == "PB_Fists"
			|| cn == "PB_Axe"
			|| cn == "PB_Chainsaw";
	}

	clearscope static bool PBWP_ShouldDrawAddonWeaponIcon(string cn)
	{
		if (cn == "" || PBWP_IsStagingBaseWeapon(cn))
			return false;

		let pbx = CVar.FindCVar("isPBXLoaded");
		if (pbx && pbx.GetBool() && cn.Left(4) == "PBX_")
			return false;

		return true;
	}

	// UZDoom 4.14 JIT: out vector2 triggers REGT_ADDROF VM abort — use scalar outs.
	clearscope static void PBWP_GetAddonWeaponHudAdjustments(string cn, bool akimbo, out double adjustX, out double adjustY, out double adjustScale)
	{
		adjustX = 0;
		adjustY = 0;
		adjustScale = 1.0;

		if (cn == "IN_Beretta")
		{
			adjustX = akimbo ? -8 : -10;
			adjustY = akimbo ? -10 : 12;
			adjustScale = 0.85;
		}
		else if (cn == "W_SMG")
		{
			adjustX = akimbo ? -6 : -8;
			adjustY = akimbo ? -8 : 14;
			adjustScale = 0.75;
		}
		else if (cn == "TechBlaster")
		{
			adjustX = -12;
			adjustY = 16;
			adjustScale = 1.15;
		}
		else if (cn == "UZISMG")
		{
			adjustX = -6;
			adjustY = 12;
			adjustScale = 0.8;
		}
		else if (cn == "PB_M41A" || cn == "M41A")
		{
			adjustX = -8;
			adjustY = 14;
			adjustScale = 0.9;
		}
		else if (cn == "PBX_Prosurv_Ballista")
		{
			adjustX = -10;
			adjustY = 10;
			adjustScale = 0.85;
		}
		else if (cn == "NemesisLMG")
		{
			adjustX = -5;
			adjustY = 18;
			adjustScale = 0.7;
		}
		else if (cn == "PowerOverwhelming")
		{
			adjustX = -8;
			adjustY = 12;
			adjustScale = 0.85;
		}
		else if (cn == "BFG9500")
		{
			adjustX = -10;
			adjustY = 10;
			adjustScale = 0.85;
		}
		else if (cn == "PBWP_Warbringer")
		{
			adjustX = -8;
			adjustY = 14;
			adjustScale = 0.85;
		}
		else if (cn == "PBWP_Nightfall")
		{
			adjustX = -6;
			adjustY = 12;
			adjustScale = 0.75;
		}
		else if (cn == "PBWP_Intervention" || cn == "PBWP_Legionnaire")
		{
			adjustX = -8;
			adjustY = 14;
			adjustScale = 0.8;
		}
		else if (cn == "PBWP_Caduceus" || cn == "PBWP_Dispatcher")
		{
			adjustX = -10;
			adjustY = 12;
			adjustScale = 0.85;
		}
		else if (cn == "PBWP_AmnesiaProtonPhaser")
		{
			adjustX = -8;
			adjustY = 10;
			adjustScale = 0.8;
		}
		else if (cn == "PBWP_Liquidation" || cn == "PBWP_Deracinator")
		{
			adjustX = -8;
			adjustY = 12;
			adjustScale = 0.8;
		}
		else if (cn == "PBWP_Dismantler" || cn == "PBWP_CinerealOrdnance")
		{
			adjustX = -10;
			adjustY = 10;
			adjustScale = 0.85;
		}
		else if (cn == "PBWP_SiriusCrisis")
		{
			adjustX = -8;
			adjustY = 8;
			adjustScale = 0.75;
		}
	}

	void PBWP_DrawAddonWeaponIcon()
	{
		if (!weap || !pbWeap)
			return;

		string cn = weap.GetClassName();
		if (!PBWP_ShouldDrawAddonWeaponIcon(cn))
			return;

		TextureID iconID = weap.AltHudIcon.IsValid() ? weap.AltHudIcon : weap.Icon;
		if (!iconID.IsValid() && weap.SpawnState && weap.SpawnState.Sprite != 0)
			iconID = weap.SpawnState.GetSpriteTexture(0);
		if (!iconID.IsValid())
			return;

		String texName = TexMan.GetName(iconID);
		if (texName == "TNT1A0")
			return;

		int posX = CVar.GetCVar("pbwp_weaponhud_x", CPlayer).GetInt();
		int posY = CVar.GetCVar("pbwp_weaponhud_y", CPlayer).GetInt();
		double hudScale = CVar.GetCVar("pbwp_weaponhud_scale", CPlayer).GetFloat();
		double hudAlpha = CVar.GetCVar("pbwp_weaponhud_alpha", CPlayer).GetFloat();

		double adjustX;
		double adjustY;
		double adjustScale;
		PBWP_GetAddonWeaponHudAdjustments(cn, pbWeap.akimboMode, adjustX, adjustY, adjustScale);

		vector2 drawPos = (posX + adjustX, posY + adjustY);
		vector2 drawScale = (hudScale * adjustScale, hudScale * adjustScale);

		PBHud_DrawImage(texName, drawPos, DI_SCREEN_RIGHT_BOTTOM | DI_ITEM_RIGHT_BOTTOM,
			hudAlpha * playerBoxAlpha, scale: drawScale);
	}
}
