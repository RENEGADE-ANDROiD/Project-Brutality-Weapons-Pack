class PBWP_WeaponDedupeUtil
{
	// Global Next/Prev scroll — higher = later. Mosin ends slot 4 at 1300; slot 5 chain 1301–1311.
	play static void PatchWeaponSelectionOrders(Actor mo)
	{
		if (!mo)
			return;

		for (Inventory item = mo.Inv; item; item = item.Inv)
		{
			let wpn = Weapon(item);
			if (!wpn)
				continue;

			switch (wpn.GetClassName())
			{
			// Slot 4 — VietDoom rifles
			case 'M16':              wpn.SelectionOrder = 1295; break;
			case 'AK':               wpn.SelectionOrder = 1296; break;
			case 'SKS':              wpn.SelectionOrder = 1297; break;
			case 'M14':              wpn.SelectionOrder = 1298; break;
			case 'XM21':             wpn.SelectionOrder = 1299; break;
			case 'Mosin':            wpn.SelectionOrder = 1300; break;
			// Slot 5 — after Mosin
			case 'PB_MG42':          wpn.SelectionOrder = 1301; break;
			case 'PBWP_Nightfall':   wpn.SelectionOrder = 1302; break;
			case 'Tactical_Nail_Gun': wpn.SelectionOrder = 1303; break;
			case 'INMiniGun':        wpn.SelectionOrder = 1304; break;
			case 'PB_Nailgun':       wpn.SelectionOrder = 1305; break;
			case 'PB_HYDRA':         wpn.SelectionOrder = 1306; break;
			case 'M60':              wpn.SelectionOrder = 1307; break;
			case 'BAR':              wpn.SelectionOrder = 1308; break;
			case 'RPD':              wpn.SelectionOrder = 1309; break;
			case 'Stoner':           wpn.SelectionOrder = 1310; break;
			case 'PB_Minigun':       wpn.SelectionOrder = 1311; break;
			// PBX — not part of PBWP; keep out of the Mosin→MG42 gap (PBX loads after PBWP).
			case 'PBX_Excavator':    wpn.SelectionOrder = 8500; break;
			}
		}
	}

	play static void StripDisabledWeapons(Actor mo)
	{
		if (!mo)
			return;

		StripAll(mo, 'Fire_and_Ice-DragonSlayer');
		StripAll(mo, 'PB_FireAndIceDragonSlayerBase');
		StripAll(mo, 'PB_FireAndIceDragonSlayer');
		StripAll(mo, 'NemesisLMG');
		StripAll(mo, 'NemesisLMGFast');
		StripAll(mo, 'NemesisRune_LMG');
	}

	play static void Run(Actor mo)
	{
		if (!mo)
			return;

		PatchWeaponSelectionOrders(mo);
		StripDisabledWeapons(mo);
	}

	play static bool HasWeapon(Actor mo, Name className)
	{
		for (Inventory item = mo.Inv; item; item = item.Inv)
		{
			if (item is 'Weapon' && item.GetClassName() == className)
				return true;
		}
		return false;
	}

	play static void StripAll(Actor mo, Name className)
	{
		Inventory item = mo.Inv;
		while (item)
		{
			Inventory next = item.Inv;
			if (item.GetClassName() == className)
				item.Destroy();
			item = next;
		}
	}
}

class PBWP_WeaponDedupeInventory : Inventory
{
	Default
	{
		Inventory.MaxAmount 1;
		+INVENTORY.UNDROPPABLE
	}

	override void DoEffect()
	{
		Super.DoEffect();
		if (!owner)
			return;
		PBWP_WeaponDedupeUtil.PatchWeaponSelectionOrders(owner);
		if ((level.maptime % 17) == 0)
			PBWP_WeaponDedupeUtil.StripDisabledWeapons(owner);
	}
}
