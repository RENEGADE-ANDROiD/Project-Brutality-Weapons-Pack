// Tiberium's Soulblade — folded from Insanity's Requiem Mk.2 (PB_VorpalBlade_from_Insanitys_Requiem-MK2.wad)
// RedParticleSpawner uses actors/Weapons/FX/GCSFX.dec; spawner in PBWP_WeaponSpawners.zs
class VorpalBlade : PB_WeaponBase
{
    // ----- Internal Math Helpers -----
    static vector3 VecFromAngles(double angle, double pitch, double mag = 1.)
    {
        double cosp = cos(pitch);
        return (cos(angle)*cosp, sin(angle)*cosp, -sin(pitch)) * mag;
    }

    static double GetInertia(double emass, double smallmass = 200)
    {
        double m = smallmass;        // base mass
        double d = 0.15;             // mass dropoff
        double x = (1. - (emass / m));
        double y = -d * (x * x) + 1;
        return clamp(y * 0.75, 0.1, 1.0);
    }

    // ----- Melee Functions (ported from original) -----
    Action void A_BDPMeleeStart(double range = 200)
    {
        FLineTraceData lt;
        LineTrace(angle, range, pitch, 0, player.viewheight, data:lt);
        if(lt.hitActor && lt.hitActor.bSOLID)
        {
            A_Face(lt.hitActor);
            A_Recoil3D(-20);
        }
    }

    Action double A_CheckMeleeRange(double maxrange = 512, bool skipWalls = false)
    {
        FLineTraceData lt;
        LineTrace(angle, maxrange, pitch, 0, player.viewheight, data:lt);
        return (skipWalls && !lt.hitActor) ? maxrange : lt.distance;
    }

    Action void A_Recoil3D(double amt)
    {
        vel += VecFromAngles(angle, pitch, -amt);
    }
    
    Action Actor A_BDPMelee(double range = 200, name projectile = "MeleeAttack", double spawnheight = -7, bool doHitThrust = true)
    {
        Actor victim;
        FLineTraceData lt;
        double aimz = player ? player.viewheight : (height * 0.5);
        LineTrace(angle, range, pitch, 0, aimz, data:lt);
        victim = lt.hitActor;
        int aimCheck = -6;
        while (aimCheck++ < 6 && !victim)
        {
            LineTrace(angle + (aimCheck * 8), range, pitch, 0, aimz, data:lt);
            victim = lt.hitActor;
        }
        if(victim && victim.bSHOOTABLE) 
        {
            A_Face(victim);
            if(doHitThrust && victim.bSOLID)
            {
                vel = (0,0,0);
                vel += VecFromAngles(angle, pitch, -12);    
            }
        }
        actor proj = A_FireProjectile(projectile, 0, 0, 0, spawnheight);
        if(proj && victim && victim.bSHOOTABLE)
        {
            proj.SetOrigin(victim.pos, false);
        }
        return victim;
    }

    // ----- Execution integration -----
    bool meleeLocked;       // becomes true when A_BDPMeleeStart successfully locks on
    bool ttwcfbex;          // some condition â€“ adjust as needed

    // ----- Weapon definition -----
    Default
    {
        Weapon.SlotNumber 1;
        Weapon.SelectionOrder 2200;
        Tag "Tiberium's Soulblade";
        Inventory.PickupMessage "Tiberium's Soulblade (Slot-1)";
        Inventory.PickupSound "misc/w_pkup";
		Inventory.AltHUDIcon "WVRPA0";
        AttackSound "Sword/Hit";
        Weapon.UpSound "Sword/Draw";
        Weapon.AmmoUse 0;
        Weapon.AmmoUse2 0;
        Weapon.BobStyle "inverseSmooth";
        Weapon.BobRangeX 0.4;
        Weapon.BobRangeY 0.6;
        Weapon.BobSpeed 2.5;
        +WEAPON.AMMO_OPTIONAL
        +WEAPON.MELEEWEAPON
        +WEAPON.NOALERT
        +DONTGIB
        Obituary "%o was relieved of %p head by %k's sword.";
        PB_WeaponBase.respectItem "VorpalBladeRespect";
        Scale 0.5;
    }

    // ----- Sweep attack (original) -----
    Action void hxa_CustomRollAttack(int damage = 0, double healfactor = 1, bool PierceEnemies = FALSE,
                                      double roll = 0, int area = 90, int dist = 1024,
                                      name PuffActor = "null", sound HitActorSound = "null", sound HitWallSound = "null")
    {
        if(!player) return;

        bool PlaySoundEnemy = FALSE;
        bool PlaySoundWall = FALSE;
        Array<Actor> Targets;
        For(int i = 0; i < area; i++)
        {
            double horAng = angle - area*cos(roll)/2;
            double pit = pitch - area*sin(roll)/2;
            int hdif = 10;
            LineAttack(horAng+(i*cos(roll)), dist, pit+(i*sin(roll)), 0, 'Melee', PuffActor, true, offsetz: height-hdif);
            FLineTraceData h;
            LineTrace(horAng+(i*cos(roll)), dist, pit+(i*sin(roll)), offsetz: height-hdif, data:h);
            if(h.hitActor != null && h.hitActor.bSHOOTABLE)
            {
                PlaySoundEnemy = TRUE;
                h.hitActor.DamageMobj(self, self, damage, 'damagetype', DMG_THRUSTLESS);
                A_DamageSelf(-damage * healfactor);   // heal
                if(PierceEnemies)
                {
                    h.hitActor.bSHOOTABLE = 0;
                    Targets.Push(h.hitActor);
                }
            }
            else if((h.HitType == TRACE_HitWall || h.HitType == TRACE_HitCeiling || h.HitType == TRACE_HitFloor) &&
                    (pitch > 20 || pit+(i*sin(roll)) < 10))
            {
                PlaySoundWall = TRUE;
            }
        }
        if(PlaySoundEnemy) A_StartSound(HitActorSound, pitch:frandom(.9,1.1));
        if(PlaySoundWall)  A_StartSound(HitWallSound, pitch:frandom(.9,1.1));
        for(int z = 0; z < Targets.Size(); z++)
            Targets[z].bSHOOTABLE = 1;
    }

    // ----- States -----
    States
    {
        Spawn:
            VORX A -1;
            Stop;
        Steady:
            TNT1 A 1;
            Goto Ready;

        Select:
            TNT1 A 0 PB_WeaponRaise("Sword/Draw");
            TNT1 A 0 PB_RespectIfNeeded();
        SelectContinue:
            TNT1 A 0;
        	TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
        	Goto Ready3;
        SelectAnimation:
            VORS EDCBA 1;
            Goto Ready3;

        Deselect:
            	TNT1 A 0 A_Lower(120);
            Wait;

        WeaponRespect:
            TNT1 A 0 A_SetInventory(invoker.respectInventoryItem, 1);
            VORS EDCBA 1 A_DoPBWeaponAction();
            Goto Ready3;

        Ready3:
            TNT1 A 0 PB_HandleCrosshair(1);
            VORP A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
            Loop;

        Fire:
            TNT1 A 0
            {
                A_WeaponOffset(0,32);
                A_SetRoll(0);
                A_SetInventory("PB_LockScreenTilt", 0);
                PB_HandleCrosshair(1);
                A_BDPMeleeStart(200);      
                PB_Execute();
            }
            TNT1 A 0 A_Jump(256, "SwingRighty", "SwingLefty");
            Goto Ready3;

        SwingRighty:
            VORR A 0 Offset(15,32);
            VORR A 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 A_PlaySound("Sword/Swing", CHAN_WEAPON, 1.0, 0, 2);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: 45, area: 45, dist: 48,
                                           PuffActor: "KyreiPuffRight",
                                           HitActorSound: "Sword/HitMeat",
                                           HitWallSound: "Sword/HitWall");
            TNT1 A 0 A_FireCustomMissile("RedParticleSpawner");
            VORR B 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORR C 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORR D 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORR E 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 3 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 A_Refire("Fire");
            Goto PreReady;

        SwingLefty:
            VORL A 0 Offset(15,32);
            VORL A 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 A_PlaySound("Sword/Swing", CHAN_WEAPON, 1.0, 0, 2);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: -45, area: 45, dist: 48,
                                           PuffActor: "KyreiPuffLeft",
                                           HitActorSound: "Sword/HitMeat",
                                           HitWallSound: "Sword/HitWall");
            TNT1 A 0 A_FireCustomMissile("RedParticleSpawner");
            VORL B 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORL C 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORL D 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORL E 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 3 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 A_Refire("Fire");
            Goto PreReady;

        PreReady:
            VORS EDCBA 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            Goto Ready3;

        AltFire:
            TNT1 A 0 A_JumpIfHealthLower(50, "Fire");
            TNT1 A 0 A_Jump(256, "SwingRightyZerked", "SwingLeftyZerked");
            Goto Ready3;

        SwingRightyZerked:
            VORR A 0 Offset(15,32);
            TNT1 A 0 A_JumpIfInventory("PowerStrength", 1, "SwingRightyBladeStorm");
            VORR A 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 A_PlaySound("Sword/Swing", CHAN_WEAPON, 1.0, 0, 2);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: 45, area: 45, dist: 48,
                                           PuffActor: "KyreiPuffRight",
                                           HitActorSound: "Sword/HitMeat",
                                           HitWallSound: "Sword/HitWall");
            TNT1 A 0 A_FireCustomMissile("RedParticleSpawner");
            VORR B 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORR C 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash1",0,1,0,0);
            VORR D 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORR E 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 10 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            Goto PreReady;

        SwingLeftyZerked:
            VORL A 0 Offset(15,32);
            TNT1 A 0 A_JumpIfInventory("PowerStrength", 1, "SwingLeftyBladeStorm");
            VORL A 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 A_PlaySound("Sword/Swing", CHAN_WEAPON, 1.0, 0, 2);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: -45, area: 45, dist: 48,
                                           PuffActor: "KyreiPuffLeft",
                                           HitActorSound: "Sword/HitMeat",
                                           HitWallSound: "Sword/HitWall");
            TNT1 A 0 A_FireCustomMissile("RedParticleSpawner");
            VORL B 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORL C 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash2",0,1,0,0);
            VORL D 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            VORL E 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 10 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            Goto PreReady;

        SwingRightyBladeStorm:
            TNT1 A 0 A_SpawnItemEx("DamageNoArmor10");
            VORR A 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 A_PlaySound("Sword/Swing", CHAN_WEAPON, 1.0, 0, 2);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash1",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: 45, area: 45, dist: 48,
                                           PuffActor: "KyreiPuffRight",
                                           HitActorSound: "Sword/HitMeat",
                                           HitWallSound: "Sword/HitWall");
            TNT1 A 0 A_FireCustomMissile("RedParticleSpawner");
            VORR B 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash1",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: 45, area: 45, dist: 48);
            VORR C 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash1",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: 45, area: 45, dist: 48);
            VORR D 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash1",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: 45, area: 45, dist: 48);
            VORR E 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash1",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: 45, area: 45, dist: 48);
            Goto PreReady;

        SwingLeftyBladeStorm:
            TNT1 A 0 A_SpawnItemEx("DamageNoArmor10");
            VORL A 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 A_PlaySound("Sword/Swing", CHAN_WEAPON, 1.0, 0, 2);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash2",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: -45, area: 45, dist: 48,
                                           PuffActor: "KyreiPuffLeft",
                                           HitActorSound: "Sword/HitMeat",
                                           HitWallSound: "Sword/HitWall");
            TNT1 A 0 A_FireCustomMissile("RedParticleSpawner");
            VORL B 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash2",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: -45, area: 45, dist: 48);
            VORL C 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash2",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: -45, area: 45, dist: 48);
            VORL D 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash2",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: -45, area: 45, dist: 48);
            VORL E 1 A_WeaponReady(WRF_NOBOB|WRF_NOFIRE);
            TNT1 A 0 Bright A_FireProjectile("BladeSlash2",0,1,0,0);
            TNT1 A 0 hxa_CustomRollAttack(damage: 2, healfactor: 0.5, PierceEnemies: FALSE,
                                           roll: -45, area: 45, dist: 48);
            Goto PreReady;

        // Flash overlays (matching PB conventions)
        FlashPunching:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
            Goto HideWeaponDuringAction;
        FlashKicking:
            VORP AAAAAAAAAAAAAAA 1;
            Stop;
        FlashAirKicking:
            VORP AAAAAAAAAAAAAAAA 1;
            Stop;
        FlashSlideKicking:
            VORP AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 1;
            Stop;
        FlashSlideKickingStop:
            VORP AAAAAAA 1;
            Stop;
    }
}

// ----- Helper classes (unchanged from original) -----
class ArgentBloodStone : Inventory 
{
    Default {
        +COUNTITEM
        +INVENTORY.ALWAYSPICKUP
        +FLOAT
        Scale 0.33;
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
        Inventory.PickupMessage "An Argent Core formed from the crystallized blood of a Cyberdemon... The Tiberium Soulblade seems to resonate with it...";
        Inventory.PickupSound "misc/p_pkup";
    }
    States {
        Spawn:
            ARGM A 2 Bright A_SpawnItemEx("RedFlareMedium", 0, 0, 16, 0, 0, 0, 0, SXF_TRANSFERPOINTERS);
            TNT1 AA 0 A_SpawnItemEx("BzrkSphereSpark2",0,0,14,frandom(2.0,-2.0),frandom(2.0,-2.0),frandom(2.0,-2.0),0,32);
            TNT1 A 0 A_SpawnItemEx("BzrkSphereSpark3",0,0,14,frandom(2.0,-2.0),frandom(2.0,-2.0),frandom(0.05,2.0),0,32);
            ARGM A 2 Bright A_SpawnItemEx("RedFlareMedium", 0, 0, 16, 0, 0, 0, 0, SXF_TRANSFERPOINTERS);
            TNT1 AA 0 A_SpawnItemEx("BzrkSphereSpark2",0,0,14,frandom(2.0,-2.0),frandom(2.0,-2.0),frandom(2.0,-2.0),0,32);
            TNT1 A 0 A_SpawnItemEx("BzrkSphereSpark3",0,0,14,frandom(2.0,-2.0),frandom(2.0,-2.0),frandom(0.05,2.0),0,32);
            ARGM A 2 Bright A_SpawnItemEx("RedFlareMedium", 0, 0, 16, 0, 0, 0, 0, SXF_TRANSFERPOINTERS);
            TNT1 AA 0 A_SpawnItemEx("BzrkSphereSpark2",0,0,14,frandom(2.0,-2.0),frandom(2.0,-2.0),frandom(2.0,-2.0),0,32);
            TNT1 A 0 A_SpawnItemEx("BzrkSphereSpark3",0,0,14,frandom(2.0,-2.0),frandom(2.0,-2.0),frandom(0.05,2.0),0,32);
            ARGM A 2 Bright A_SpawnItemEx("RedFlareMedium", 0, 0, 16, 0, 0, 0, 0, SXF_TRANSFERPOINTERS);
            TNT1 AA 0 A_SpawnItemEx("BzrkSphereSpark2",0,0,14,frandom(2.0,-2.0),frandom(2.0,-2.0),frandom(2.0,-2.0),0,32);
            TNT1 A 0 A_SpawnItemEx("BzrkSphereSpark3",0,0,14,frandom(2.0,-2.0),frandom(2.0,-2.0),frandom(0.05,2.0),0,32);
            Loop;
    }
}

class BladeSlash1 : FastProjectile
{
    int SpriteRoll;
    Property SpriteRoll : SpriteRoll;
    Default
    {
        Radius 2; Height 5; Speed 69; Scale 0.55; Damage 25;
        Projectile; RenderStyle "Add"; Alpha 0.2; ReactionTime 10;
        +ROLLSPRITE; +ROLLCENTER; +RIPPER; +BLOODSPLATTER; +NODAMAGETHRUST;
        BladeSlash1.SpriteRoll 0;
    }
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_SetRoll(Random(0,359));
            VFX4 A 0 A_SpawnItemEx("SlashTrail1",0,0,0,0,0,0,0,SXF_TRANSFERROLL);
            VFX4 A 1 Bright A_Countdown;
            Loop;
        Death:
            VFX4 A 1 Bright A_Fadeout(0.33);
            Stop;
    }
}

class BladeSlash2 : FastProjectile
{
    int SpriteRoll;
    Property SpriteRoll : SpriteRoll;
    Default
    {
        Radius 2; Height 5; Speed 69; Scale 0.55; Damage 25;
        Projectile; RenderStyle "Add"; Alpha 0.2; ReactionTime 10;
        +ROLLSPRITE; +ROLLCENTER; +RIPPER; +BLOODSPLATTER; +NODAMAGETHRUST;
        BladeSlash2.SpriteRoll 0;
    }
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_SetRoll(Random(0,359));
            VFX4 C 0 A_SpawnItemEx("SlashTrail2",0,0,0,0,0,0,0,SXF_TRANSFERROLL);
            VFX4 C 1 Bright A_Countdown;
            Loop;
        Death:
            VFX4 C 1 Bright A_Fadeout(0.33);
            Stop;
    }
}

class SlashTrail1 : Actor
{
    Default { Scale 0.45; +ROLLSPRITE; +ROLLCENTER; +NOINTERACTION; }
    States { Spawn: VFX4 B 1 NoDelay Bright A_FadeOut(0.2); Loop; }
}

class SlashTrail2 : Actor
{
    Default { Scale 0.45; +ROLLSPRITE; +ROLLCENTER; +NOINTERACTION; }
    States { Spawn: VFX4 D 1 NoDelay Bright A_FadeOut(0.2); Loop; }
}

// Respect token (needed for PB_RespectIfNeeded)
class VorpalBladeRespect : Inventory
{
    Default { Inventory.MaxAmount 1; }
}
