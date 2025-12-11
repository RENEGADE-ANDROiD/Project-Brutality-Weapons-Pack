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

// Credits to Jaih1r0 again for this functions from the HeavySniper, CSSG, and DemonExt mod
class PBWP_Weapon : PB_Weapon
{
	action bool PressingUser2(){return player.cmd.buttons & BT_USER2;}

    //If ammo is less than min, go to state. Default is "Reload:" state
    Action state PB_CheckAmmoFire(int min = 1, statelabel Relstate = "Reload")
	{
		if(countinv(invoker.ammotype2) < min)
		return resolvestate(Relstate);
		return resolvestate(null);
	}

	//Just the pb_Firebullets but with a null check added
	action void PBWP_FireBullets(string type, int amount, double angle, double offs, double height, double pitch)
	{
		vector2 spread;
		for(int i = amount; i > 0; i--)
		{
			spread.x = frandom(-angle, angle);
			spread.y = frandom(-pitch, pitch);

			if(i == amount) 
			{
				spread.x *= PB_Math.LinearMap(pb_weapon_recoil_mod_horizontal, 0.0, 1.0, 1.0, 0.2);
				spread.y *= PB_Math.LinearMap(pb_weapon_recoil_mod_vertical, 0.0, 1.0, 1.0, 0.2);
				// spread *= clamp((invoker.sustainedFire / 5), 0, 1);
				spread *= GetCrouchFactor();
			}

			Actor p1, p2 = A_FireProjectile(type, spread.x, 0, offs, height, FPF_NOAUTOAIM, spread.y);

            if(p2)
            {
                PB_Projectile pbProj = PB_Projectile(p2);
				if(pbProj)
					pbProj.isBloodExplosionGenerator = amount > 4 && i == amount;
            }
		}
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

	Action State PB_CheckBarrelIdle1()
	{
		//got nukage barrel
		if(countinv("GrabbedBarrel")>0)
			return resolvestate("IdleBarrel");
		//got flame barrel
		if(countinv("GrabbedFlameBarrel")>0)
			return resolvestate("IdleFlameBarrel");
		//got ice barrel
		if(countinv("GrabbedIceBarrel")>0)
			return resolvestate("IdleIceBarrel");
		//no barrel
		return resolvestate(null);
	}
}