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

	// Magnet / forced pickup: suppress engine default "You got a pickup" spam.
	static void PushQuietForPickup(Inventory item, out bool wasQuiet)
	{
		wasQuiet = false;
		if (!item)
			return;
		wasQuiet = item.bQuiet;
		if (IsSilentMsg(item))
			item.bQuiet = true;
	}

	static void PopQuietForPickup(Inventory item, bool wasQuiet)
	{
		if (item)
			item.bQuiet = wasQuiet;
	}
}
