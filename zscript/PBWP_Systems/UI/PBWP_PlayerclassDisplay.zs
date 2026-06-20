// Player-class menu preview (fork of engine ListMenuItemPlayerDisplay with Big Player height fill).
class PBWP_ListMenuItemPlayerDisplay : ListMenuItem
{
	ListMenuDescriptor mOwner;
	TextureID mBackdrop;
	PlayerClass mPlayerClass;
	State mPlayerState;
	int mPlayerTics;
	bool mNoportrait;
	int8 mRotation;
	int8 mMode;
	int8 mTranslate;
	int mSkin;
	int mRandomClass;
	int mRandomTimer;
	int mClassNum;
	Color mBaseColor;
	Color mAddColor;

	enum EPDFlags
	{
		PDF_ROTATION = 0x10001,
		PDF_SKIN = 0x10002,
		PDF_CLASS = 0x10003,
		PDF_MODE = 0x10004,
		PDF_TRANSLATE = 0x10005,
	};

	void Init(ListMenuDescriptor menu, double x, double y, Color c1, Color c2, bool np = false, Name command = 'None')
	{
		Super.Init(x, y, command);
		mOwner = menu;
		mBaseColor = c1;
		mAddColor = c2;
		mBackdrop = TexMan.CheckForTexture("B@CKDROP", TexMan.Type_MiscPatch);
		mPlayerClass = null;
		mPlayerState = null;
		mNoportrait = np;
		mMode = 0;
		mRotation = 0;
		mTranslate = false;
		mSkin = 0;
		mRandomClass = 0;
		mRandomTimer = 0;
		mClassNum = -1;
	}

	static PBWP_ListMenuItemPlayerDisplay ReplaceEngineItem(ListMenuItem item, ListMenuDescriptor menu)
	{
		let old = ListMenuItemPlayerDisplay(item);
		if (!old)
			return null;

		Color c1 = Color(0x20, 0, 0);
		Color c2 = Color(0x80, 0, 0x40);
		if (old.GetX() < 200)
		{
			c1 = Color(0, 0x07, 0);
			c2 = Color(0x40, 0x53, 0x40);
		}

		let neu = new('PBWP_ListMenuItemPlayerDisplay');
		neu.Init(menu, old.GetX(), old.GetY(), c1, c2);
		return neu;
	}

	private void UpdatePlayer(int classnum)
	{
		mPlayerClass = PlayerClasses[classnum];
		mPlayerState = GetDefaultByType(mPlayerClass.Type).SeeState;
		if (mPlayerState == null)
			mPlayerState = GetDefaultByType(mPlayerClass.Type).SpawnState;
		mPlayerTics = mPlayerState != null ? mPlayerState.Tics : -1;
	}

	private void UpdateRandomClass()
	{
		if (--mRandomTimer < 0)
		{
			if (++mRandomClass >= PlayerClasses.Size())
				mRandomClass = 0;
			UpdatePlayer(mRandomClass);
			mPlayerTics = mPlayerState != null ? mPlayerState.Tics : -1;
			mRandomTimer = 6;
			Translation.SetPlayerTranslation(TRANSLATION_Players, MAXPLAYERS, consoleplayer, mPlayerClass);
		}
	}

	void SetPlayerClass(int classnum, bool force = false)
	{
		if (classnum < 0 || classnum >= PlayerClasses.Size())
		{
			if (mClassNum != -1)
			{
				mClassNum = -1;
				mRandomTimer = 0;
				UpdateRandomClass();
			}
		}
		else if (mPlayerClass != PlayerClasses[classnum] || force)
		{
			UpdatePlayer(classnum);
			mClassNum = classnum;
		}
	}

	bool UpdatePlayerClass()
	{
		if (mOwner && mOwner.mSelectedItem >= 0)
		{
			int classnum;
			Name seltype;
			[seltype, classnum] = mOwner.mItems[mOwner.mSelectedItem].GetAction();
			if (seltype != 'Episodemenu')
				return false;
			if (PlayerClasses.Size() == 0)
				return false;
			SetPlayerClass(classnum);
			return true;
		}
		return false;
	}

	override bool SetValue(int i, int value)
	{
		switch (i)
		{
		case PDF_MODE:
			mMode = value;
			return true;
		case PDF_ROTATION:
			mRotation = value;
			return true;
		case PDF_TRANSLATE:
			mTranslate = value;
		case PDF_CLASS:
			SetPlayerClass(value, true);
			break;
		case PDF_SKIN:
			mSkin = value;
			break;
		}
		return false;
	}

	override void Ticker()
	{
		if (mClassNum < 0)
			UpdateRandomClass();

		if (mPlayerState != null && mPlayerState.Tics != -1 && mPlayerState.NextState != null)
		{
			if (--mPlayerTics <= 0)
			{
				mPlayerState = mPlayerState.NextState;
				mPlayerTics = mPlayerState.Tics;
			}
		}
	}

	private double BigPlayerScaleBoost(Class<Actor> playerType, double sx, double sy, Vector2 scale)
	{
		if (playerType != 'PB_BIGPlayerPrawn')
			return 1.0;
		if (scale.X <= 0 || scale.Y <= 0)
			return 1.0;

		double maxH = 79.0 * sy;
		double maxW = 68.0 * sx;
		double hBoost = maxH / scale.Y;
		double wBoost = maxW / scale.X;
		return min(min(hBoost, wBoost), 2.75);
	}

	override void Draw(bool selected, ListMenuDescriptor desc)
	{
		if (mMode == 0 && !UpdatePlayerClass())
			return;

		let playdef = GetDefaultByType((class<PlayerPawn>)(mPlayerClass.Type));
		Name portrait = playdef.Portrait;

		if (portrait != 'None' && !mNoportrait)
		{
			TextureID texid = TexMan.CheckForTexture(portrait, TexMan.Type_MiscPatch);
			DrawTexture(desc, texid, mXpos, mYpos);
		}
		else
		{
			int x, y;
			int w = desc.DisplayWidth();
			int h = desc.DisplayHeight();
			double sx, sy;
			if (w == ListMenuDescriptor.CleanScale)
			{
				x = int(mXpos - 160) * CleanXfac + (screen.GetWidth() >> 1);
				y = int(mYpos - 100) * CleanYfac + (screen.GetHeight() >> 1);
				sx = CleanXfac;
				sy = CleanYfac;
			}
			else
			{
				double fx, fy, fw, fh;
				[fx, fy, fw, fh] = Screen.GetFullscreenRect(w, h, FSMode_ScaleToFit43);
				sx = fw / w;
				sy = fh / h;
				x = int(fx + mXpos * sx);
				y = int(fy + mYpos * sy);
			}

			int r = mBaseColor.r + mAddColor.r;
			int g = mBaseColor.g + mAddColor.g;
			int b = mBaseColor.b + mAddColor.b;
			int m = max(r, g, b);
			r = r * 255 / m;
			g = g * 255 / m;
			b = b * 255 / m;
			Color c = Color(255, r, g, b);

			screen.DrawTexture(mBackdrop, false, x, y - 1,
				DTA_DestWidthF, 72. * sx,
				DTA_DestHeightF, 80. * sy,
				DTA_Color, c,
				DTA_Masked, true);

			Screen.DrawFrame(x, y, int(72 * sx), int(80 * sy - 1));

			if (mPlayerState != null)
			{
				Vector2 scale;
				TextureID sprite;
				bool flip;

				[sprite, flip, scale] = mPlayerState.GetSpriteTexture(mRotation, mSkin, playdef.Scale);

				if (sprite.IsValid())
				{
					let trans = mTranslate ? Translation.MakeID(TRANSLATION_Players, MAXPLAYERS) : 0;
					let tscale = TexMan.GetScaledSize(sprite);
					scale.X *= sx * tscale.X;
					scale.Y *= sy * tscale.Y;

					let boost = BigPlayerScaleBoost(mPlayerClass.Type, sx, sy, scale);
					if (boost > 1.0)
					{
						scale.X *= boost;
						scale.Y *= boost;
					}

					screen.DrawTexture(sprite, false,
						x + 36 * sx, y + 71 * sy,
						DTA_DestWidthF, scale.X, DTA_DestHeightF, scale.Y,
						DTA_TranslationIndex, trans,
						DTA_FlipX, flip);
				}
			}
		}
	}
}

class PBWP_PlayerclassListMenu : PBWP_ListMenu
{
	override void Init(Menu parent, ListMenuDescriptor desc)
	{
		Super.Init(parent, desc);
		if (!desc)
			return;

		for (int i = 0; i < desc.mItems.Size(); i++)
		{
			let replacement = PBWP_ListMenuItemPlayerDisplay.ReplaceEngineItem(desc.mItems[i], desc);
			if (replacement)
				desc.mItems[i] = replacement;
		}
	}
}
