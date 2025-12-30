class KillStreakPowerUp : Inventory replaces MegaSphere
{
	Default
	{
		Inventory.PickupMessage "You got a Random Power Up!";
		Inventory.PickupSound "misc/p_pkup";
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.INTERHUBSTRIP;
		+INVENTORY.AUTOACTIVATE;
		Inventory.Icon "MEGA0";
	}
	
	override bool Use(bool pickup)
	{
		// Generate a random number 0-11
		int choice = random(0, 11);
		Class<Inventory> powerup;
		
		// Select the powerup based on random choice
		switch(choice)
		{
		case 0:
			powerup = "CoffeeTime";
			break;
		case 1:
			powerup = "TFST";
			break;
		case 2:
			powerup = "AmmoSphere";
			break;
		case 3:
			powerup = "FamiliarSummon";
			break;
		case 4:
			powerup = "ShrinkSphere";
			break;
		case 5:
			powerup = "GuardsphereST";
			break;
		case 6:
			powerup = "Crucifix";
			break;
		case 7:
			powerup = "RegenSphere";
			break;
		case 8:
			powerup = "DeflectionSphere";
			break;
		case 9:
			powerup = "LifeshieldSphere";
			break;
		case 10:
			powerup = "ElectricAuraSphere";
			break;
		case 11:
			powerup = "LegendSphere";
			break;
		default:
			// Should never happen, but just in case
			powerup = "AmmoSphere";
			break;
		}
		
		// Give the selected powerup to the player
		if (powerup && Owner)
		{
			Owner.GiveInventory(powerup, 1);
		}
		
		// Return true to consume this item
		return true;
	}
	
	States
	{
	Spawn:
		// Use MegaSphere sprite as the pickup item
		MEGA A 6 Bright;
		MEGA B 6 Bright;
		Loop;
	}
}