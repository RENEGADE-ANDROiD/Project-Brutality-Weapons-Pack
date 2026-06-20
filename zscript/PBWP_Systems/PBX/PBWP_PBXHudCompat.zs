// DEPRECATED — superseded by zscript/PBWP_Systems/PBWP_AddonWeaponHud.zs (shadowed PB_Hud.zs).
// PBWP ↔ PBX-Weapons HUD integration (reference only — not compiled; see ZSCRIPT.zc).
// UZDoom 4.14 compiles each pk3 ZSCRIPT as its own unit; PBX_Hud cannot be extended from PBWP.
// Merge PBWP weapon cases into PBX PBXWeapons_Hud.zs manually, or wait for shared-TU support.
extend class PBX_Hud
{
	override void weaponAdjustments()
	{
		Super.weaponAdjustments();
		if (!pbWeap || (PBXWeapons_hudsetting_filter & DisablePBX_WeaponHud))
			return;

		vector2 adjustPos = (0, 0);
		double adjustScale = 1.0;

		switch (pbWeap.GetClassName())
		{
			case 'IN_Beretta':
				adjustPos = pbWeap.akimboMode ? (-8, -10) : (-10, 12);
				adjustScale = 0.85;
				break;
			case 'W_SMG':
				adjustPos = pbWeap.akimboMode ? (-6, -8) : (-8, 14);
				adjustScale = 0.75;
				break;
			case 'TechBlaster':
				adjustPos = (-12, 16);
				adjustScale = 1.15;
				break;
			case 'UZISMG':
				adjustPos = (-6, 12);
				adjustScale = 0.8;
				break;
			case 'PB_M41A':
				adjustPos = (-8, 14);
				adjustScale = 0.9;
				break;
			case 'PBX_Prosurv_Ballista':
				adjustPos = (-10, 10);
				adjustScale = 0.85;
				break;
			case 'NemesisLMG':
				adjustPos = (-5, 18);
				adjustScale = 0.7;
				break;
			case 'PowerOverwhelming':
				adjustPos = (-8, 12);
				adjustScale = 0.85;
				break;
			case 'LoRCalamityBlade':
				adjustPos = (-15, 20);
				adjustScale = 0.65;
				break;
			case 'PB_CalamityBlade':
				adjustPos = (-12, 18);
				adjustScale = 0.75;
				break;
			default:
				return;
		}

		pbx_weapon_pos += adjustPos;
		pbx_weapon_truescale *= adjustScale;
	}

	override void DrawPBXWeaponAuto()
	{
		if (PBXWeapons_hudsetting_filter & DisablePBX_WeaponHud)
			return;
		if (!pbWeap)
			return;

		static const string exceptionWeapons[] =
		{
			"PB_Pistol", "PB_SMG", "PB_Revolver", "PB_Deagle",
			"PB_Shotgun", "PB_Autoshotgun", "PB_QuadSG", "PB_SSG",
			"PB_Carbine", "PB_DMR",
			"PB_Minigun",
			"PB_M1Plasma", "PB_M2Plasma",
			"PB_Flamethrower",
			"PBX_MastermindChaingun"
		};

		string weaponClass = pbWeap.GetClassName();
		for (int i = 0; i < exceptionWeapons.Size(); i++)
		{
			if (weaponClass == exceptionWeapons[i])
				return;
		}

		TextureID iconID = pbWeap.AltHudIcon.IsValid() ? pbWeap.AltHudIcon : pbWeap.Icon;
		if (!iconID.IsValid() && pbWeap.SpawnState && pbWeap.SpawnState.Sprite != 0)
			iconID = pbWeap.SpawnState.GetSpriteTexture(0);

		pbx_image = TexMan.GetName(iconID);

		if (iconID.IsValid())
			PBX_DrawImage();
	}
}
