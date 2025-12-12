extend class PBWP_Weapon
{
	States
	{
    //Melee Wheel Stuff
		SelectFirstPersonLegs:
			TNT1 A 0 {
				A_StopSound(1);
				A_StopSound(CHAN_VOICE);
				A_StopSound(5);
				A_StopSound(6);
				A_StopSound(7);
				A_StopSOund(CHAN_AUTO);
				A_TakeInventory("Spin",1);
				A_TakeInventory("CantWeaponSpecial",1); //Fixes bug with Weapon Special Key no longer working when changing SGL grenade type or RL missile mode
				A_TakeInventory("MG42Selected",1); //Take this token on every weapon that's not the MG42.
				A_SetInventory("Grabbing_A_Ledge", 0); //Fixed bug where movement is locked when vaulting after entering a level
				A_Takeinventory("RandomHeadExploder",1);
				A_TakeInventory("DualFireReload",2);
				A_Overlay(-777, "Melee_Equipment_Handler_Overlay");
				A_Overlay(-778, "KickHandler_Overlay");
				A_Overlay(-779, "Equipment_Toggle_Handler_Overlay");
				A_Overlay(-780, "Melee_Toggle_Handler_Overlay"); // Melee Wheel
				A_Overlay(-10, "FirstPersonLegsStand");
				A_ClearOverlays(-999, -999);
				PB_SetUsingKick(false);
				A_SetInventory("Kicking",0);
				A_SetInventory("Zoomed",0);
			}
			TNT1 A 0 A_Jump(255, "SelectContinue");
			Loop;
		Melee_Toggle_Handler_Overlay:
			TNT1 A 1 {
			if (CountInv("ToggleMelee")==1) 
				return ResolveState("SwitchMelee");
			return ResolveState(null);
			}
			Loop;
		GoingToReady2:
			TNT1 A 0 {
				A_TakeInventory("KeepLaserDeactivated",1);
				A_TakeInventory("ToggleEquipment",1);
				A_TakeInventory("ToggleMelee",1);
				PB_SetUsingMelee(false);
				PB_SetUsingEquipment(false);
				A_Overlay(-10, "FirstPersonLegsStand");
				A_ClearReFire();
			}
			TNT1 A 0 A_JumpIfInventory("SawSelected", 1, "OnLoop");
			TNT1 AAAA 0 A_Jump(256, "SelectAnimation");
			TNT1 AAAA 1 A_Jump(256, "Ready");
			Loop;
	}
}