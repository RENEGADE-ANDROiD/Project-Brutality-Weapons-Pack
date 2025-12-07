//Service will allow you to make your own mod have special compatibility with JMod without directly requiring it
//The service class has to have the name "JModService" included, simply add your own prefix to it
Class SinJModService : Service{
	//This is the only function that gets used
	Override string GetString(string request, string stringArg, int intArg, double doubleArg, Object objectArg, Name nameArg){
		//"JModCategory" request will ask for category names you want to add
		If(request=="JModCategory"){
			//This is the method I recommend using: Keeping all the strings inside the array, just make sure to end it with an empty one
			//JMod will request increasing intArgs starting from 0, which will automatically select strings from the array
			string categories[] = {
                "PBWP Small Arms", "PBWP Shotguns", "PBWP Rifles", "PBWP Heavy Weapons", 
                "PBWP Explosives", "PBWP Plasma Weapons", "PBWP Demonic Weapons", "PBWP Misc.", 
                "PBWP Upgrades", "PBWP Equipments", "PBWP Monsters",
            ""};
			Return categories[intArg];
		}
		//Next request is "JModActor", which will populate the categories with actors
		If(request=="JModActor"){
			//stringArg will be the category name to put the actors into
			If(stringArg=="PBWP Small Arms"){
				//The rest is the same deal as above
				string pbwp_pistols[] = {
					"B92S", "Doomblaster", "HellPistoler", "W_SMG", "P_SMG",
                    "UZISMG", "44PDW",
				""};
				Return pbwp_pistols[intArg];
			}
            If(stringArg=="PBWP Shotguns"){
				//The rest is the same deal as above
				string pbwp_shotguns[] = {
					"PB_Doom2016Shotgun", "PB_CryoShotgun", "PB_CSSG", "RotationalSG", "HASG",
                    "HexaLionShotgun", "M1887", "MarauderSSG", "RotatingDoubleBarrel",
				""};
				Return pbwp_shotguns[intArg];
			}
            If(stringArg=="PBWP Rifles"){
				//The rest is the same deal as above
				string pbwp_rifles[] = {
					"AK-47", "PB_BoltRifle", "Dark_Fate", "HeavySniperRifle",
                    "MagnumSniperRifle", "M41A", "ChthonicRifle",
				""};
				Return pbwp_rifles[intArg];
			}
            If(stringArg=="PBWP Heavy Weapons"){
				//The rest is the same deal as above
				string pbwp_heavies[] = {
					"PowerOverwhelming", "AutoCannon", "INNailGun", "OldHMG", "D4Machinegun",
                    "INMiniGun", "DukeNukemRipper", "SuperNailgun",
				""};
				Return pbwp_heavies[intArg];
			}
            If(stringArg=="PBWP Explosives"){
				//The rest is the same deal as above
				string pbwp_explosives[] = {
					"CyberdemonsMissileLauncher", "Devastator", "PB_Excavator", "MastermindChaingun", 
                    "Paingiver", "D4RocketLauncher", "SuperGrenadeLauncher",
				""};
				Return pbwp_explosives[intArg];
		    }
            If(stringArg=="PBWP Plasma Weapons"){
				//The rest is the same deal as above
				string pbwp_plasmas[] = {
					"PlasmaRifleAssault", "D4PlasmaGun", "ThunderCarrierTI", "D4VortexRifle", 
                    "D4Machinegun", "Extinction_Ray", "LoRCalamityBlade", "PB_GaussCannon",
                    "Ion_Heavy", "Ballistagun", "PhaseEradicatorBFG",
				""};
				Return pbwp_plasmas[intArg];
			}
            If(stringArg=="PBWP Demonic Weapons"){
				//The rest is the same deal as above
				string pbwp_demonic[] = {
					"TechBlaster", "PB_DemonExt", "HellPistol", "Demon Tech Shotgun", 
                    "PB_LegacyUnmaker", "DemonTechMinigun",
				""};
				Return pbwp_demonic[intArg];
			}
            If(stringArg=="PBWP Misc."){
				//The rest is the same deal as above
				string pbwp_misc[] = {
					"AncientCrossbow", "PB_BeamKatana", "PB_ArgentSith", "BattleAxe", 
                    "Razorjack", "Fire_and_Ice-DragonSlayer", "PB_MancubusFlameCannon",
                    "BioAcidLauncher", "Stormcast", "ThunderCrossbow",
				""};
				Return pbwp_misc[intArg];
		    }
            If(stringArg=="PBWP Misc."){
				//The rest is the same deal as above
				string pbwp_misc[] = {
					"AncientCrossbow", "PB_BeamKatana", "PB_ArgentSith", "BattleAxe", 
                    "Razorjack", "Fire_and_Ice-DragonSlayer", "PB_MancubusFlameCannon",
                    "BioAcidLauncher", "Stormcast", "ThunderCrossbow",
				""};
				Return pbwp_misc[intArg];
		    }
            If(stringArg=="PBWP Upgrades"){
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
            If(stringArg=="PBWP Equipments"){
				//The rest is the same deal as above
				string pbwp_eq[] = {
					"ShieldGrenade", "VoidGrenade", "AcidCharge", "LaserCharge", 
                    "SwarmCharge", "ElecPod", "ShieldsawAmmo",
				""};
				Return pbwp_eq[intArg];
		    }
            If(stringArg=="PBWP Monsters"){
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
			string exclusions[] = {"SinTest","SinShellBoxSarge","SinAncientRifleTacticool",""};
			Return exclusions[intArg];
		}
		//Make sure to return nothing if all else fails
		Return "";
	}
}