class PBWP_Spawner : PB_SpawnerBase
{
    // This function is the checker for inventory tokens
    // See example in the marauder spawner
    action bool PlayerAlreadyHas(string inv)
	{
		PlayerInfo p = players[0];
    	if (p && p.mo)
        return p.mo.FindInventory(inv) != null;
        return false;
    }
}

// Thanks to Jaih1r0 again for this functions from the HeavySniper mod
class PBWP_Weapon : PB_Weapon
{
    //If ammo is less than min, go to state
    Action state PB_CheckAmmoFire(int min = 1, statelabel Relstate = "Reload")
	{
		if(countinv(invoker.ammotype2) < min)
		return resolvestate(Relstate);
		return resolvestate(null);
	}

    //Just put the first in the beggining of the fire state
	//and the second on the beggining of the altfire state
    Action State PB_CheckBarrelThrow1()
	{
		//got nukage barrel
		if(countinv("GrabbedBarrel")>0)
			return resolvestate("ThrowBarrel");
		//got flame barrel
		if(countinv("GrabbedFlameBarrel")>0)
			return resolvestate("ThrowFlameBarrel");
		//got ice barrel
		if(countinv("GrabbedIceBarrel")>0)
			return resolvestate("ThrowIceBarrel");
		//no barrel
		return resolvestate(null);
	}
	
	Action State PB_CheckBarrelPlace1()
	{
		//got nukage barrel
		if(countinv("GrabbedBarrel")>0)
			return resolvestate("PlaceBarrel");
		//got flame barrel
		if(countinv("GrabbedFlameBarrel")>0)
			return resolvestate("PlaceFlameBarrel");
		//got ice barrel
		if(countinv("GrabbedIceBarrel")>0)
			return resolvestate("PlaceIceBarrel");
		//no barrel
		return resolvestate(null);
	}
}