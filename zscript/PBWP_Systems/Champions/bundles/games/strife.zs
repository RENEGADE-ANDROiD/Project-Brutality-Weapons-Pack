extend class Champion_Bundle
	{
	void Champion_BuildStrifeBundle(void)
		{
		switch(tier)
			{
			case 5:
				champion_PushItem("SurgeryKit",		1);
				champion_PushItem("MetalArmor",		1);
				champion_PushItem("HEGrenadeRounds",1);
				champion_PushItem("PhosphorusGrenadeRounds",1);
				champion_PushItem("Gold50",			2);
				
			case 4:
				champion_PushItem("ArtiSuperHealth",1);
				champion_PushItem("LeatherArmor",	1);
				champion_PushItem("EnergyPack",		8);
				champion_PushItem("CrateOfMissiles",4);
				champion_PushItem("Gold25",			2);
				
			case 3:
				champion_PushItem("EnergyPod",		8);
				champion_PushItem("CrateOfMissiles",8);
				champion_PushItem("Gold25",			2);
				
			case 2:
				champion_PushItem("MedicalKit",		4);
				champion_PushItem("BoxOfBullets",	4);
				champion_PushItem("PoisonBolts",	2);
				champion_PushItem("MiniMissiles",	8);
				champion_PushItem("Gold10",			2);
				
			case 1:	
				champion_PushItem("MedPatch",		4);
				champion_PushItem("ClipOfBullets",	8);
				champion_PushItem("ElectricBolts",	10);
				champion_PushItem("Gold10",			2);
				
			case 0:
			default:
				champion_PushItem("champion_HealthBonus",	32+(4*tier));
				champion_PushItem("ElectricBolts",	2);
				champion_PushItem("ClipOfBullets",	2);
				//champion_PushItem("ArmorBonus",		32+(4*tier));
				champion_PushItem("Coin",			32+(4*tier));
				break;
			}
		}
	}