extend class Champion_Bundle
	{
	void Champion_BuildHereticBundle(void)
		{
		switch(tier)
			{
			case 5:
				champion_PushItem("ArtiTomeOfPower",1);
				champion_PushItem("EnchantedShield",1);
				
			case 4:
				champion_PushItem("ArtiSuperHealth",		1);
				champion_PushItem("SilverShield",	1);
				champion_PushItem("SkullRodHefty",	8);
				champion_PushItem("PhoenixRodHefty",4);
				champion_PushItem("MaceHefty",		4);
				
			case 3:
				champion_PushItem("SkullRodAmmo",	8);
				champion_PushItem("PhoenixRodAmmo",	8);
				champion_PushItem("MaceAmmo",		4);
				
			case 2:
				champion_PushItem("ArtiHealth",		4);
				champion_PushItem("GoldWandHefty",	2);
				champion_PushItem("CrossbowHefty",	2);
				
			case 1:	
				champion_PushItem("CrystalVial",	4);
				
			case 0:
			default:
				champion_PushItem("champion_HealthBonus",		24*(tier+1));
				champion_PushItem("champion_Raven_ArmorBonus",	12*(tier+1));
				champion_PushItem("GoldWandAmmo",				2*(tier+1));
				champion_PushItem("CrossbowAmmo",				1*(tier+1));
					break;
			}
		}
	}
	
class champion_Raven_ArmorBonus : ArmorBonus 
	{
	states
		{
		Spawn:
			ABON ABCDCB 6 Bright;
			loop;
		}
	}