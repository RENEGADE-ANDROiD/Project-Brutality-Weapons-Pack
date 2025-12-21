// Make all Spawners inherit this
class PBWP_Spawner : PB_SpawnerBase
{
    Default
    {
        scale 0.45;
		-COUNTKILL; 
		+NOTIMEFREEZE;
		-ISMONSTER;
		Species "PBWPSpawner";
    }
    // This function is the checker for inventory tokens
    // THIS DOESNT WORK LOL
    action bool PlayerAlreadyHas(string inv)
	{
		let p = players[0];
    	if (p && p.mo)
        return p.mo.CountInv(inv);
        return false;
    }
}

// Placeholder
class PBWP_Weapon : PB_Weapon 
{}

class PBWP_ComplexAmmo : PB_Ammo
{
    Default
    {
        Inventory.Amount 666;
        Inventory.MaxAmount 666;
        Inventory.PickupSound "demonsoulpickup";
        Ammo.BackpackAmount 666;
        Ammo.BackpackMaxAmount 666;
    }
}