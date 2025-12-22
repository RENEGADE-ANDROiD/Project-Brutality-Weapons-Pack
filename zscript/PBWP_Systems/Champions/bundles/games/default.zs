extend class Champion_Bundle
	{
	void Champion_BuildGenericBundle(void)
		{
		switch(tier)
			{
			case 5:
				champion_PushItem("champion_UniversalHealth_2",	4);
				champion_PushItem("champion_UniversalArmor_2",	4);
				champion_PushItem("champion_UniversalAmmo_2",	8);
				
			case 4:
				champion_PushItem("champion_UniversalHealth_2",	2);
				champion_PushItem("champion_UniversalArmor_2",	2);
				champion_PushItem("champion_UniversalAmmo_2",	2);
				
			case 3:	
				champion_PushItem("champion_UniversalAmmo_1",	4);
				
			case 2:
				champion_PushItem("champion_UniversalHealth_1",	4);
				champion_PushItem("champion_UniversalArmor_1",	4);
				champion_PushItem("champion_UniversalAmmo_1",	4);
				
			case 1:
				champion_PushItem("champion_UniversalAmmo_0",	4);
				
			case 0:
			default:
				champion_PushItem("champion_UniversalHealth_0",	64+(8*tier));
				champion_PushItem("champion_UniversalArmor_0",	64+(8*tier));
					break;
			}
		}
	}