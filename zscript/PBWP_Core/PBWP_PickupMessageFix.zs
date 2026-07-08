// Helpers for suppressing default pickup feedback (no engine class extends — UZDoom 4.14 TU limit).
// World-touch silence: +INVENTORY.QUIET on actors, or PBWP_PickupSpamGuardHandler for empty PickupMessage.

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
		// Engine default when PickupMessage is unset in DECORATE.
		if (item.PickupMsg == "$TXT_DEFAULTPICKUPMSG")
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

// Preempt Touch() spam when empty-message pickups overlap the player (magnet rejects, already owned, etc.).
class PBWP_PickupSpamGuardHandler : StaticEventHandler
{
	override void WorldTick()
	{
		if (level.maptime % 2 != 0)
			return;

		for (int pn = 0; pn < MAXPLAYERS; pn++)
		{
			if (!playeringame[pn] || !players[pn].mo)
				continue;
			let plr = players[pn].mo;
			BlockThingsIterator it = BlockThingsIterator.Create(plr, plr.radius + 8);
			while (it.Next())
			{
				let item = Inventory(it.thing);
				if (!item || item.owner)
					continue;
				if (!PBWP_PickupMessageUtil.IsSilentMsg(item))
					continue;
				if (plr.Distance3D(item) <= plr.radius + item.radius + 2)
					item.bQuiet = true;
			}
		}
	}
}
