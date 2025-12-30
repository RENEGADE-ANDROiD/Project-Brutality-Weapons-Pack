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
		int choice = random(0, 10);
		Class<Inventory> powerup;
		string message;
		
		// Select the powerup based on random choice
		switch(choice)
		{
		case 0:
			if(!ksCoffee){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "CoffeeTime";
				message = "\ckCOFFEE TIME! \n\cjDouble the Speed!";
			}
			break;
		case 1:
			if(!ksTimesphere){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "TFST";
				message = "ZA WARUDO! \nTOKI WO TOMARE!";
			}
			break;
		case 2:
			if(!ksFamiliar){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "FamiliarSummon";
				message = "\crFAMILIAR! \n\cjSummons a Friendly Familiar that Fights for You ";
			}
			break;
		case 3:
			if(!ksShrinksphere){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "ShrinkSphere";
				message = "\ctSHRINK SPHERE! \n\cjWhy So Small?";
			}
			break;
		case 4:
			if(!ksGuardsphere){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "GuardsphereST";
				message = "\ccGUARD SPHERE! \n\cjGain 75% Damage Reduction";
			}
			break;
		case 5:
			if(!ksCrucifix){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "Crucifix";
				message = "\cxCRUCIFIX! n\cjEnemies will be frightened by you";
			}
			break;
		case 6:
			if(!ksRegensphere){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "RegenSphere";
				message = "\cgREGEN SPHERE! \n\cjInfinite Healing!";
			}
			break;
		case 7:
			if(!ksDeflectionsphere){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "DeflectionSphere";
				message = "\cyDEFLECTION SPHERE! \n\cjAutomatically Deals Damage to Anyone that Hits You";
			}
			break;
		case 8:
			if(!ksLifeShield){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "LifeshieldSphere";
				message = "\cdLIFESHIELD! \n\cjGrants immunity through armor consumption";
			}
			break;
		case 9:
			if(!ksElectricsphere){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else{
				powerup = "ElectricAuraSphere";
				message = "\cvELECTRIC AURA! \n\cjSummons an Electric Field that Stuns Nearby Enemies in Area";
			}
			break;
		case 10:
			if(!ksLegendsphere){
				powerup = "PB_Megasphere";
				message = "MEGASPHERE!";
			}
			else {
				powerup = "LegendSphere";
				message = "\cfLEGEND SPHERE! \n\cjYou Can't Go Below 1 HP! Go Crazy!";
			}
			break;
		default:
			// Should never happen, but just in case
			powerup = "PB_Megasphere";
			message = "MEGASPHERE!";
			break;
		}
		
		
		// Give the selected powerup to the player
		if (powerup && Owner)
		{
			Owner.GiveInventory(powerup, 1);
			Owner.A_Print(message);
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