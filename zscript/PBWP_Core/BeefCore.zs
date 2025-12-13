// Inventory Tokens that the PlayerAlreadyHas will look for
class AlreadyHaveMeatHook : inventory{default{inventory.maxamount 1;}}

// Make all Spawners inherit this
class PBWP_Spawner : PB_SpawnerBase
{
    // This function is the checker for inventory tokens
    // See example in the marauder spawner
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