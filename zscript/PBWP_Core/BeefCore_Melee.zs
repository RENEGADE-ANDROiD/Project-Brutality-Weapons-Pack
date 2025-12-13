extend class PBWP_Weapon
{	
    States
    {
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
		TNT1 A 0 A_JumpIfInventory("MeleeAxeSelected", 1, "MeleeAxe");
        TNT1 A 0 A_JumpIfInventory("ImpactorMeleeSelected", 1, "MeleeImpactor");
        TNT1 A 0 A_JumpIfInventory("KatanaMeleeSelected", 1, "MeleeKatana");
        TNT1 A 0 A_JumpIfInventory("PickAxeMeleeSelected", 1, "MeleePickAxe");
        TNT1 A 0 A_JumpIfInventory("SentinelHammerMeleeSelected", 1, "MeleeSentinelHammer");
        TNT1 A 0 A_JumpIfInventory("ClawGauntletMeleeSelected", 1, "MeleeClaw");
		
			Goto GoingToReady;
    // Reset Melee Wheel Tokens
    WheelCancelMelee:
        TNT1 A 0
            {
            A_SetInventory("WW_StandardMeleeSelected",0);
            A_SetInventory("WW_MeleeAxeSelected",0);
            A_SetInventory("WW_ImpactorMeleeSelected",0);
            A_SetInventory("WW_KatanaMeleeSelected",0);
            A_SetInventory("WW_PickAxeMeleeSelected",0);
            A_SetInventory("WW_SentinelHammerMeleeSelected",0);
            A_SetInventory("WW_ClawGauntletMeleeSelected",0);
            A_SetInventory("CantWeaponSpecial",0);
            }
        goto Melee_Toggle_Handler_Overlay;
    // Called by the gearbox wheel
    SwitchMelee:
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
        // If you already choose the currently selected melee
        TNT1 A 0 {
             if(CountInv("WW_StandardMeleeSelected") && CountInv("StandardMeleeSelected") >=1)
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
    
    
        // If you dont have the selected melee
            if(CountInv("WW_MeleeAxeSelected") >=1)
                {
                if(CountInv("PB_Axe") <=0)
                    {A_Print("You Don't Have the Axe"); return ResolveState("WheelCancelMelee");}
                }

            return ResolveState(null);
            }
        // When you actually select the melee
        TNT1 A 0 
            {   if(CountInv("WW_StandardMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Blade"); 
                        A_SetInventory("StandardMeleeSelected",1);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }	
                if(CountInv("WW_MeleeAxeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Axe"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",1);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_ImpactorMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Impactor Gauntlet"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",1);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_KatanaMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Katana"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",1);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }	
                if(CountInv("WW_PickAxeMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Pick Axe"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",1);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }	
                if(CountInv("WW_SentinelHammerMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Sentinel Hammer"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",1);
                        A_SetInventory("ClawGauntletMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }	
                if(CountInv("WW_ClawGauntletMeleeSelected") >=1)
                    { 
                        A_Print("Melee Selected: Claw Gauntlet"); 
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("MeleeAxeSelected",0);
                        A_SetInventory("ImpactorMeleeSelected",0);
                        A_SetInventory("KatanaMeleeSelected",0);
                        A_SetInventory("PickAxeMeleeSelected",0);
                        A_SetInventory("SentinelHammerMeleeSelected",0);
                        A_SetInventory("ClawGauntletMeleeSelected",1);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }			
            return ResolveState(null);
            }
        goto Melee_Toggle_Handler_Overlay;

    // The Actual Custom Melee Animations
    MeleeKatana:
        TNT1 A 0 {
				A_PlaySound("Katana/Swing");
				A_SetRoll(0);
				A_GiveInventory("KatanaSequence1");
			}
		KTNA I 1; 
		KTNA JK 1;
		TNT1 A 0 {
				if (CountInv("PB_PowerStrength") >= 1 ) {
					A_Saw("", "", 16, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);			
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);
				}
				else {
					A_Saw("", "", 3, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);
				}			
			}
		KTNA LMNO 1 
		{
				A_Setroll(roll-1.0, SPF_INTERPOLATE);
				A_SetAngle(angle+0.5, SPF_INTERPOLATE);
		}		
		TNT1 AAA 1 
		{
				A_Setroll(roll+1.0, SPF_INTERPOLATE);
				A_SetAngle(angle-0.5, SPF_INTERPOLATE);
		}
		TNT1 AAA 1 
		{
				A_Setroll(roll+1.0, SPF_INTERPOLATE);
				A_SetAngle(angle-0.5, SPF_INTERPOLATE);
				return A_DoPBWeaponAction;
		}
		KTNA ABC 1;
		TNT1 A 0 {
				A_PlaySound("Katana/Swing");
				A_SetRoll(0);
				A_TakeInventory("KatanaSequence1");
				A_GiveInventory("KatanaSequence2");
			}	
		KTBA JK 1;
		TNT1 A 0 {
				if (CountInv("PB_PowerStrength") >= 1 ) {
					A_Saw("", "", 16, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);			
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);
				}
				else {
					A_Saw("", "", 3, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);
				}			
			}
		KTBA LMNO 1
		{
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

        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
    MeleePickAxe:
        PCKA I 3;
		PCKA J 5;
		PCKA J 1;
		TNT1 A 0 A_PlaySound("SWOOSH", 1);
		PCKA K 2 A_FireCustomMissile("PickaxeMeleeStrike", 1);
		PCKA L 2;
		PCKA MMM 2;
		PCKA L 2;
		PCKA K 2;
		PCKA A 3;

        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
    MeleeSentinelHammer:
        TNT1 A 0 A_PlaySound("HMSWING", 50);
		TNT1 A 0 A_PlaySound("AXSWING", 45);
		SHPB M 1 A_SetAngle(angle+5);
		TNT1 A 0 A_FireCustomMissile("AxeAttack", 0, 0);
		SHPB NOPQ 1 A_SetAngle(angle+5);
		TNT1 AAAAAA 1 A_SetAngle(angle-1,5);

        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
    MeleeClaw:
        GAFR AB 1;
		PUFF A 0 A_PlaySound("player/cyborg/fist", 3);
		GAFR C 1;
		GAFR D 1 A_CustomPunch (20,0,0,"crowbarpuff");
		GAFR EFG 1;
		TNT1 A 4;
		GAFL AB 1;
		GAFL C 1;
		GAFL D 2 A_CustomPunch (20,0,0,"crowbarpuff2");
		GAFL EFG 1;
		TNT1 A 4;
		TNT1 A 0;

        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
    MeleeImpactor:
        TNT1 A 0 A_PlaySound("weapons/IMGCok");
		IMPA KLM 1;
		TNT1 A 0 A_CustomPunch (10 * random(10, 55),1,CPF_NOTURN ,"ImpactorPuff",92, 0, 0, "PB_ArmorBonus", "weapons/IMGHit", "weapons/IMGMiss");
		TNT1 A 0 A_Blast(BF_DONTWARN | BF_NOIMPACTDAMAGE | BF_AFFECTBOSSES, 25, 60, 20, "GauntletImpact");
		TNT1 A 0 A_Quake(3, 10, 0, 10);
		IMPA NOP 1;
		IMPA Q 6;
		IMPA RSTU 1;

		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
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
        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 A_JumpIf(PressingUser2(), "QuickMelee");
		Goto GoingToReady2;
    StandardMelee:
        TNT1 A 0 {
				A_GiveInventory("HasCutingWeapon", 1);
				A_StartSound("KNIFSWNG", 1);
				double knifeRoll = frandom(-1.0,1.0);
				A_Overlayrotate(overlayID(),knifeRoll);
				if(invoker.curBlood.x != 0 || invoker.curBlood.y != 0 || invoker.curBlood.z != 0)
				{
					double BR = invoker.curBlood.x;
					double BG = invoker.curBlood.y;
					double BB = invoker.curBlood.z;
					double mostlyred = (BR - (BG + BB));
					double mostlygreen = (BG - (BB + BR));
					double mostlyblue = (BB - (BR + BG));
					if(mostlyred > 0)
						A_overlay(overlayID() + 2,"BloodyKnife_Red");
					else if(mostlygreen > 0)
						A_overlay(overlayID() + 2,"BloodyKnife_Green");
					else if(mostlyblue > 0)
						A_overlay(overlayID() + 2,"BloodyKnife_Blue");
					
					A_Overlayrotate(overlayID() + 2,knifeRoll);
				}
				
			}
        MC3S AB 1 {
            
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        MC3S C 1 {
            A_Setangle(angle - 1,SPF_INTERPOLATE);
            A_SetPitch(pitch + 1,SPF_INTERPOLATE);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        MC3S D 1 {
            A_QuakeEx(0,0.5,0,7,0,10,"",QF_SCALEDOWN|QF_RELATIVE,0,0,0,0,0,2,2);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        TNT1 A 0 {
            if(CountInv("PB_PowerStrength") == 1) A_FireProjectile("SuperKnifeSwing",0,0,0,0,0,0);
            else A_FireProjectile("KnifeSwing",0,0,0,0,0,0);
            PB_UseLine(64);
            flinetracedata t;
            linetrace(angle,64,pitch,0,player.mo.height * 0.5 - player.mo.floorclip + player.mo.AttackZOffset*player.crouchFactor,data:t);
            if(t.hitactor != null && !t.hitactor.bnoblood)
            {
                if(t.hitactor.bloodcolor == 0)	//has no blood color defined, use default bloodcolor
                {
                    invoker.curBlood.x = gameinfo.defaultbloodcolor.r / 255.0;
                    invoker.curBlood.y = gameinfo.defaultbloodcolor.g / 255.0;
                    invoker.curBlood.z = gameinfo.defaultbloodcolor.b / 255.0;
                }
                else
                {
                    invoker.curBlood.x = t.hitactor.bloodcolor.r / 255.0;
                    invoker.curBlood.y = t.hitactor.bloodcolor.g / 255.0;
                    invoker.curBlood.z = t.hitactor.bloodcolor.b / 255.0;
                }
            }
        }
        MC3S EF 1 {
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        MC3S GHIJK 1 {
            A_SetPitch(pitch - 0.2,SPF_INTERPOLATE);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        TNT1 AAA 1 {
            A_Setangle(angle + 0.3,SPF_INTERPOLATE);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        TNT1 A 0 {
            A_TakeInventory("KnifeHasHit",1);
            A_TakeInventory("HasCutingWeapon", 1);
            PB_SetUsingMelee(false);
        }
        TNT1 A 0 A_Overlayrotate(overlayID(),0);
        TNT1 A 0 PB_CheckBarrelIdle1();
        Goto GoingToReady2;
    }
}