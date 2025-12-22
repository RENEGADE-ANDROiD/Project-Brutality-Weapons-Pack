extend class Champion_Bundle
	{
	void Champion_BuildHexenBundle(void)
		{
		switch(tier)
			{
			case 5:
				champion_PushItem("ArtiPork",1);
				champion_PushItem("ArtiDarkServant",1);
				
			case 4:
				champion_PushItem("ArtiSuperHealth",1);
				
			case 3:
				champion_PushItem("HexenArmorDropper",	1);
				
			case 2:
				champion_PushItem("ArtiHealth",		2);
				
			case 1:	
				champion_PushItem("CrystalVial",	2);
				
			case 0:
			default:
				champion_PushItem("champion_HealthBonus",		16*(tier+1));
				champion_PushItem("champion_HexenBundle_Mana1",	2*(tier+1));
				champion_PushItem("champion_HexenBundle_Mana2",	2*(tier+1));
					break;
			}
		}
	}
	
class HexenArmorDropper : RandomSpawner 
	{
	default
		{
		DropItem "FalconShield";
		DropItem "AmuletOfWarding";
		DropItem "MeshArmor";
		DropItem "PlatinumHelm";
		}
	}
	
class champion_HexenBundle_Health : HealthBonus { }

class champion_HexenBundle_Mana1 : Mana1
	{
	default
		{
		scale 0.5;
		inventory.PickupMessage "Fragment of Blue Mana";
		inventory.Amount 1;
		}
	}
	
class champion_HexenBundle_Mana2 : Mana2
	{
	default
		{
		scale 0.5;
		inventory.PickupMessage "Fragment of Green Mana";
		inventory.Amount 1;
		}
	}

	