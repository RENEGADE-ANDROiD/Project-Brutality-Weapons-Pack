#include "ZScript/PBWP_Misc/BDPmath.zsc" // FORCE LOAD THE BDPMATH
#include "zscript/Weapons/BaseWeapon_MonsterPackCompat.zs"
#include "zscript/Weapons/BaseWeapon_GKCompat.zs"

// Credits to Jaih1r0 again for this functions from the HeavySniper, CSSG, and DemonExt mod
extend class PB_WeaponBase
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
	
	// BDP Melee
	Action void A_BDPMeleeStart(double range = 200)
    {
        FLineTraceData lt;
            LineTrace(angle, range, pitch, 0, player.viewheight, data:lt);
            If(lt.hitactor && lt.hitactor.bsolid)
            {
                A_face(lt.hitactor);
                A_Recoil3D(-20);
            }
    }
    action double A_CheckMeleeRange(double maxrange = 512, bool skipWalls = false)
    {
        FLineTraceData lt;
        LineTrace(angle, maxrange, pitch, 0, player.viewheight, data:lt);
        return (skipWalls && !lt.hitActor) ? maxrange : lt.Distance;
    }

    action void A_Recoil3D(double amt)
    {
        vel += BDPMath.VecFromAngles(angle, pitch, -amt);
    }
    
    action Actor A_BDPMelee(double range = 200, name projectile = "MeleeAttack", double spawnheight = -7, bool doHitThrust = true)
    {
        Actor Victim;
        
            FLineTraceData lt;
            double aimz = self.player ? self.player.viewheight : (self.height * 0.5);
            self.LineTrace(self.angle, range, self.pitch, 0, aimz, data:lt);
            victim = lt.HitActor;
            int aimCheck = -6;
            bool backsmack;
            while (aimCheck++ < 6 && !victim)
            {
                self.LineTrace(self.angle + (aimCheck * 8), range, self.pitch, 0, aimz, data:lt);
            victim = lt.hitActor;
            }
        if(victim && victim.bSHOOTABLE) 
        {
            vector3 victimAngles = level.sphericalCoords(victim.pos, self.pos, (victim.angle, victim.pitch));
            double inertia = BDPMath.GetInertia(victim.mass);
            self.A_Quake(2,3,0,20,"");
            self.A_face(victim);
            if(doHitThrust && victim.bsolid)
            {
                self.vel *= 0;
                self.vel += BDPMath.VecFromAngles(self.angle, self.pitch, -12);    
            }
                        
        }
        actor proj = A_FireProjectile(projectile, 0, 0, 0, spawnheight);
            If(proj && victim && victim.bSHOOTABLE)
            {
                proj.setorigin(victim.pos,false);
            }
        return victim;
    }
}