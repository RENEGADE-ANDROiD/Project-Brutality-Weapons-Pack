// BDPMath: provided by PBX-Weapons (Zscript/Maths/math.zsc). Do not include BDPmath.zsc here.
#include "zscript/PBWP_Core/PBWP_CombatDamageHandler.zs"
#include "zscript/Weapons/BaseWeapon_MonsterPackCompat.zs"
//#include "zscript/Weapons/BaseWeapon_GKCompat.zs" // disabled: GK shoulder-cannon states need Staging-only tokens; PB_ExecuteGK stub below

// Credits to Jaih1r0 again for this functions from the HeavySniper, CSSG, and DemonExt mod
extend class PB_WeaponBase
{
	Name respectItem;
	property RespectItem : respectItem;

	Name respectInventoryItem;
	property RespectInventoryItem : respectInventoryItem;

	string fireMode;
	string upgradedRifleMode;
	bool chainsawMode;

	Name DualWieldToken;
	property DualWieldToken : DualWieldToken;

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
        double cosp = cos(pitch);
        vel += (cos(angle) * cosp, sin(angle) * cosp, -sin(pitch)) * amt;
    }
    
    action void A_PBWP_DeferredMelee(int damage = 25, double range = 78, Name dmgType = 'Melee')
    {
        let ply = player;
        if (!ply || !ply.mo)
            return;

        let mo = ply.mo;
        FLineTraceData lt;
        double aimz = ply.viewheight;
        Actor victim = null;

        LineTrace(angle, range, pitch, 0, aimz, data: lt);
        if (PBWP_CombatDamageHandler.IsCombatTarget(lt.hitActor, mo))
            victim = lt.hitActor;

        if (!victim)
        {
            int step = -6;
            while (step++ < 6 && !victim)
            {
                LineTrace(angle + step * 8, range, pitch, 0, aimz, data: lt);
                if (PBWP_CombatDamageHandler.IsCombatTarget(lt.hitActor, mo))
                    victim = lt.hitActor;
            }
        }

        if (victim)
            PBWP_CombatDamageHandler.Schedule(victim, mo, mo, damage, dmgType);
    }

    action Actor A_BDPMelee(double range = 200, name projectile = "MeleeAttack", double spawnheight = -7, bool doHitThrust = true, bool deferDamage = false, int deferAmount = 200, Name deferDmgType = 'Melee')
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
            self.A_Quake(2,3,0,20,"");
            self.A_face(victim);
            if(doHitThrust && victim.bsolid)
            {
                double cosp = cos(self.pitch);
                self.vel *= 0;
                self.vel += (cos(self.angle) * cosp, sin(self.angle) * cosp, -sin(self.pitch)) * 12;
            }

            if (deferDamage)
            {
                PBWP_CombatDamageHandler.Schedule(victim, self, self, deferAmount, deferDmgType);
                return victim;
            }
                        
        }
        actor proj = A_FireProjectile(projectile, 0, 0, 0, spawnheight);
            If(proj && victim && victim.bSHOOTABLE)
            {
                proj.setorigin(victim.pos,false);
            }
        return victim;
    }

    action Actor A_PBWP_WheelMelee(double range = 200, name projectile = "MeleeAttack", double spawnheight = -7, bool doHitThrust = true, int damage = 200)
    {
        return A_BDPMelee(range, projectile, spawnheight, doHitThrust, true, damage, 'Melee');
    }

	action state FiretoExecute()
	{
		return PB_FireExecuteCheck();
	}

	action State PB_ResolveQuickMeleeShieldThrow()
	{
		if (CountInv("ShieldSawSelected") >= 1 && CountInv("ShieldSawAmmo") >= 1 && CountInv("AlreadyThrownShieldSaw") == 0)
			return ResolveState("ThrowShieldSaw");
		return ResolveState(null);
	}

	action void A_PB_AirMeleeLunge(double speed = 10)
	{
		let mo = invoker.owner;
		if (mo && mo.vel.z != 0)
			A_Recoil(-speed);
	}

	// Monster-drop salvage durability (PBX-style) — gate at Fire:, grant pool on select.
	action void PBWP_EnsureMonsterDurability(Name durabilityItem, int maxAmount)
	{
		if (CountInv(durabilityItem) < 1)
			A_GiveInventory(durabilityItem, maxAmount);
	}

	action state PBWP_MonsterDurabilityFireGate(Name durabilityItem, Name weaponClass)
	{
		if (CountInv(durabilityItem) < 1)
		{
			for (int i = 0; i < 3; i++)
			{
				A_SpawnItemEx("MetalShard1", 0, 0, 32,
					frandom(-2, 2), frandom(-2, 2), frandom(2, 6), random(0, 359),
					SXF_NOCHECKPOSITION);
			}
			A_TakeInventory(weaponClass, 1);
			A_StartSound("meleeweapon/break", CHAN_WEAPON);
			A_Print("\cdSalvaged weapon broke!");
			return ResolveState("Ready");
		}
		A_TakeInventory(durabilityItem, 1, TIF_NOTAKEINFINITE);
		return ResolveState(null);
	}

	// DECORATE-safe mag-unload branch (plain A_JumpIf cannot call PB_GetMagUnloaded()).
	action state PB_JumpIfMagUnloaded(statelabel label)
	{
		if (PB_GetMagUnloaded())
			return ResolveState(label);
		return null;
	}

	action state PB_JumpIfMagUnloadedDual(statelabel label)
	{
		if (PB_GetMagUnloaded(true))
			return ResolveState(label);
		return null;
	}

	// For DECORATE { return A_DoPBWeaponAction(...); } blocks — ternary args fail to parse.
	action state PB_DoPBWeaponActionUnloaded(int weapflags = WRF_ALLOWRELOAD)
	{
		return A_DoPBWeaponAction(weapflags, PB_GetMagUnloaded() ? PBWEAP_UNLOADED : 0);
	}

	// PB 2022 name for fire-triggered executions; PBWP menu uses ttwcfbex via PB_FireExecuteCheck().
	action state PB_TryAutoFatalityOnFire()
	{
		return PB_FireExecuteCheck();
	}

	void PB_RefillMonsterSourcedWeaponWear(PlayerPawn p)
	{
		if (!p || !p.player)
			return;
		Name cn = GetClassName();
		if (cn == 'MancubusFlameCannon')
		{
			let inv = p.FindInventory("MancubusFlameCannonDurability");
			if (!inv || inv.Amount < 60)
				p.GiveInventory("MancubusFlameCannonDurability", 60);
		}
		else if (cn == 'MarauderSSG')
		{
			let inv = p.FindInventory("MarauderSSGDurability");
			if (!inv || inv.Amount < 80)
				p.GiveInventory("MarauderSSGDurability", 80);
		}
	}

	// Glory Kills optional: GK mod routes via FinisherToken; fallback to PB fatality.
	action state PB_ExecuteGK()
	{
		let cv = CVar.GetCVar("isGKLoaded");
		if (!cv || !cv.GetBool())
			return PB_Execute();
		EventHandler.SendNetworkEvent("pbwp_glory_kill");
		return resolveState(null);
	}

	// PB_Staging SuperGL arms PB_FragGrenade via detonateNow; DECORATE launchers (VietDoom M79, etc.) need this after spawn.
	action void PB_DetonateFragGrenades()
	{
		ThinkerIterator tit = ThinkerIterator.Create("PB_FragGrenade");
		PB_FragGrenade fg;
		while (fg = PB_FragGrenade(tit.Next()))
		{
			if (fg)
				fg.detonateNow = true;
		}
	}

}