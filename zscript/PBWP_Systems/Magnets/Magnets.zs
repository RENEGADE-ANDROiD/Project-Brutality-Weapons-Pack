// PBWP item magnet (forked from Dragon Sector; all symbols/sprites use PBWP_ / PBWM prefix).
// Container for items that could not be picked up on the previous attempt.
class PBWP_ItemMagnetInfo : Object 
{
    Inventory item; // Item pointer of item that failed to be picked up.
    int timeAdded; // The time at which it was added to the array.

    static PBWP_ItemMagnetInfo Create(Inventory item, int time)
    {
        let itm = new("PBWP_ItemMagnetInfo");
        itm.item = item;
        itm.timeAdded = time;
        return itm;
    }
}

Class PBWP_ItemMagnet : Inventory
{
	double PickupRange; // Distance the Magnet can pull in from
	property PickupRange : PickupRange; // Property for easily changing Range.
	double PullSpeed; // How fast items will be pulled toward you.
	property PullSpeed : PullSpeed;
	array <Inventory> FoundItems; // Dynamic Array to store potentially pullable items into.
	Array<PBWP_ItemMagnetInfo> CantPickupForNow; // Items that couldn't be picked up are added here for a time.
	bool IsMagnetOn;

	// Set Magnet On
	/*override void BeginPlay()
	{
		super.BeginPlay();
		IsMagnetOn = true;
	}*/
	
	static const Name ExcludeReplaced[] = // Items the Vacuum will not pull.
	{
		'SoulSphere', 'MegaSphere', 'BlurSphere', 'BlueArmor', 'GreenArmor', 'Medikit', 'StimPack', 'RadSuit',
		'Infrared', 'InvulnerabilitySphere', 'Allmap', 'Backpack', 'Berserk', 'RedCard',
		'BlueCard', "YellowCard", 'RedSkull', 'BlueSkull', 'YellowSkull'
	};

	static const Name ModSpecific[] = // Exclude Mod-specific Items from being pulled.
	{
		// --- Project Brutality Specific Excludes
		'PB_SGMagazine', 'PB_AutoshotgunUpgrade', 'RifleUpgrade', 'PB_MinigunUpgrade',
		'PB_M2Upgrade', 'PB_FlamethrowerUpgrade', 'PB_Backpack', 'PB_BlueArmor',
		'PB_GreenArmor', 'PB_Stimpack', 'PB_Medikit', 'PB_Doomsphere', 'PB_Haste',
		'PBWP_ItemMagnet', 'PBWP_ItemMagnetUpgrade'
	};

	// Call to start the process of pulling:
	void FindPullableItems(double dist = 256)
	{
		if (!owner)
			return;

		BlockThingsIterator itemfinder = BlockThingsIterator.Create(owner, owner.radius + dist);
		while (itemfinder.Next())
		{
			let item = Inventory(itemfinder.thing);
			// It's an item, has no owner, ShouldPull returns true, and isn't yet in the array:
			if (item && !item.owner && ShouldPull(item) && FoundItems.Find(item) == FoundItems.Size())
			{
				// Push into the array:
				FoundItems.Push(item);
			}
		}
	}

	bool ShouldPull(Inventory item)
	{
		// Exclude specific classes from being pulled.
	//	if (item is 'Weapon' || item.bBigPowerup)
	//		{
				//console.Printf("Ignoring Weapon or Big Powerup: %s", item.GetClassName());
		//		return False;
	//		}

		// Exclude specific items from the ExcludeReplacements Array.
		for (int i; i < ExcludeReplaced.Size(); i++)
		{
			if (item.GetClass() is GetReplacement(ExcludeReplaced[i]))
			{
				//let RepItem = GetReplacee(item.GetClass());
				//console.Printf("Ignoring Replaced: %s", RepItem.GetClassName());
				return False;
			}
		}

		// Check for, and if they exist, Exclude PB Items from being pulled in.
		for (int i; i < ModSpecific.Size(); i++)
		{
			Class<Inventory> moditem = ModSpecific[i];
			if (moditem && item.GetClassName() == moditem)
			{
				//console.Printf("Ignoring Mod Specific: %s", item.GetClassName());
				return False;

			}
		}

		// Make sure the item isn't in the list of items that can't be picked up right now.
		for (int i; i < CantPickupForNow.Size(); i++)
		{
			let ItemData = CantPickUpForNow[i];
			if (ItemData.item == item && level.time - ItemData.timeAdded >= 700)
			{
				CantPickupForNow.Delete(i);
				return True;
			}
			else if (ItemData.item == item && level.time - ItemData.timeAdded < 700)
				return False;
		}

		// Don't add items that are in your immediate area.
		if (item.Distance3D(owner) <= item.radius + owner.radius)
			return False;

		// If an item is found, check that it has line-of-sight to the player, if not, move on.
		if (!item.CheckSight(owner, SF_IGNOREWATERBOUNDARY))
			return False;
		return True;
	}

	// This has to be called every tick to perform pulling and pickup:
	void PullFoundItems(double maxdist = 256, double pullspeed = 15)
	{
		if (!owner)
			return;
		if(!IsMagnetOn)
			return;

		if (FoundItems.Size() == 0)
			return;

		for (int i = FoundItems.Size() - 1; i >= 0; i--)
		{
			if (i >= FoundItems.Size() || !FoundItems[i])
				continue;

			let item = FoundItems[i];
			// If it's too far, drop it and delete from array:
			if (item.owner || owner.Distance3D(item) > maxdist)
			{
				item.A_Stop();
				FoundItems.Delete(i);
				continue;
			}
			// If it can't see the player, move on.
			if (!item.CheckSight(owner, SF_IGNOREWATERBOUNDARY))
			{
				FoundItems.Delete(i);
				continue;
			}

			// If it's too close, force the owner to pick it up and remove from the array:
			if (owner.Distance3D(item) <= item.radius + owner.radius)
			{
				if (item.CallTryPickup(owner))
				{
					if (!PBWP_PickupMessageUtil.IsSilentMsg(item))
					{
						item.PlayPickupSound(owner);
						item.PrintPickupMessage(owner.CheckLocalView(), item.PickupMessage());
					}
					item.SetGiveAmount(owner, item.Amount, false);
					if (item.bCOUNTITEM) // If the item should be counted , increment item counts.
					{
						if (owner.player)
							owner.player.itemcount++;
						level.found_items++;
					}
					// ALWAYSPICKUP / failed GoAwayAndDie can leave pullable pickups overlapping the player.
					if (!item.owner)
						item.Destroy();
				}
				else  // Stop the item and then add it it's the current game tic to the CantPickupForNow array.
				{
					item.A_Stop();
					CantPickupForNow.Push(PBWP_ItemMagnetInfo.Create(item, level.time));
				}
				FoundItems.Delete(i);
				continue;
			}
		
			// Otherwise move it towards the owner (specifically, its center):
			let dir = Level.Vec3Diff(item.pos, owner.pos + (0,0,owner.height * 0.5)).Unit();
			item.bNOBLOCKMONST = true;
			item.bNOCLIP = true;
			item.vel = dir * pullspeed;
		}
	}

	override void DoEffect()
	{
		super.DoEffect();
		if(!IsMagnetOn)
			return;
		if (isFrozen())
			return;
			
		let barmor = BasicArmor(owner.FindInventory("BasicArmor"));
		if (barmor && barmor.Amount > 0)
		{
			if (level.time % 2 == 0) // Poll for items every 2 tics.
			{
				FindPullableItems(dist: PickupRange);
			}
			PullFoundItems(PickupRange, PullSpeed); // Actually pull items.
		}

	}
    Default
    {
		//$Category "Custom Powerups"
		//$Title "Item Magnet"
		Inventory.MaxAmount 1;
		Inventory.Amount 1;
		-COUNTITEM;
		Scale 0.25;
		Radius 16;
		Height 32;
		PBWP_ItemMagnet.PickupRange 384;
		PBWP_ItemMagnet.PullSpeed 25;
	}
	states 
	{
	Spawn:
		TNT1 A -1;
		stop;
	}
}

Class PBWP_ItemMagnetUpgrade : Inventory
{
	double UpgradedRange; // The new Range to Upgrade the Magnet to.
	property UpgradedRange : UpgradedRange; // The property that will hold this new Range.
	double UpgradedSpeed; // The new Speed of the items being pulled in.
	property UpgradedSpeed : UpgradedSpeed; // The Property to hold this Speed value.
	override bool TryPickup(in out Actor toucher)
	{
		let ret = super.TryPickup(toucher);
		if (ret)
		{
			let magnet = PBWP_ItemMagnet(toucher.FindInventory("PBWP_ItemMagnet"));
			if (!magnet)
			{
				toucher.GiveInventory("PBWP_ItemMagnet", 1);
				self.Destroy();
			}
			else if (magnet && magnet.PickupRange >= 0)
			{
				magnet.PickupRange = UpgradedRange;
				magnet.PullSpeed = UpgradedSpeed;
			}
		}
		return ret;
	}
    Default
    {
		//$Category "Custom Powerups"
		//$Title "Item Magnet Extender"
		Inventory.MaxAmount 1;
		Inventory.Amount 1;
		-COUNTITEM;
		Scale 0.25;
		Radius 16;
		Height 32;
		PBWP_ItemMagnetUpgrade.UpgradedRange 1024;
		PBWP_ItemMagnetUpgrade.UpgradedSpeed 32.25;
	}
	states 
	{
	Spawn:
		TNT1 A -1;
		stop;
	}
}

Class PBWP_MagnetHandler : EventHandler
{
	override void PlayerSpawned (PlayerEvent e)
	{
		PlayerInfo player = players[e.PlayerNumber];
		let pmo = player.mo; // Player Map Object
		if (pmo)
			pmo.GiveInventory("PBWP_ItemMagnet",1);
	}
	override void PlayerRespawned (PlayerEvent e)
	{
		PlayerInfo player = players[e.PlayerNumber];
		let pmo = player.mo; // Player Map Object
		if (pmo)
			pmo.GiveInventory("PBWP_ItemMagnet",1);
	}
}