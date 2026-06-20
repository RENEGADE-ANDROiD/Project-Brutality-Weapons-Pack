class PBWP_PDAIconResolver ui
{
	ui static void DrawPreviewIcon(Name weaponClass, int x, int y, int size, double alpha)
	{
		String sn = PBWP_PDAIconLookup.ResolveWeaponPreviewSprite(weaponClass);
		if (sn.Length() < 1)
			return;
		TextureID icon = TexMan.CheckForTexture(sn, TexMan.Type_Any);
		if (!icon.IsValid() || TexMan.GetName(icon) == "BadTexture")
			return;
		Vector2 texSize = TexMan.GetScaledSize(icon);
		if (texSize.X < 1 || texSize.Y < 1)
			return;
		double sc = min(double(size) / texSize.X, double(size) / texSize.Y);
		double cx = double(x) + double(size) * 0.5;
		double cy = double(y) + double(size) * 0.5;
		Screen.DrawTexture(icon, false, cx, cy,
			DTA_DestWidthF, texSize.X * sc, DTA_DestHeightF, texSize.Y * sc,
			DTA_KeepRatio, true, DTA_Alpha, alpha, DTA_CenterOffset, true);
	}
}
