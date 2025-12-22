extend class Champion_Bundle
	{
	void Champion_BuildChexBundle(void)
		{
		switch(tier)
			{
			case 5:
				champion_PushItem("SuperchargeBreakfast",	1);
				champion_PushItem("SuperChexArmor",	1);
				
			case 4:
				champion_PushItem("ChexArmor",	1);
				champion_PushItem("PhasingZorchPack",	2);
				champion_PushItem("PropulsorZorchPack",	2);
				
			case 3:
				champion_PushItem("PhasingZorch",		4);
				champion_PushItem("PropulsorZorch",	4);
				
			case 2:
				champion_PushItem("BowlOfVegetables",	4);
				champion_PushItem("MiniZorchRecharge",	2);
				champion_PushItem("LargeZorchRecharge",	2);
				
			case 1:	
				champion_PushItem("BowlOfFruit",	4);
				champion_PushItem("MiniZorchPack",	4);
				champion_PushItem("LargeZorchPack",		4);
				
			case 0:
			default:
				champion_PushItem("champion_HealthBonus",	32+(4*tier));
				//champion_PushItem("ArmorBonus",		32+(4*tier));
					break;
			}
		}
	}