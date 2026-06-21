// KarnRPG7 ("DA-7p RPG-7") was removed from PBWP. These tombstones reclaim the actor
// names so older saves, pickups, and stale pk3 copies cannot stay in the slot-6 cycle.

class Krg_Rpgammo : Ammo
{
	Default
	{
		Inventory.MaxAmount 1;
	}

	override void AttachToOwner(Actor other)
	{
		Super.AttachToOwner(other);
		if (other)
			other.A_TakeInventory('Krg_Rpgammo', 9999);
	}
}

class KarnRPG7 : PB_WeaponBase
{
	Default
	{
		Weapon.SlotNumber 6;
		Weapon.SelectionOrder -32768;
		Tag " ";
	}

	override void AttachToOwner(Actor other)
	{
		Super.AttachToOwner(other);
		if (other)
		{
			other.A_TakeInventory('Krg_Rpgammo', 9999);
			other.A_TakeInventory('KarnRPG7', 1);
		}
	}

	States
	{
	Spawn:
		TNT1 A -1;
		Stop;
	Select:
		TNT1 A 0 A_TakeInventory('KarnRPG7', 1);
		Stop;
	Ready:
	Ready3:
		TNT1 A 0 A_TakeInventory('KarnRPG7', 1);
		Stop;
	Deselect:
		TNT1 A 0 A_Lower(120);
		Wait;
	FlashPunching:
		TNT1 AAAAAAAAAAAAAA 1;
		Stop;
	FlashKicking:
		TNT1 AAAAAAAAAAAAAAA 1;
		Stop;
	FlashAirKicking:
		TNT1 AAAAAAAAAAAAAAAA 1;
		Stop;
	FlashSlideKicking:
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 1;
		Stop;
	FlashSlideKickingStop:
		TNT1 AAAAAAA 1;
		Stop;
	LoadSprites:
		TNT1 A 0;
		Stop;
	}
}

class RPGpickup : CustomInventory
{
	override void AttachToOwner(Actor other)
	{
		Super.AttachToOwner(other);
		if (other)
			other.A_TakeInventory('RPGpickup', 1);
	}

	States
	{
	Spawn:
		TNT1 A -1;
		Stop;
	Pickup:
		TNT1 A 0;
		Stop;
	}
}

class PBWP_RemovedWeaponPurgeHandler : StaticEventHandler
{
	void PurgeRemovedWeapons(Actor mo)
	{
		if (!mo)
			return;

		mo.A_TakeInventory('KarnRPG7', 9999);
		mo.A_TakeInventory('Krg_Rpgammo', 9999);
		mo.A_TakeInventory('RPGpickup', 9999);
	}

	override void PlayerEntered(PlayerEvent e)
	{
		if (e.PlayerNumber < 0 || e.PlayerNumber >= MAXPLAYERS)
			return;
		if (!playeringame[e.PlayerNumber] || !players[e.PlayerNumber].mo)
			return;
		PurgeRemovedWeapons(players[e.PlayerNumber].mo);
	}

	override void PlayerSpawned(PlayerEvent e)
	{
		if (e.PlayerNumber < 0 || e.PlayerNumber >= MAXPLAYERS)
			return;
		if (!playeringame[e.PlayerNumber] || !players[e.PlayerNumber].mo)
			return;
		PurgeRemovedWeapons(players[e.PlayerNumber].mo);
	}
}
