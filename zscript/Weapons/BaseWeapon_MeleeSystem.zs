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
        TNT1 A 0 A_JumpIf(isGKLoaded, "QuickMeleeGK");
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
			A_TakeInventory("Zoomed",1);
			A_ZoomFactor(1.0);
			A_TakeInventory("ADSmode",1);
			A_SetRoll(0);
			A_Overlay(-10, "FirstPersonLegsStand");
		}
    // Add Tokens Here
        // Two Handed Melee
        TNT1 A 0 A_JumpIfInventory("MeleeAxeSelected", 1, "PrepDualHandsAxe");
        TNT1 A 0 A_JumpIfInventory("KatanaMeleeSelected", 1, "PrepDualHands");
        TNT1 A 0 A_JumpIfInventory("JohnnyHandsMeleeSelected", 1, "ExplosiveHands");
        TNT1 A 0 A_JumpIfInventory("SawMeleeSelected", 1, "SawComboStart");
        TNT1 A 0 A_JumpIfInventory("HammerMeleeSelected", 1, "PrepDualHands");
        // One Handed Malee
        TNT1 A 0 A_Overlay(PSP_FLASH, "FlashPunching");
        TNT1 A 0 A_JumpIfInventory("StandardMeleeSelected", 1, "StandardMelee");
        TNT1 A 0 A_JumpIfInventory("BladeMeleeSelected", 1, "MeleeBlade");
        TNT1 A 0 A_JumpIfInventory("ImpactorMeleeSelected", 1, "MeleeImpactor");
        TNT1 A 0 A_JumpIfInventory("PickAxeMeleeSelected", 1, "MeleePickAxe");
        TNT1 A 0 A_JumpIfInventory("SentinelHammerMeleeSelected", 1, "MeleeSentinelHammer");
        TNT1 A 0 A_JumpIfInventory("ClawGauntletMeleeSelected", 1, "MeleeClaw");
        TNT1 A 0 A_JumpIfInventory("MeleeCrowbarSelected", 1, "CrowbarSwingLeft");
        TNT1 A 0 A_JumpIfInventory("WrenchMeleeSelected", 1, "WrenchSwingLeft");
        TNT1 A 0 A_JumpIfInventory("BatonMeleeSelected", 1, "BatonComboStart");
        TNT1 A 0 A_JumpIfInventory("MacheteMeleeSelected", 1, "MacheteSwingLeft");

		// Add more Here
			Goto GoingToReady;
    PrepDualHands:
    // Two Handed Only
        EQPR ABCD 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		EQPR EJK 1;
		TNT1 AAAA 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
        TNT1 A 0 A_JumpIfInventory("KatanaMeleeSelected", 1, "MeleeKatana");
        TNT1 A 0 A_JumpIfInventory("HammerMeleeSelected", 1, "HammerSwingRight");
        
    PrepDualHandsAxe: // Special Case since you can have 10 axes (carrot pls fix)
        TNT1 A 0 A_JumpIfInventory("PB_Axe", 1, 2);
		TNT1 A 0 A_Print("You Don't Have any Axe");
		Goto GoingToReady;
        EQPR ABCD 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		EQPR EJK 1;
		TNT1 AAAA 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
        Goto AxeSwingRight;


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
            A_SetInventory("WW_MeleeCrowbarSelected",0);
            A_SetInventory("WW_WrenchMeleeSelected",0);
            A_SetInventory("WW_SawMeleeSelected",0);
            A_SetInventory("WW_BatonMeleeSelected",0);
            A_SetInventory("WW_HammerMeleeSelected",0);
            A_SetInventory("WW_MacheteMeleeSelected",0);
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
            if(CountInv("WW_MeleeCrowbarSelected") && CountInv("MeleeCrowbarSelected") >=1)
                {A_Print("Melee already selected: Crowbar"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_WrenchMeleeSelected") && CountInv("WrenchMeleeSelected") >=1)
                {A_Print("Melee already selected: Wrench"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_SawMeleeSelected") && CountInv("SawMeleeSelected") >=1)
                {A_Print("Melee already selected: Chainsaw"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_BatonMeleeSelected") && CountInv("BatonMeleeSelected") >=1)
                {A_Print("Melee already selected: Shock Baton"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_HammerMeleeSelected") && CountInv("HammerMeleeSelected") >=1)
                {A_Print("Melee already selected: Sledge Hammer"); return ResolveState("WheelCancelMelee");}
            if(CountInv("WW_MacheteMeleeSelected") && CountInv("MacheteMeleeSelected") >=1)
                {A_Print("Melee already selected: Machete"); return ResolveState("WheelCancelMelee");}
    
        // Ammo/Charges/Durability Checker
            if(CountInv("WW_MeleeAxeSelected") >=1)
                {
                if(CountInv("PB_Axe") <=0)//&& CountInv("AxeDurability") <= 0)
                    {A_Print("You Don't Have any Axe"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_JohnnyHandsMeleeSelected") >=1)
                {
                if(CountInv("ExplosiveHandCharges") <=0)
                    {A_Print("You Don't Have any Energy Left"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_MeleeCrowbarSelected") >=1)
                {
                if(CountInv("CrowbarDurability") <=0)
                    {A_Print("You Don't Have any Crowbar"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_KatanaMeleeSelected") >=1)
                {
                if(CountInv("KatanaDurability") <=0)
                    {A_Print("You Don't Have any Katana"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_ImpactorMeleeSelected") >=1)
                {
                if(CountInv("ImpactorCharges") <=0)
                    {A_Print("You Don't Have any Impact Charges"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_PickAxeMeleeSelected") >=1)
                {
                if(CountInv("PickAxeDurability") <=0)
                    {A_Print("You Don't Have any Pick Axe"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_SentinelHammerMeleeSelected") >=1)
                {
                if(CountInv("SentinelhammerCharges") <=0)
                    {A_Print("You Don't Have any Sentinel Hammer Charges"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_ClawGauntletMeleeSelected") >=1)
                {
                if(CountInv("ClawCharges") <=0)
                    {A_Print("You Don't Have any Claw Charges"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_WrenchMeleeSelected") >=1)
                {
                if(CountInv("WrenchDurability") <=0)
                    {A_Print("You Don't Have any Wrench"); return ResolveState("WheelCancelMelee");}
                }
             if(CountInv("WW_SawMeleeSelected") >=1)
                {
                if(CountInv("PB_Chainsaw") <=0)
                    {A_Print("You Don't Have any Chainsaw"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_BatonMeleeSelected") >=1)
                {
                if(CountInv("HasShockBaton") <=0)
                    {A_Print("You Don't Have any Shock Baton"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_HammerMeleeSelected") >=1)
                {
                if(CountInv("HammerDurability") <=0)
                    {A_Print("You Don't Have any Sledge Hammer"); return ResolveState("WheelCancelMelee");}
                }
            if(CountInv("WW_MacheteMeleeSelected") >=1)
                {
                if(CountInv("MacheteDurability") <=0)
                    {A_Print("You Don't Have any Machete"); return ResolveState("WheelCancelMelee");}
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
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
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
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
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
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        //A_Overlay(PSP_FLASH,"SwapToMeleeAxe");
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                        //return ResolveState("SwapToMeleeAxe");
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
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
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
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
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
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
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
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
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
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
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
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_MeleeCrowbarSelected") >=1)
                    { 
                        A_Print("Melee Selected: Crowbar"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_SetInventory("MeleeCrowbarSelected",1);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_WrenchMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Wrench"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",1);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_SawMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Chainsaw"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",1);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_BatonMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Shock Baton"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",1);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_HammerMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Sledge Hammer"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",1);
                        A_SetInventory("MacheteMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                 if(CountInv("WW_MacheteMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Machete"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("BladeMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_SetInventory("JohnnyHandsMeleeSelected",0);
                        A_SetInventory("MeleeCrowbarSelected",0);
                        A_SetInventory("WrenchMeleeSelected",0);
                        A_SetInventory("SawMeleeSelected",0);
                        A_SetInventory("BatonMeleeSelected",0);
                        A_SetInventory("HammerMeleeSelected",0);
                        A_SetInventory("MacheteMeleeSelected",1);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                    
            // End
            return ResolveState(null);
            }
        goto Melee_Toggle_Handler_Overlay;
    }
}