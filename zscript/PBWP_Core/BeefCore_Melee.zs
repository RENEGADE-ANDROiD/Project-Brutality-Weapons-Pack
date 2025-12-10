class ToggleMelee : Inventory{Default{Inventory.MaxAmount 1;}}

extend class PBWP_Weapon
{	
    States
    {
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
		TNT1 A 0 A_JumpIfInventory("MeleeAxeSelected", 1, "MeleeAxe");
			//TNT1 A 0 A_JumpIfInventory("RevGunSelected", 1, "FireRevGun");
			//More stuff to come.....
			Goto GoingToReady;
    WheelCancelMelee:
        TNT1 A 0
            {
            A_SetInventory("WW_MeleeAxeSelected",0);
            A_SetInventory("CantWeaponSpecial",0);
            }
        goto Melee_Toggle_Handler_Overlay;
    SwitchMelee:
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
        TNT1 A 0 {
            if(CountInv("WW_MeleeAxeSelected") && CountInv("MeleeAxeSelected") >=1)
                {A_Print("Melee already selected: Axe"); return ResolveState("WheelCancelMelee");}
    
            if(CountInv("WW_MeleeAxeSelected") >=1)
                {
                if(CountInv("PB_Axe") <=0)
                    {A_Print("You Don't Have the Axe"); return ResolveState("WheelCancelMelee");}
                }

            return ResolveState(null);
            }
        TNT1 A 0 
            {
                if(CountInv("WW_MeleeAxeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Axe"); 
                        A_SetInventory("MeleeAxeSelected",1);
                        //A_SetInventory("ElecPodSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }			
            return ResolveState(null);
            }
        goto Melee_Toggle_Handler_Overlay;
    MeleeAxe:
        AX20 ABC 1 {
                if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX23"); }
                if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX22"); }
                if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX21"); }
                A_Setroll(roll+1.0, SPF_INTERPOLATE);
                A_SetAngle(angle-0.5, SPF_INTERPOLATE);
            }
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") >= 1 ) {
				A_Saw("", "", 30, "AxePuffs", 0, 120, 0,16);
				A_FireCustomMissile("AxeAttack", 0, 0, 0, 0);
				A_FireCustomMissile("AxeAttack", 0, 0, 0, 0);
			}
			else {
				A_Saw("", "", 15, "AxePuffs", 0, 120, 0,16);
				A_FireCustomMissile("AxeAttack", 0, 0, 0, 0);
			}
		
		}
		AX20 DEF 1 {
			if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX23"); }
			if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX22"); }
			if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX21"); }
			A_Setroll(roll+1.0, SPF_INTERPOLATE);
			A_SetAngle(angle-0.5, SPF_INTERPOLATE);
		}
		TNT1 AAA 1 {
			A_Setroll(roll-1.0, SPF_INTERPOLATE);
			A_SetAngle(angle+0.5, SPF_INTERPOLATE);
		}
		TNT1 AAA 1 {
			A_Setroll(roll-1.0, SPF_INTERPOLATE);
			A_SetAngle(angle+0.5, SPF_INTERPOLATE);
			return A_DoPBWeaponAction;
		}
        TNT1 A 7 {
                if(JustPressed(BT_USER2)) {return PB_Execute();}
                return state("MeleeAxe");
                }
        TNT1 A 0 {
                PB_SetUsingMelee(false);
                }
        TNT1 A 0 {
				A_TakeInventory("ToggleMelee", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser2(), "QuickMelee");
			Goto GoingToReady2;
    }
}