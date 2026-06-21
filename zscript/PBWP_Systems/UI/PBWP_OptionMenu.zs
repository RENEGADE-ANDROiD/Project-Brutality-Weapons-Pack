// Option menus: mouse capture + weapon-pack preset polling.
class PBWP_OptionMenu : OptionMenu
{
	private transient bool packPresetMenu;

	override void Init(Menu parent, OptionMenuDescriptor desc)
	{
		Super.Init(parent, desc);
		mMouseCapture = true;
		SetMouseCapture(true);
		packPresetMenu = desc && desc.mTitle == "Weapon Pack Spawn Settings";
		let poll = PBWP_PackPresetPoll.Get();
		if (packPresetMenu && poll)
			poll.Reset();
	}

	override void Ticker()
	{
		Super.Ticker();
		if (!packPresetMenu)
			return;
		let poll = PBWP_PackPresetPoll.Get();
		if (poll)
			poll.Poll();
	}
}
