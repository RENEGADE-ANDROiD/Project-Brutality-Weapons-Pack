
/*
 *
 *		Health Pickups
 *			1%, 2%, 5%
 *
 */
class champion_UniversalHealth_0 : Health
	{
	default
		{
		+INVENTORY.ALWAYSPICKUP;
		Inventory.Amount 	1;
		Inventory.MaxAmount 200;
		}
	}
	
class champion_UniversalHealth_1 : Health
	{
	default
		{
		+INVENTORY.ALWAYSPICKUP;
		Inventory.Amount 	2;
		Inventory.MaxAmount 200;
		}
	}
	
class champion_UniversalHealth_2 : Health
	{
	default
		{
		+INVENTORY.ALWAYSPICKUP;
		Inventory.Amount 	5;
		Inventory.MaxAmount 200;
		}
	}
	
/*
 *
 *		Armor Pickups
 *			1%, 2%, 5%
 *
 */
class champion_UniversalArmor_0 : BasicArmorBonus
	{
	default
		{
		+INVENTORY.ALWAYSPICKUP;
		Armor.SavePercent 	33.335;
		Armor.SaveAmount 	1;
		Armor.MaxSaveAmount 200;
		}
	}
	
class champion_UniversalArmor_1 : BasicArmorBonus
	{
	default
		{
		+INVENTORY.ALWAYSPICKUP;
		Armor.SavePercent 	33.335;
		Armor.SaveAmount 	2;
		Armor.MaxSaveAmount 200;
		}
	}
	
class champion_UniversalArmor_2 : BasicArmorBonus
	{
	default
		{
		+INVENTORY.ALWAYSPICKUP;
		Armor.SavePercent 	33.335;
		Armor.SaveAmount 	5;
		Armor.MaxSaveAmount 200;
		}
	}


/*
 *
 *		Ammo Pickups
 *			1%, 2%, 5% 
 *
 */
class champion_UniversalAmmo_0 : CustomInventory
	{
	default
		{
		+RANDOMIZE;
		}
		
	action void champion_GiveAllAmmo(double percent)
		{
        int end = AllActorClasses.Size ();
        for (int i = 0; i < end; i++) 
			{
            let ammoType = (class<Ammo>) (AllActorClasses [i]);
			
            if (!ammoType)
                continue;

            let ammoDefaults = GetDefaultByType (ammoType);

            if (!ammoDefaults)
                continue;
				
			let ammoCheck = Ammo(GetDefaultByType(ammoType));
			
			if(ammoCheck.GetParentAmmo() != ammoCheck.GetClass())
				continue;
			
			console.Printf("%s",ammoDefaults.GetClassName());
				
			let ammoItem = FindInventory (ammoType,true); 
			if(ammoItem)
				{
				int ammoMaxAmount = (ammoItem ? ammoItem.MaxAmount : ammoDefaults.MaxAmount);
				
				GiveInventory (ammoType, clamp(int (ammoMaxAmount * percent),1,10));
				}
			}
        }
	
	override void PostBeginPlay(void)
		{
		Super.PostBeginPlay();
		
		frame = random(0,2);
		}
	
	states
		{
		Pickup:
			TNT1 A 0 champion_GiveAllAmmo(0.01); 
			stop;
		Spawn:
			UAM1 "#" 35;
			UAM1 "#" 1 Bright;
			loop;
		}
	}
	
class champion_UniversalAmmo_1 : champion_UniversalAmmo_0
	{
	states
		{
		Pickup:
			TNT1 A 0 champion_GiveAllAmmo(0.02); 
			stop;
		Spawn:
			UAM3 "#" 35;
			UAM3 "#" 1 Bright;
			loop;
		}
	}
	
class champion_UniversalAmmo_2 : champion_UniversalAmmo_0
	{
	states
		{
		Pickup:
			TNT1 A 0 champion_GiveAllAmmo(0.05); 
			stop;
		Spawn:
			UAM3 "#" 35;
			UAM3 "#" 1 Bright;
			loop;
		}
	}