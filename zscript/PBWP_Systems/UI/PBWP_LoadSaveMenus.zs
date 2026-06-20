class PBWP_LoadMenu : LoadMenu
{
	override void Init(Menu parent, ListMenuDescriptor desc)
	{
		Super.Init(parent, desc);
		mMouseCapture = true;
		SetMouseCapture(true);
	}
}

class PBWP_SaveMenu : SaveMenu
{
	override void Init(Menu parent, ListMenuDescriptor desc)
	{
		Super.Init(parent, desc);
		mMouseCapture = true;
		SetMouseCapture(true);
	}
}
