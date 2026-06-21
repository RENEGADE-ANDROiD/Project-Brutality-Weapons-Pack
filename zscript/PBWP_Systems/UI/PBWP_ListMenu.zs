// List menus: mouse capture for PBWP menu subclasses.
class PBWP_ListMenu : ListMenu
{
	override void Init(Menu parent, ListMenuDescriptor desc)
	{
		Super.Init(parent, desc);
		DontDim = true;
		DontBlur = false;
		mMouseCapture = true;
		SetMouseCapture(true);
	}
}

// Main menu only — logo via ZScript (not MENUDEF StaticPatch; avoids Size Clean black bar).
class PBWP_MainMenuListMenu : PBWP_ListMenu
{
	TextureID pbLogo;

	override void Init(Menu parent, ListMenuDescriptor desc)
	{
		Super.Init(parent, desc);
		pbLogo = TexMan.CheckForTexture("M_DOOMPB", TexMan.Type_Any);
		if (!pbLogo.isValid())
			pbLogo = TexMan.CheckForTexture("HIRES/M_DOOMPB.png", TexMan.Type_Any);
	}

	override void Drawer()
	{
		if (pbLogo.isValid())
		{
			Screen.DrawTexture(pbLogo, true,
				Screen.GetWidth() / 2, 122,
				DTA_CleanNoMove, true,
				DTA_DestWidth, int(300 * 2.61),
				DTA_DestHeight, int(200 * 2.61),
				DTA_KeepRatio, true,
				DTA_CenterOffset, true);
		}
		Super.Drawer();
	}
}
