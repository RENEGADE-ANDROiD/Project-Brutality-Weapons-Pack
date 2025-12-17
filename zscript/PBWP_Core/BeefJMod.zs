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
					"B92S", "Doomblaster", "HellPistoler", "W_SMG", "P_SMG",
                    "UZISMG", "44PDW",

					// Shotguns
					"PB_Doom2016Shotgun", "PB_CryoShotgun", "PB_CSSG", "RotationalSG", "HASG",
                    "HexaLionShotgun", "M1887", "MarauderSSG", "RotatingDoubleBarrel",

					// Rifles
					"AK-47", "PB_BoltRifle", "Dark_Fate", "HeavySniperRifle",
                    "MagnumSniperRifle", "M41A", "ChthonicRifle",

					// Heavy Weapons
					"PowerOverwhelming", "AutoCannon", "INNailGun", "OldHMG", "D4Machinegun",
                    "INMiniGun", "DukeNukemRipper", "SuperNailgun",

					// Explosives
					"CyberdemonsMissileLauncher", "Devastator", "PB_Excavator", "MastermindChaingun", 
                    "Paingiver", "D4RocketLauncher", "SuperGrenadeLauncher",

					// Plasma Weapons
					"PlasmaRifleAssault", "D4PlasmaGun", "ThunderCarrierTI", "D4VortexRifle", 
                    "D4Machinegun", "Extinction_Ray", "LoRCalamityBlade", "PB_GaussCannon",
                    "Ion_Heavy", "Ballistagun", "PhaseEradicatorBFG",

					// Demonic Weapons
					"TechBlaster", "PB_DemonExt", "HellPistol", "Demon Tech Shotgun", 
                    "PB_LegacyUnmaker", "DemonTechMinigun",

					// Melee/Misc.
					"AncientCrossbow", "PB_BeamKatana", "PB_ArgentSith", "BattleAxe", 
                    "Razorjack", "Fire_and_Ice-DragonSlayer", "PB_MancubusFlameCannon",
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
                    //CSSG Upgrades
                    "DanmakuShellsUpgrade", "WPShellsUpgrade", "ExplosiveShellsUpgrade", "DoomShellsUpgrade",
                    //MSSG Upgrades
                    "MSSGUpgrade", "ColdKeeperUpgrade",
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
				//The rest is the same deal as above
				string pbwp_monsters[] = {
					"HellTrooperPaingiver", "DemonPod", "DeepOne", "EBossCell", 
                    "CyberdemonBoss", "E1Boss",
				""};
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