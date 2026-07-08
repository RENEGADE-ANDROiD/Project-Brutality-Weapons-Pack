//Service will allow you to make your own mod have special compatibility with JMod without directly requiring it
//The service class has to have the name "JModService" included, simply add your own prefix to it
Class PBWP_JModService : Service{
	//This is the only function that gets used
	Override string GetString(string request, string stringArg, int intArg, double doubleArg, Object objectArg, Name nameArg){
		//"JModCategory" request will ask for category names you want to add
		If(request=="JModCategory"){
			//This is the method I recommend using: Keeping all the strings inside the array, just make sure to end it with an empty one
			//JMod will request increasing intArgs starting from 0, which will automatically select strings from the array
			string categories[] = {
                "PBWP_Weapons", "PBWP_Upgrades", 
				"PBWP_Equipments", "PBWP_Monsters",
            ""};
			Return categories[intArg];
		}
		//Next request is "JModActor", which will populate the categories with actors
		If(request=="JModActor"){
			//stringArg will be the category name to put the actors into
			If(stringArg=="PBWP_Weapons"){
				//The rest is the same deal as above
				string pbwp_weapons[] = {
					// Pistols
					"B92S", "IN_Beretta", "Doomblaster", "HellPistoler", "W_SMG", "P_SMG",
                    "UZISMG", "44PDW", "LiTRevolver",

					// Shotguns
					"PB_Doom2016Shotgun", "RotationalSG", "HASG",
                    "HexaLionShotgun", "M1887", "MarauderSSG", "RotatingDoubleBarrel",

					// Rifles
					"AK-47", "AssaultR1", "Black_DMR-RKX", "Adv_MaskMan_Rifle", "MaskMan_Rifle", "M1X",
                    "PB_BoltRifle",
                    "MagnumSniperRifle", "PBX_NormalRifle", "ChthonicRifle", "Fallen_Hawk",

					// Heavy Weapons
					"PowerOverwhelming", "AutoCannon", "INNailGun", "OldHMG", "D4Machinegun",
                    "INMiniGun", "ApocalypseKiller", "DukeNukemRipper", "SuperNailgun", "PB_HYDRA",

					// Explosives
					"Devastator",
                    "D4RocketLauncher", "SuperGrenadeLauncher", "PB_Totenheim",

					// Plasma Weapons
					"PlasmaRifleAssault", "D4PlasmaGun", "ThunderCarrierTI", "D4VortexRifle", 
                    "D4Machinegun", "Extinction_Ray", "PB_GaussCannon",
					"Ion_Heavy", "PBX_Prosurv_Ballista", "PhaseEradicatorBFG",

					// Demonic Weapons
					"TechBlaster", "HellPistol", "Demon Tech Shotgun", 
                    "PB_LegacyUnmaker", "Satan_Scream", "DemonTechMinigun",

					// Melee/Misc.
					"AncientCrossbow", "PB_BeamKatana", "PB_ArgentSith", "BattleAxe", 
                    "Razorjack", "PB_MancubusFlameCannon", "DualFlameCannon",
                    "BioAcidLauncher", "Stormcast", "ThunderCrossbow",

					//
				""};
				Return pbwp_weapons[intArg];
			}
            If(stringArg=="PBWP_Upgrades"){
				//The rest is the same deal as above
				string pbwp_upgrades[] = {
                    //D2016 Upgrades
					"PB_D16SGExplosiveUpgrade", "PB_D16SGBurstUpgrade", "PB_D16SGExplosiveUpgrade", 
                    // CSSG upgrades — PBX-Weapons
                    //MSSG Upgrades
                    "PBWP_MSSGUpgrade", "ColdKeeperUpgrade",
                    //Individual Upgrades
                    "HASGDrum", "MachinegunUpgrade", "MGExplosiveUpgrade",
				""};
				Return pbwp_upgrades[intArg];
		    }
            If(stringArg=="PBWP_Equipments"){
				//The rest is the same deal as above
				string pbwp_eq[] = {
					"ShieldGrenade", "VoidGrenade", "AcidCharge", "LaserCharge", 
                    "SwarmCharge", "ElecPod", "ShieldsawAmmo",
				""};
				Return pbwp_eq[intArg];
		    }
            If(stringArg=="PBWP_Monsters"){
				string pbwp_monsters[] = {""};
				Return pbwp_monsters[intArg];
		    }
        }
		//This is the last request, "JModExclude", this one will remove actors from the menu in case you want to hide something
		If(request=="JModExclude"){
			string exclusions[] = {""};
			Return exclusions[intArg];
		}
		//Make sure to return nothing if all else fails
		Return "";
	}
}