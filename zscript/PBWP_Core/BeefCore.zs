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
{
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