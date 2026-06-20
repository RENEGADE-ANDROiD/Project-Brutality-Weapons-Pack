// Helpers for suppressing default pickup feedback (no engine class extends — UZDoom 4.14 TU limit).
// World-touch silence is handled via +INVENTORY.QUIET on actors with empty PickupMessage.

class PBWP_PickupMessageUtil
{
	static bool IsSilentMsg(Inventory item)
	{
		if (!item)
			return true;
		if (item.bQuiet)
			return true;
		if (item.PickupMsg.Length() == 0)
			return true;
		if (item.PickupMsg == " " || item.PickupMsg == "\c")
			return true;
		return false;
	}
}
