// Killstreak reward: 30-second Hyperweapon Rig with unlimited volley ammo.

class PB_PowerMegaRig : Powerup
{
	Name prevWeaponName;

	Default
	{
		Powerup.Duration -30;
		Powerup.Color "00 FF AA", 0.035;
	}

	override void InitEffect()
	{
		Super.InitEffect();

		if (!Owner || !Owner.player)
			return;

		prevWeaponName = 'None';
		let cur = Owner.player.ReadyWeapon;
		if (cur && !(cur is 'PB_MegaRig'))
			prevWeaponName = cur.GetClassName();

		// Weapon is granted only while this power is active (see PB_MegaRig.AttachToOwner).
		if (!Owner.FindInventory("PB_MegaRig"))
			Owner.GiveInventory("PB_MegaRig", 1);

		let rig = Weapon(Owner.FindInventory("PB_MegaRig"));
		if (rig)
			Owner.player.PendingWeapon = rig;
	}

	override void EndEffect()
	{
		PB_MegaRig.ClearOverlayLayers(PlayerPawn(Owner));

		if (Owner && Owner.player && prevWeaponName != 'None')
		{
			let w = Weapon(Owner.FindInventory(prevWeaponName));
			if (w)
				Owner.player.PendingWeapon = w;
		}

		if (Owner && Owner.FindInventory("PB_MegaRig"))
			Owner.TakeInventory("PB_MegaRig", 1);

		Super.EndEffect();
	}
}

class PB_MegaRigSphere : PowerupGiver
{
	Default
	{
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		+FLOATBOB;
		Inventory.MaxAmount 0;
		Powerup.Type "PB_PowerMegaRig";
		Powerup.Duration -30;
		Inventory.PickupMessage "HYPERWEAPON RIG — 30 seconds of unlimited firepower!";
		Inventory.PickupSound "BFG2704/Select";
		Tag "Hyperweapon Rig Sphere";
		Scale 0.85;
		FloatBobStrength 0.6;
	}

	States
	{
	Spawn:
		BF27 ABCD 4 Bright A_SpawnItem("GreenFlareSmall", 0, 24);
		Loop;
	}
}
