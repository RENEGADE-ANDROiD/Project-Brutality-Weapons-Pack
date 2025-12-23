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
        let DTechDrop = CVar.GetCVAR('PBSpawnALLDTechDrop').GetInt();
        let MSSGDrop = CVar.GetCVAR('PBSpawnMSSGDrop').GetInt();
        let MastermindCGDrop = CVar.GetCVAR('PBSpawnMastermindCGDrop').GetInt();
        let PaingiverDrop = CVar.GetCVAR('PBSpawnPaingiverDrop').GetInt();

        let ShieldGRDrop = CVar.GetCVAR('EQSpawnShieldGR').GetInt();

        // Check what monster was killed
        switch(actor.GetClassName())
        {
            // Different Monsters spawn Different Things
            // Custom Monsters
            case 'HellTrooperPaingiver':
                if(PaingiverDrop == 1) { self.spawnThings("Paingiver", monsPos); } // ALWAYS DROP PAINGIVER
                break;

            //case 'PB_JuggernautGK': //Should we make the Juggernaut Drop MastermindCG?
            case 'PB_MastermindGK': 
            case 'PB_DemolisherGK': 
            case 'PB_Mastermind': 
            case 'PB_Demolisher':
                if(MastermindCGDrop == 1) { self.spawnThings("MastermindChaingun", monsPos); } // ALWAYS DROP MASTERMIND CG
                break;

            case 'PB_DemonTechZombieGK':  
            case 'PB_DemonTechZombie':
                if(DTechDrop == 1){ self.spawnThings("DTechSpawner", monsPos); } 
                break;

            // Monster Pack Stuff
            case 'CyberSatyr':
                if(ShieldGRDrop == 1){ self.spawnThings("ShieldGrenadeDrop", monsPos); } 
                break;

            case 'PB_Marauder':
                if(MSSGDrop == 1){ self.spawnThings("MarauderDropSpawner", monsPos); } 
                break;

            // PB Monsters 
            // Add more here 
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
        let MancFLameCNDrop = CVAR.GetCVAR('PBSpawnMancFlameCannonDrop').GetInt();
        let CyberRLDrop = CVar.GetCVAR('PBSpawnCyberdemonRLDrop').GetInt();

        // Check and Spawn
        switch(actor.GetClassName())
        {
            case 'XDeathCyberdemonGun':
                if(CyberRLDrop == 1)
                { 
                    self.spawnThings("CyberdemonsMissileLauncher", monsPos);
                    self.destroy(); 
                } 
                break;

            case 'PB_FlamethrowerMancubusGas':
                if(MancFLameCNDrop == 1)
                { 
                    self.spawnThings("MancubusFlameCannon", monsPos);
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
        // Dragon Sector
        string DScompat = "DS_HealthBonus";
        class <actor> isDScompat = DScompat; 

        // Custom Marines
        string cmcompat = "Marine_SpawnRifle";
        class <actor> iscmcompat = cmcompat; 

        // GloryKill
        string gkcompat = "ASGGuyGK";
        class <actor> isgkcompat = gkcompat; 

        // Check if DragonSector is loaded
        if(isDScompat)
        {
            CVAR.FindCVar('isDSLoaded').SetBool(true);
        }
        else
        {
            CVAR.FindCVar('isDSLoaded').SetBool(false);
        }

        // Check if CustomMarines is loaded
        if(iscmcompat)
        {
            CVAR.FindCVar('isCMLoaded').SetBool(true);
        }
        else
        {
            CVAR.FindCVar('isCMLoaded').SetBool(false);
        }

         // Check if GloryKill is loaded
        if(isgkcompat)
        {
            CVAR.FindCVar('isGKLoaded').SetBool(true);
        }
        else
        {
            CVAR.FindCVar('isGKLoaded').SetBool(false);
        }
    }
}

class BeefMiscHandler : EventHandler
{
    // Toggle Magnets
    override void NetworkProcess(ConsoleEvent e)
    {
        let pmo = players[consoleplayer].mo;
        if (e.Name == "MagnetModeOn")
		{
			let mag = PBWP_ItemMagnet(pmo.FindInventory("PBWP_ItemMagnet"));
			if (mag)
			{
                console.printf("Magnet Enabled");
				mag.IsMagnetOn = true;
			}
		}
		if (e.Name == "MagnetModeOff")
		{
			let mag = PBWP_ItemMagnet(pmo.FindInventory("PBWP_ItemMagnet"));
			if (mag)
			{
                console.printf("Magnet Disabled");
				mag.IsMagnetOn = false;
			}
		}
    }

    // Sets CVARs and Check Loaded Mods
    Override void WorldLoaded (WorldEvent e)
    {
        // Sets the PB Monster Drop to Just Ammo on First Time Loading
        if (!FirstTimeLoadingPBWP) return;
        CVAR.FindCVar('PB_WeaponDrops').SetInt(0);
        CVAR.FindCVar('FirstTimeLoadingPBWP').SetBool(false);
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
        if (Random(1, 100) >= 20) return; // BASICALLY, BETWEEN 20-200 HP WILL HAVE A 20% CHANCE OF SPAWNING
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
        int monsHealth = e.Thing.getMaxHealth();  
        let player = e.thing.target;
        PlayerPawn pm = PlayerPawn(player);

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


// Spawn Presets
// This is a pretty rough implementation and I can probaly use switch cases for this
// But for now it'll do

class BeefSpawnPresets : StaticEventHandler
{
    override void NetworkProcess(ConsoleEvent e)
    {
        let LookForPresets = e.Name;
        if(LookForPresets ~== "PBWP_EnableAll")
        {
            CVAR.FindCVar('PBSpawnArgentSith').SetBool(true);
            CVAR.FindCVar('PBSpawnBattleAxe').SetBool(true);
            CVAR.FindCVar('PBSpawnRazorjack').SetBool(true);
            //Slot 2
            CVAR.FindCVar('PBSpawnSilverhandsDeagle').SetBool(true);
            CVAR.FindCVar('PBSpawnHellPistol').SetBool(true);
            CVAR.FindCVar('PBSpawnHellPistoler').SetBool(true);
            CVAR.FindCVar('PBSpawnW_SMG').SetBool(true);
            //Slot 3
            CVAR.FindCVar('PBSpawnPB_Doom2016Shotgun').SetBool(true);
            CVAR.FindCVar('PBSpawnPB_CryoShotgun').SetBool(true);
            CVAR.FindCVar('PBSpawnPB_CSSG').SetBool(true);
            CVAR.FindCVar('PBSpawnRotationalSG').SetBool(true);
            CVAR.FindCVar('PBSpawnHASG').SetBool(true);
            CVAR.FindCVar('PBSpawnHexaLionShotgun').SetBool(true);
            CVAR.FindCVar('PBSpawnDemonTechShotgun').SetBool(true);
            CVAR.FindCVar('PBSpawnM1887').SetBool(true);
            CVAR.FindCVar('PBSpawnMarauderSSG').SetBool(true);
            CVAR.FindCVar('PBSpawnRotatingDoubleBarrel').SetBool(true);
            //Slot 4
            CVAR.FindCVar('PBSpawnAK47').SetBool(true);
            CVAR.FindCVar('PBSpawnPB_BoltRifle').SetBool(true);
            CVAR.FindCVar('PBSpawnDark_Fate').SetBool(true);
            CVAR.FindCVar('PBSpawnHeavySniperRifle').SetBool(true);
            CVAR.FindCVar('PBSpawnMagnumSniperRifle').SetBool(true);
            CVAR.FindCVar('PBSpawnM41A').SetBool(true);
            CVAR.FindCVar('PBSpawnPowerOverwhelming').SetBool(true);
            //Slot 5
            CVAR.FindCVar('PBSpawnFire_and_IceDragonSlayer').SetBool(true);
            CVAR.FindCVar('PBSpawnINNailGun').SetBool(true);
            CVAR.FindCVar('PBSpawnOldHMG').SetBool(true);
            CVAR.FindCVar('PBSpawnD4Machinegun').SetBool(true);
            CVAR.FindCVar('PBSpawnINMiniGun').SetBool(true);
            CVAR.FindCVar('PBSpawnDukeNukemRipper').SetBool(true);
            CVAR.FindCVar('PBSpawnSuperNailgun').SetBool(true);
            //Slot 6
            CVAR.FindCVar('PBSpawnChthonicRifle').SetBool(true);
            CVAR.FindCVar('PBSpawnCyberdemonsMissileLauncher').SetBool(true);
            CVAR.FindCVar('PBSpawnDevastator').SetBool(true);
            CVAR.FindCVar('PBSpawnPB_Excavator').SetBool(true);
            CVAR.FindCVar('PBSpawnMastermindChaingun').SetBool(true);
            CVAR.FindCVar('PBSpawnPaingiver').SetBool(true);
            CVAR.FindCVar('PBSpawnD4RocketLauncher').SetBool(true);
            CVAR.FindCVar('PBSpawnSuperGrenadeLauncher').SetBool(true);
            //Slot 7
            CVAR.FindCVar('PBSpawnPlasmaRifleAssault').SetBool(true);
            CVAR.FindCVar('PBSpawnD4PlasmaGun').SetBool(true);
            CVAR.FindCVar('PBSpawnThunderCarrierTI').SetBool(true);
            CVAR.FindCVar('PBSpawnD4VortexRifle').SetBool(true);
            //Slot 8
            CVAR.FindCVar('PBSpawnExtinction_Ray').SetBool(true);
            CVAR.FindCVar('PBSpawnCalamityBlade').SetBool(true);
            CVAR.FindCVar('PBSpawnPB_GaussCannon').SetBool(true);
            CVAR.FindCVar('PBSpawnIon_Heavy').SetBool(true);
            CVAR.FindCVar('PBSpawnPB_MancubusFlameCannon').SetBool(true);
            //Slot 9
            CVAR.FindCVar('PBSpawnBioAcidLauncher').SetBool(true);
            CVAR.FindCVar('PBSpawnBallistagun').SetBool(true);
            CVAR.FindCVar('PBSpawnLegacyUnmaker').SetBool(true);
            CVAR.FindCVar('PBSpawnStormcast').SetBool(true);
            CVAR.FindCVar('PBSpawnThunderCrossbow').SetBool(true);
            //Slot 0
            CVAR.FindCVar('PBSpawnAncientCrossbow').SetBool(true);
            CVAR.FindCVar('PBSpawnTechBlaster').SetBool(true);
            CVAR.FindCVar('PBSpawnPB_DemonExt').SetBool(true);
            CVAR.FindCVar('PBSpawnDemonTechMinigun').SetBool(true);
            CVAR.FindCVar('PBSpawnPhaseEradicatorBFG').SetBool(true);
        }
        else if(LookForPresets ~== "PBWP_DisableAll")
        {
            CVAR.FindCVar('PBSpawnArgentSith').SetBool(false);
            CVAR.FindCVar('PBSpawnArgentSith').SetBool(false);
            CVAR.FindCVar('PBSpawnBattleAxe').SetBool(false);
            CVAR.FindCVar('PBSpawnRazorjack').SetBool(false);
            //Slot 2
            CVAR.FindCVar('PBSpawnSilverhandsDeagle').SetBool(false);
            CVAR.FindCVar('PBSpawnHellPistol').SetBool(false);
            CVAR.FindCVar('PBSpawnHellPistoler').SetBool(false);
            CVAR.FindCVar('PBSpawnW_SMG').SetBool(false);
            //Slot 3
            CVAR.FindCVar('PBSpawnPB_Doom2016Shotgun').SetBool(false);
            CVAR.FindCVar('PBSpawnPB_CryoShotgun').SetBool(false);
            CVAR.FindCVar('PBSpawnPB_CSSG').SetBool(false);
            CVAR.FindCVar('PBSpawnRotationalSG').SetBool(false);
            CVAR.FindCVar('PBSpawnHASG').SetBool(false);
            CVAR.FindCVar('PBSpawnHexaLionShotgun').SetBool(false);
            CVAR.FindCVar('PBSpawnDemonTechShotgun').SetBool(false);
            CVAR.FindCVar('PBSpawnM1887').SetBool(false);
            CVAR.FindCVar('PBSpawnMarauderSSG').SetBool(false);
            CVAR.FindCVar('PBSpawnRotatingDoubleBarrel').SetBool(false);
            //Slot 4
            CVAR.FindCVar('PBSpawnAK47').SetBool(false);
            CVAR.FindCVar('PBSpawnPB_BoltRifle').SetBool(false);
            CVAR.FindCVar('PBSpawnDark_Fate').SetBool(false);
            CVAR.FindCVar('PBSpawnHeavySniperRifle').SetBool(false);
            CVAR.FindCVar('PBSpawnMagnumSniperRifle').SetBool(false);
            CVAR.FindCVar('PBSpawnM41A').SetBool(false);
            CVAR.FindCVar('PBSpawnPowerOverwhelming').SetBool(false);
            //Slot 5
            CVAR.FindCVar('PBSpawnFire_and_IceDragonSlayer').SetBool(false);
            CVAR.FindCVar('PBSpawnINNailGun').SetBool(false);
            CVAR.FindCVar('PBSpawnOldHMG').SetBool(false);
            CVAR.FindCVar('PBSpawnD4Machinegun').SetBool(false);
            CVAR.FindCVar('PBSpawnINMiniGun').SetBool(false);
            CVAR.FindCVar('PBSpawnDukeNukemRipper').SetBool(false);
            CVAR.FindCVar('PBSpawnSuperNailgun').SetBool(false);
            //Slot 6
            CVAR.FindCVar('PBSpawnChthonicRifle').SetBool(false);
            CVAR.FindCVar('PBSpawnCyberdemonsMissileLauncher').SetBool(false);
            CVAR.FindCVar('PBSpawnDevastator').SetBool(false);
            CVAR.FindCVar('PBSpawnPB_Excavator').SetBool(false);
            CVAR.FindCVar('PBSpawnMastermindChaingun').SetBool(false);
            CVAR.FindCVar('PBSpawnPaingiver').SetBool(false);
            CVAR.FindCVar('PBSpawnD4RocketLauncher').SetBool(false);
            CVAR.FindCVar('PBSpawnSuperGrenadeLauncher').SetBool(false);
            //Slot 7
            CVAR.FindCVar('PBSpawnPlasmaRifleAssault').SetBool(false);
            CVAR.FindCVar('PBSpawnD4PlasmaGun').SetBool(false);
            CVAR.FindCVar('PBSpawnThunderCarrierTI').SetBool(false);
            CVAR.FindCVar('PBSpawnD4VortexRifle').SetBool(false);
            //Slot 8
            CVAR.FindCVar('PBSpawnExtinction_Ray').SetBool(false);
            CVAR.FindCVar('PBSpawnCalamityBlade').SetBool(false);
            CVAR.FindCVar('PBSpawnPB_GaussCannon').SetBool(false);
            CVAR.FindCVar('PBSpawnIon_Heavy').SetBool(false);
            CVAR.FindCVar('PBSpawnPB_MancubusFlameCannon').SetBool(false);
            //Slot 9
            CVAR.FindCVar('PBSpawnBioAcidLauncher').SetBool(false);
            CVAR.FindCVar('PBSpawnBallistagun').SetBool(false);
            CVAR.FindCVar('PBSpawnLegacyUnmaker').SetBool(false);
            CVAR.FindCVar('PBSpawnStormcast').SetBool(false);
            CVAR.FindCVar('PBSpawnThunderCrossbow').SetBool(false);
            //Slot 0
            CVAR.FindCVar('PBSpawnAncientCrossbow').SetBool(false);
            CVAR.FindCVar('PBSpawnTechBlaster').SetBool(false);
            CVAR.FindCVar('PBSpawnPB_DemonExt').SetBool(false);
            CVAR.FindCVar('PBSpawnDemonTechMinigun').SetBool(false);
            CVAR.FindCVar('PBSpawnPhaseEradicatorBFG').SetBool(false);
        }
    }
}