extend class PB_WeaponBase
{	
    States
    {
    // The Handler that Catches the Gearbox Token
    Melee_Toggle_Handler_Overlay:
			TNT1 A 1 {
			if (CountInv("ToggleMelee")==1) 
				return ResolveState("SwitchMelee");
			return ResolveState(null);
			}
			Loop;
    // The Use Melee
    QuickMelee:
        "####" A 0 {
            A_StopSound(CHAN_WEAPON);
            A_StopSound(CHAN_VOICE);
            A_StopSound(CHAN_6);
            A_StopSound(CHAN_7);
        }
        TNT1 A 0 A_JumpIfInventory("CantDoAction",1,"FailOverlay");
        TNT1 A 0 A_JumpIfHealthLower(0, "FailOverlay");
        //TNT1 A 0 A_JumpIf(!CustomMelee, "Super::GoMeleeInstead")
        TNT1 A 0 {
            A_ClearOverlays(-10,65);
            A_Gunflash("Null");
        }
		"####" AAA 0 PB_Execute();
	GoMeleeInstead:
		TNT1 A 0 {
			A_Overlay(PSP_FLASH, "FlashPunching");
			A_TakeInventory("Zoomed",1);
			A_ZoomFactor(1.0);
			A_TakeInventory("ADSmode",1);
			A_SetRoll(0);
			A_Overlay(-10, "FirstPersonLegsStand");
		}
    // Add Tokens Here
        TNT1 A 0 A_JumpIfInventory("StandardMeleeSelected", 1, "StandardMelee");
        TNT1 A 0 A_JumpIfInventory("BladeMeleeSelected", 1, "MeleeBlade");
		TNT1 A 0 A_JumpIfInventory("MeleeAxeSelected", 1, "MeleeAxe");
        TNT1 A 0 A_JumpIfInventory("ImpactorMeleeSelected", 1, "MeleeImpactor");
        TNT1 A 0 A_JumpIfInventory("KatanaMeleeSelected", 1, "MeleeKatana");
        TNT1 A 0 A_JumpIfInventory("PickAxeMeleeSelected", 1, "MeleePickAxe");
        TNT1 A 0 A_JumpIfInventory("SentinelHammerMeleeSelected", 1, "MeleeSentinelHammer");
        TNT1 A 0 A_JumpIfInventory("ClawGauntletMeleeSelected", 1, "MeleeClaw");
        TNT1 A 0 A_JumpIfInventory("JohnnyHandsMeleeSelected", 1, "ExplosiveHands");
		
			Goto GoingToReady;
    // Reset Melee Wheel Tokens
    WheelCancelMelee:
        TNT1 A 0
            {
            A_SetInventory("WW_StandardMeleeSelected",0);
            A_SetInventory("WW_BladeMeleeSelected",0);
            A_SetInventory("WW_MeleeAxeSelected",0);
            A_SetInventory("WW_ImpactorMeleeSelected",0);
            A_SetInventory("WW_KatanaMeleeSelected",0);
            A_SetInventory("WW_PickAxeMeleeSelected",0);
            A_SetInventory("WW_SentinelHammerMeleeSelected",0);
            A_SetInventory("WW_ClawGauntletMeleeSelected",0);
            A_SetInventory("WW_JohnnyHandsMeleeSelected",0);
            A_SetInventory("CantWeaponSpecial",0);
            }
        goto Melee_Toggle_Handler_Overlay;
    // Called by the gearbox wheel
    SwitchMelee:
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
        // If you already choose the currently selected melee
        TNT1 A 0 {
            if(CountInv("WW_StandardMeleeSelected") && CountInv("StandardMeleeSelected") >=1)
                {A_Print("Melee already selected: Default"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_BladeMeleeSelected") && CountInv("BladeMeleeSelected") >=1)
                {A_Print("Melee already selected: Blade"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_MeleeAxeSelected") && CountInv("MeleeAxeSelected") >=1)
                {A_Print("Melee already selected: Axe"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_ImpactorMeleeSelected") && CountInv("ImpactorMeleeSelected") >=1)
                {A_Print("Melee already selected: Impactor Gauntlets"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_KatanaMeleeSelected") && CountInv("KatanaMeleeSelected") >=1)
                {A_Print("Melee already selected: Katana"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_PickAxeMeleeSelected") && CountInv("PickAxeMeleeSelected") >=1)
                {A_Print("Melee already selected: Pick Axe"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_SentinelHammerMeleeSelected") && CountInv("SentinelHammerMeleeSelected") >=1)
                {A_Print("Melee already selected: Sentinel Hammer"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_ClawGauntletMeleeSelected") && CountInv("ClawGauntletMeleeSelected") >=1)
                {A_Print("Melee already selected: Claw Gauntlets"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_JohnnyHandsMeleeSelected") && CountInv("JohnnyHandsMeleeSelected") >=1)
                {A_Print("Melee already selected: Explosive Hands"); return ResolveState("WheelCancelMelee");}

    
        // If you dont have the selected melee
            if(CountInv("WW_MeleeAxeSelected") >=1)
                {
                if(CountInv("PB_Axe") <=0)
                    {A_Print("You Don't Have any Axe"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_JohnnyHandsMeleeSelected") >=1)
                {
                if(CountInv("ExplosiveHandCharges") <=0)
                    {A_Print("You Don't Have any Charges"); return ResolveState("WheelCancelMelee");}
                }

            return ResolveState(null);
            }
        // When you actually select the melee
        TNT1 A 0 
            {   if(CountInv("WW_StandardMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Default"); 
                        A_SetInventory("StandardMeleeSelected",1);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_BladeMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Blade"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",1);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }		
                if(CountInv("WW_MeleeAxeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Axe"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",1);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_ImpactorMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Impactor Gauntlet"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",1);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_KatanaMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Katana"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",1);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }	
                if(CountInv("WW_PickAxeMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Pick Axe"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",1);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }	
                if(CountInv("WW_SentinelHammerMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Sentinel Hammer"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",1);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }	
                if(CountInv("WW_ClawGauntletMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Claw Gauntlet"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",1);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }	
                if(CountInv("WW_JohnnyHandsMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Explosive Hands"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",1);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                    
            // End
            return ResolveState(null);
            }
        goto Melee_Toggle_Handler_Overlay;
    }
}