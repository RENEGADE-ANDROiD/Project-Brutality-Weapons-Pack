extend class Champion_Bundle
	{
	void Champion_BuildDoomBundle(void)
		{
		switch(tier)
			{
			case 5:
				champion_PushItem("SoulSphere",	1);
				champion_PushItem("BlueArmor",	1);
				
			case 4:
				champion_PushItem("Berserk",	1);
				champion_PushItem("GreenArmor",	1);
				champion_PushItem("CellPack",	2);
				champion_PushItem("RocketBox",	2);
				
			case 3:
				champion_PushItem("Cell",		4);
				champion_PushItem("RocketAmmo",	4);
				
			case 2:
				champion_PushItem("Medikit",	4);
				champion_PushItem("ClipBox",	2);
				champion_PushItem("ShellBox",	2);
				
			case 1:	
				champion_PushItem("Stimpack",	4);
				champion_PushItem("Clip",		4*(tier+1));
				champion_PushItem("Shell",		2*(tier+1));
				
			case 0:
			default:
				string drop = (champion_static.champion_ReturnCVAR("champion_HealthFoods"))? "champion_HealthBonus" : "HealthBonus";
				champion_PushItem(drop,	24*(tier+1));
					
				champion_PushItem("ArmorBonus",		12*(tier+1));
				champion_PushItem("Clip",			2*((tier*2)+1));
				champion_PushItem("Shell",			1*((tier*2)+1));
					break;
			}
		}
	}