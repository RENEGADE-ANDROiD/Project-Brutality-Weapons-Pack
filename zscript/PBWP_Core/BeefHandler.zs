class BeefRiceWeaponDrop : EventHandler
{
    // Check if something is killed
	override void WorldThingDied(WorldEvent e)
	{
        if (!e || !e.thing) return;
        if (!e.thing.bISMONSTER) return;
        let  actor = e.Thing;

        vector3 monsPos = actor.pos;
        double monsHeight = actor.height;
        monsPos.z += monsHeight/2;

        // Get CVARs
        let DTechDrop = CVar.GetCVAR('PBSpawnALLDTechDrop').GetBool();
        let MSSGDrop = CVar.GetCVAR('PBSpawnMSSGDrop').GetBool();
        let PaingiverDrop = CVar.GetCVAR('PBSpawnPaingiverDrop').GetBool();
        let CryoRifleDrop = CVar.GetCVAR('PBSpawnCryoRifleDrop').GetBool();
        let ThunderCrossbowDrop = CVar.GetCVAR('PBSpawnThunderCrossbowDrop').GetBool();
        let StormcastDrop = CVar.GetCVAR('PBSpawnStormcastDrop').GetBool();
        let BioAcidLauncherDrop = CVar.GetCVAR('PBSpawnBioAcidLauncherDrop').GetBool();

        let ShieldGRDrop = CVar.GetCVAR('EQSpawnShieldGR').GetBool();

        // Check what monster was killed
        switch(actor.GetClassName())
        {
            // PBX_MastermindChaingun drops — handled by PBX-Weapons (PBXWeapons_WeaponSpawner)

            case 'PB_DemonTechZombieGK':  
            case 'PB_DemonTechZombie':
                if(DTechDrop){ self.spawnThings("DTechSpawner", monsPos); } 
                break;

            // Monster Pack Stuff
            case 'CyberSatyr':
                if(ShieldGRDrop){ self.spawnThings("ShieldGrenadeDrop", monsPos); } 
                break;

            case 'PB_Marauder':
                if(MSSGDrop){ self.spawnThings("MarauderDropSpawner", monsPos); } 
                break;

            // Frost dark imp / volcabus — Cryo Rifle
            case 'PB_DarkImpST':
            case 'PB_Volcabus':
                if (CryoRifleDrop) { self.spawnThings("PBWP_CryoRifleDrop", monsPos); }
                break;

            // Revenant family — Thunder Crossbow
            case 'PB_Revenant':
            case 'PB_BeamRev':
            case 'PB_Draugr':
                if (ThunderCrossbowDrop) { self.spawnThings("PBWP_ThunderCrossbowDrop", monsPos); }
                break;

            // Arch-vile — Stormcast
            case 'PB_Archvile':
            case 'PB_Hellion':
                if (StormcastDrop) { self.spawnThings("PBWP_StormcastDrop", monsPos); }
                break;

            // Cacodemon — Bio-Acid Launcher
            case 'PB_Cacodemon':
                if (BioAcidLauncherDrop) { self.spawnThings("PBWP_BioAcidLauncherDrop", monsPos); }
                break;

            // Rocket Hell Trooper — Paingiver
            case 'HellTrooper':
            case 'FrozenHellTrooper':
                if (PaingiverDrop) { self.spawnThings("PBWP_PaingiverDrop", monsPos); }
                break;
        }
	}

    // Special cases where something is spawned instead of killed
    override void WorldThingSpawned (WorldEvent e)
    {
        if (!e || !e.thing) return;
        let  actor = e.Thing;

        vector3 monsPos = actor.pos;
        double monsHeight = actor.height;
        monsPos.z += monsHeight/2;

        // Get CVARs
        let MancFLameCNDrop = CVAR.GetCVAR('PBSpawnMancFlameCannonDrop').GetBool();

        // Check and Spawn
        switch(actor.GetClassName())
        {
            // PBX_CyberdemonRL drops — handled by PBX-Weapons (PBXWeapons_WeaponSpawner)

            case 'PB_FlamethrowerMancubusGas':
                if(MancFLameCNDrop)
                { 
                    self.spawnThings("PB_MancubusFlameDrop", monsPos);
                    self.destroy(); 
                } 
                break;
            // SPECIAL CASE FOR THE AXE
           /* case 'PB_Axe':
                self.spawnThings("AxePickup", monsPos);
                //self.destroy();
                break;*/
        }
    }

    // Spawn Function
    void spawnThings(string className, vector3 monsPos)
    {
        actor.Spawn(className, monsPos);
    }
}

class BeefModChecker : EventHandler
{
    override void WorldLoaded (WorldEvent e)
    {
        // Dragon Sector addon probe (external mod; not PBWP magnet)
        string dragonSectorProbe = "DS_HealthBonus";
        class <actor> dragonSectorPresent = dragonSectorProbe;

        // Custom Marines
        string cmcompat = "Marine_SpawnRifle";
        class <actor> iscmcompat = cmcompat; 

        // GloryKill
        string gkcompat = "ASGGuyGK";
        class <actor> isgkcompat = gkcompat;

        // PBX-Weapons (optional addon)
        string pbxcompat = "PBX_PlasmaBlaster";
        class <actor> ispbxcompat = pbxcompat;

        if (ispbxcompat)
            CVar.FindCVar('isPBXLoaded').SetBool(true);
        else
        {
            CVar.FindCVar('isPBXLoaded').SetBool(false);
            console.printf("\x1b[1;33mPBWP:\x1b[0m PBX-Weapons not loaded — PBX weapon spawns, drops, and scroll slots are disabled.");
        }

        if (dragonSectorPresent)
            CVAR.FindCVar('pbwp_compat_dragonsector').SetBool(true);
        else
            CVAR.FindCVar('pbwp_compat_dragonsector').SetBool(false);

        // Check if CustomMarines is loaded
        if(iscmcompat)
        {
            CVAR.FindCVar('isCMLoaded').SetBool(true);
        }
        else
        {
            CVAR.FindCVar('isCMLoaded').SetBool(false);
        }

         // Check if GloryKill is loaded (cvar from Glory Kills pk3 when present)
        let gkCv = CVar.FindCVar('isGKLoaded');
        if (gkCv)
        {
            if (isgkcompat)
                gkCv.SetBool(true);
            else
                gkCv.SetBool(false);
        }
        else if (!isgkcompat)
        {
            console.printf("\x1b[1;33mPBWP:\x1b[0m Glory Kills not loaded — using PB fatality executions only.");
        }
    }
}

class BeefMiscHandler : EventHandler
{
    // Toggle Magnets
    override void NetworkProcess(ConsoleEvent e)
    {
        let pmo = players[consoleplayer].mo;
        if (e.Name == "PBWP_MagnetModeOn")
		{
			let mag = PBWP_ItemMagnet(pmo.FindInventory("PBWP_ItemMagnet"));
			if (mag)
			{
                console.printf("PBWP item magnet enabled");
				mag.IsMagnetOn = true;
			}
		}
		if (e.Name == "PBWP_MagnetModeOff")
		{
			let mag = PBWP_ItemMagnet(pmo.FindInventory("PBWP_ItemMagnet"));
			if (mag)
			{
                console.printf("PBWP item magnet disabled");
				mag.IsMagnetOn = false;
			}
		}
    }

    // Sets the Monster Drop to Ammo Only when first starting the mod
    Override void WorldLoaded (WorldEvent e)
    {
        // Sets the PB Monster Drop to Just Ammo on First Time Loading
        if (!FirstTimeLoadingPBWP) return;
        let weaponDrops = CVar.FindCVar('PB_WeaponDrops');
        if (weaponDrops)
            weaponDrops.SetInt(0);
        let firstLoad = CVar.FindCVar('FirstTimeLoadingPBWP');
        if (firstLoad)
            firstLoad.SetBool(false);
        //destroy();
    }

    // Fix the ShieldSaw bug
    Override void PlayerEntered(PlayerEvent e)
    {
        let pm = players[e.PlayerNumber].mo;
		if(!pm)
			return;
        bool FindInvAlreadyThrow = pm.FindInventory("AlreadyThrownShieldSaw");
        bool FindInvShieldAmmo = pm.FindInventory("ShieldSawAmmo");

        if(FindInvAlreadyThrow && FindInvShieldAmmo)
        {
            pm.giveinventory("ShieldSawAmmo",1);
        }
        return;
    }
}

class BeefMeleeDrop : EventHandler
{
    override void WorldThingDied(WorldEvent e)
	{
        if (!e || !e.thing) return;
        if (!e.thing.bISMONSTER) return;
        if(!AllMeleeDrop) return;
        let actor = e.thing;
        int monsHealth = actor.getMaxHealth();  

        if (monsHealth <= 20) return;
        if (monsHealth >= 200) return;
        if (Random(1, 100) >= 10) return; // 20-200 HP monsters: 10% chance for a tier-scaled melee drop
        //console.printf("Spawn Succesful");
        actor.A_SpawnItemEx('MeleeDropSpawner', 0, 0, 0, frandom(0.5, 2.0), 0, frandom(1.0, 4.0), random(0, 359), SXF_NOCHECKPOSITION);
    } 
}

class BeefCustomAmmoDrop : EventHandler
{
    override void WorldThingDied(WorldEvent e)
	{
        if (!e || !e.thing) return;
        if (!e.thing.bISMONSTER) return;
        let player = e.thing.target;
        PlayerPawn pm = PlayerPawn(player);
        if (!pm)
            return;
        if (!GC_Enhancements.ComplexAmmo(pm.player))
            return;
        int monsHealth = e.Thing.getMaxHealth();

        if (monsHealth > 1000)
        {
            pm.A_GiveInventory("PBWP_ComplexAmmo", 100);
        }
        else if (monsHealth >= 500) // 500–1000
        {
            pm.A_GiveInventory("PBWP_ComplexAmmo", 50);
        }
        else if (monsHealth >= 150) // 150–499
        {
            pm.A_GiveInventory("PBWP_ComplexAmmo", 10);
        }
        else if (monsHealth >= 20) // 20–149
        {
            pm.A_GiveInventory("PBWP_ComplexAmmo", 5);
        }
    } 
}


// Spawn presets moved to PBWP_WeaponPackPresets.zs
class BeefSpawnPresets : StaticEventHandler
{
}
