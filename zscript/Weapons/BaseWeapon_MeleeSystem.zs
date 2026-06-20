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

    // Staging-default punch: flash on PSP_WEAPON, knife on -998 (StagingQuickMeleeTail).
    // Wheel melee: MeleeDispatch only when PB_HasCustomWheelMelee() is true.
    // Handler (BaseWeapon.zc) starts QuickMelee on -998 — flash lives on PSP_WEAPON from GoMeleeInstead.
    QuickMelee:
        "####" A 0 {
            PB_SetReloading(false);
            A_StopSound(CHAN_WEAPON);
            A_StopSound(CHAN_VOICE);
            A_StopSound(CHAN_6);
            A_StopSound(CHAN_7);
        }
        TNT1 A 0 A_JumpIfInventory("CantDoAction",1,"FailOverlay");
        TNT1 A 0 A_JumpIfHealthLower(0, "FailOverlay");
        TNT1 A 0 {
            A_ClearOverlays(-10, -1, false);
            A_Gunflash("Null");
        }
	GoMeleeInstead:
		TNT1 A 0 {
			A_TakeInventory("Zoomed",1);
			A_ZoomFactor(1.0);
			A_TakeInventory("ADSmode",1);
			A_SetRoll(0);
			A_LegOverlay(-1000, "FirstPersonLegsStand");
			A_OverlayFlags(-1000, PSPF_ADDWEAPON|PSPF_ADDBOB, False);
			PB_SetUsingMelee(true);
			A_GiveInventory("HasCutingWeapon", 1);
			// Chainsaw wheel melee: tall 0SAW/1SAW sprites — skip punch flash, anchor overlay to screen bottom.
			if (PB_HasCustomWheelMelee() && CountInv("SawMeleeSelected") >= 1)
				PB_AnchorSawWheelOverlay();
			else
			{
				A_OverlayPivotAlign(PSP_QUICKMELEE, PSPA_CENTER, PSPA_CENTER);
				A_OverlayOffset(PSP_QUICKMELEE, 0, 32);
				if (CountInv("GrabbedBarrel") == 1 || CountInv("GrabbedIceBarrel") == 1 || CountInv("GrabbedFlameBarrel") == 1)
					A_Overlay(PSP_WEAPON, "FlashBarrelPunching");
				else
					A_Overlay(PSP_WEAPON, "FlashPunching");
				A_OverlayOffset(PSP_WEAPON, 0, 32);
			}
		}
		"####" AAA 0 PB_Execute();
		TNT1 A 0 {
			if (invoker.PB_pendingExecutionState != null)
			{
				PB_SetUsingMelee(false);
				A_TakeInventory("HasCutingWeapon", 1);
				return ResolveState(null);
			}
			if (!PB_HasCustomWheelMelee())
				return ResolveState("StagingQuickMeleeTail");
			return ResolveState("MeleeDispatch");
		}
		Stop;

	// PB Staging quick-melee tail (knife on -998). Flash already on PSP_WEAPON from GoMeleeInstead.
	StagingQuickMeleeTail:
		TNT1 A 0 A_StartSound("KNIFSWNG", 0);
		TNT1 A 0 {
			double knifeRoll = frandom(-1.0, 1.0);
			A_Overlayrotate(PSP_QUICKMELEE, knifeRoll);
			if (PB_IsVisorBlood())
			{
				switch (PB_GetVisorBlood())
				{
					case REDBLOODVISOR:  A_overlay(PSP_QUICKMELEEBLOOD, "BloodyKnife_Red");   break;
					case GREENBLOODVISOR: A_overlay(PSP_QUICKMELEEBLOOD, "BloodyKnife_Green"); break;
					case BLUEBLOODVISOR:  A_overlay(PSP_QUICKMELEEBLOOD, "BloodyKnife_Blue");  break;
				}
				A_Overlayrotate(PSP_QUICKMELEEBLOOD, knifeRoll);
			}
			if (invoker.leftHandMelee || findinventory("GrabbedBarrel") || findinventory("GrabbedFlameBarrel") || findinventory("GrabbedIceBarrel"))
			{
				A_OverlayFlags(PSP_QUICKMELEE, PSPF_FLIP | PSPF_MIRROR, true);
				A_OverlayFlags(PSP_QUICKMELEEBLOOD, PSPF_FLIP | PSPF_MIRROR, true);
			}
		}
		MC3S AB 1 {
			if (JustPressed(BT_USER2))
				PB_Execute();
		}
		MC3S C 1 {
			A_Setangle(angle - 1, SPF_INTERPOLATE);
			A_SetPitch(pitch + 1, SPF_INTERPOLATE);
			if (JustPressed(BT_USER2))
				PB_Execute();
		}
		MC3S D 1 {
			A_QuakeEx(0, 0.5, 0, 7, 0, 10, "", QF_SCALEDOWN | QF_RELATIVE, 0, 0, 0, 0, 0, 2, 2);
			if (JustPressed(BT_USER2))
				PB_Execute();
		}
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1)
				A_FireProjectile("SuperKnifeSwing", 0, 0, 0, 0, 0, 0);
			else
				A_FireProjectile("KnifeSwing", 0, 0, 0, 0, 0, 0);
			PB_UseLine(64);
			FLineTraceData t;
			LineTrace(angle, 64, pitch, 0, player.mo.height * 0.5 - player.mo.floorclip + player.mo.AttackZOffset * player.crouchFactor, data: t);
			if (t.hitactor != null && !t.hitactor.bnoblood && !t.hitactor.bdormant)
			{
				if (t.hitactor.bloodcolor == 0)
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
			if (JustPressed(BT_USER2))
				PB_Execute();
		}
		MC3S GHIJK 1 {
			A_SetPitch(pitch - 0.2, SPF_INTERPOLATE);
			if (JustPressed(BT_USER2))
				PB_Execute();
		}
		TNT1 AAA 1 {
			A_Setangle(angle + 0.3, SPF_INTERPOLATE);
			if (JustPressed(BT_USER2))
				PB_Execute();
		}
		TNT1 A 0 {
			if (invoker.leftHandMelee)
			{
				A_OverlayFlags(PSP_QUICKMELEE, PSPF_FLIP | PSPF_MIRROR, false);
				A_OverlayFlags(PSP_QUICKMELEEBLOOD, PSPF_FLIP | PSPF_MIRROR, false);
			}
		}
		TNT1 A 0 A_Overlayrotate(PSP_QUICKMELEE, 0);
		TNT1 A 0 PB_FinishPunchRestore();
		Stop;

	// Brief flash hold before execution replaces PSP_WEAPON (flash already applied in GoMeleeInstead).
	ExecutionFlashWindup:
		"####" A 1;
		"####" B 1;
		TNT1 A 0 A_Jump(256, "ExecutionFlashWindupFinish");
	ExecutionFlashWindupFinish:
		TNT1 A 0 {
			if(invoker.PB_pendingExecutionState != null)
			{
				A_Overlay(PSP_WEAPON, invoker.PB_pendingExecutionState);
				A_OverlayOffset(PSP_WEAPON, 0, 32);
			}
			else
				PB_RestoreWeaponReadyOverlay();
			invoker.PB_pendingExecutionState = null;
			PB_SetUsingMelee(false);
			A_TakeInventory("HasCutingWeapon", 1);
		}
		Stop;

	MeleeDispatch:
        // Two Handed Melee — runs on overlay -998; do not replace PSP_WEAPON (punch flash lives there).
        TNT1 A 0 A_JumpIfInventory("MeleeAxeSelected", 1, "PrepDualHandsAxe");
        TNT1 A 0 A_JumpIfInventory("KatanaMeleeSelected", 1, "PrepDualHands");
        TNT1 A 0 A_JumpIfInventory("JohnnyHandsMeleeSelected", 1, "ExplosiveHands");
        TNT1 A 0 A_JumpIfInventory("SawMeleeSelected", 1, "SawComboStart");
        TNT1 A 0 A_JumpIfInventory("HammerMeleeSelected", 1, "PrepDualHands");
        // PBWP fist combo wheel option (not default Staging quick punch)
        TNT1 A 0 A_JumpIfInventory("FistComboMeleeSelected", 1, "StandardMelee");
        TNT1 A 0 A_JumpIfInventory("BladeMeleeSelected", 1, "MeleeBlade");
        TNT1 A 0 A_JumpIfInventory("ImpactorMeleeSelected", 1, "MeleeImpactor");
        TNT1 A 0 A_JumpIfInventory("PickAxeMeleeSelected", 1, "MeleePickAxe");
        TNT1 A 0 A_JumpIfInventory("SentinelHammerMeleeSelected", 1, "MeleeSentinelHammer");
        TNT1 A 0 A_JumpIfInventory("ClawGauntletMeleeSelected", 1, "MeleeClaw");
        TNT1 A 0 A_JumpIfInventory("MeleeCrowbarSelected", 1, "CrowbarSwingLeft");
        TNT1 A 0 A_JumpIfInventory("WrenchMeleeSelected", 1, "WrenchSwingLeft");
        TNT1 A 0 A_JumpIfInventory("BatonMeleeSelected", 1, "BatonComboStart");
        TNT1 A 0 A_JumpIfInventory("MacheteMeleeSelected", 1, "MacheteSwingLeft");

		// Wheel token set but no handler matched — fall back to default knife punch.
		Goto StagingQuickMeleeTail;
    PrepDualHands:
    // Two Handed Only — wait for punch flash (~14 tics) before clearing PSP_WEAPON
        TNT1 AAAAAAAAAAAAAA 1;
        TNT1 A 0 A_ClearOverlays(PSP_WEAPON, PSP_WEAPON, false);
        EQPR ABCD 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		EQPR EJK 1;
		TNT1 AAAA 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
        TNT1 A 0 A_JumpIfInventory("KatanaMeleeSelected", 1, "MeleeKatana");
        TNT1 A 0 A_JumpIfInventory("HammerMeleeSelected", 1, "HammerSwingRight");
        
    PrepDualHandsAxe: // Special Case since you can have 10 axes (carrot pls fix)
        TNT1 A 0 A_JumpIfInventory("PB_Axe", 1, 2);
		TNT1 A 0 A_Print("You Don't Have any Axe");
		Goto GoingToReady;
        TNT1 AAAAAAAAAAAAAA 1;
        TNT1 A 0 A_ClearOverlays(PSP_WEAPON, PSP_WEAPON, false);
        EQPR ABCD 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		EQPR EJK 1;
		TNT1 AAAA 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
        Goto AxeSwingRight;

	// Base flash states — weapons without overrides inherit Staging-correct endings.
	FlashPunching:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		Goto HideWeaponDuringAction;

	FlashKicking:
		TNT1 AAAAAAAAAAAAAAA 1;
		Stop;

	FlashAirKicking:
		TNT1 AAAAAAAAAAAAAAAA 1;
		Stop;

	FlashSlideKicking:
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 1;
		Stop;

	FlashSlideKickingStop:
		TNT1 AAAAAAA 1;
		Stop;

	HideWeaponDuringAction:
		TNT1 A 1 {
			if (PB_usingMelee() || PB_usingKick() || CountInv("Kicking") >= 1 || CountInv("HasCutingWeapon") >= 1)
				return ResolveState(null);
			return ResolveState("GoingToReady");
		}
		Loop;

	// Dummy hide for equipment throws on PSP_FLASH only (never Goto Ready3 / HideWeaponDuringAction here).
	EquipmentFlashHide:
		TNT1 AAAAAAAAAAAAAA 1;
		Stop;

	// Override PB Staging's GoingToReady to clear stale melee overlay (-998)
	GoingToReady:
		TNT1 A 0 A_JumpIfInventory ("HasBarrel", 1, "ReadyBarrel");
		TNT1 A 0 A_JumpIfInventory ("HasFlameBarrel", 1, "ReadyFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("HasIceBarrel", 1, "ReadyIceBarrel");
	SelectingAnimation:
		TNT1 A 0 {
			A_TakeInventory("KeepLaserDeactivated",1);
			A_TakeInventory("DoGrenade",1);
			A_TakeInventory("IsRunning",1);
			A_TakeInventory("Reloading",1);
			A_LegOverlay(-1000, "FirstPersonLegsStand");
			A_OverlayFlags(-1000, PSPF_ADDWEAPON|PSPF_ADDBOB, False);
			A_SetInventory("Grabbing_A_Ledge",0);
			A_SetInventory("Kicking",0);
			PB_SetUsingKick(false);
			PB_SetUsingMelee(false);
			PB_SetUsingEquipment(false);
			PB_SetExecutingEnemy(false);
			A_ClearReFire();
			A_ClearOverlays(-999, -998, false);
			A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
			PB_EnsureOverlayHandlers();
			PB_RestoreWeaponReadyOverlay();
		}
		TNT1 A 0 A_JumpIfInventory("Zoomed",1,"Ready2");
		TNT1 A 0 A_Jump(256,"Ready3");
		TNT1 A 0 A_Jump(256,"Ready");
		Wait;

	// Override PB Staging's GoingToReady2 to clear PSP_FLASH from one-handed melee
	GoingToReady2:
		TNT1 A 0 {
			A_TakeInventory("KeepLaserDeactivated",1);
			A_TakeInventory("ToggleEquipment",1);
			PB_SetUsingMelee(false);
			PB_SetUsingEquipment(false);
			A_LegOverlay(-1000, "FirstPersonLegsStand");
			A_ClearReFire();
			A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
			A_ClearOverlays(-999, -998, false);
			PB_EnsureOverlayHandlers();
			PB_RestoreWeaponReadyOverlay();
		}
		TNT1 A 0 A_JumpIfInventory("SawSelected", 1, "Reselect");
		TNT1 AAAA 0 A_Jump(256, "SelectAnimation");
		TNT1 AAAA 1 A_Jump(256, "Ready");
		Loop;

    // Reset Melee Wheel Tokens
    WheelCancelMelee:
        TNT1 A 0
            {
            A_SetInventory("WW_StandardMeleeSelected",0);
            A_SetInventory("WW_FistComboMeleeSelected",0);
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
            if(CountInv("WW_FistComboMeleeSelected") && CountInv("FistComboMeleeSelected") >=1)
                {A_Print("Melee already selected: Fist Combos"); return ResolveState("WheelCancelMelee");}
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
                        A_SetInventory("FistComboMeleeSelected",0);
                        A_StartSound("GRNPIN", 3);
                        return ResolveState("WheelCancelMelee");
                    }
                if(CountInv("WW_FistComboMeleeSelected") >=1)
                    {
                        A_Print("Melee Selected: Fist Combos");
                        A_SetInventory("StandardMeleeSelected",0);
                        A_SetInventory("FistComboMeleeSelected",1);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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
                        A_SetInventory("FistComboMeleeSelected",0);
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

	// Shadow Staging handler: slot-1 melee weapons may quick-punch while holding fire.
	Melee_Equipment_Handler_Overlay:
		TNT1 A 1 {
			if (PB_QuickMeleeInputAllowed(false) && !FindInventory("RevGunSelected"))
			{
				if (JustPressed(BT_USER1) && !PB_usingMelee() && !PB_executingEnemy() && !PB_usingEquipment() && !CheckInventory("CantDoAction", 1))
				{
					if (CheckInventory("DoingHelmetAnim", 1))
					{
						A_TakeInventory("PB_NoEffectInvul", 1);
						A_TakeInventory("sae_extcam", 1);
						A_TakeInventory("sae_deathcam", 1);
						A_TakeInventory("CantDoAction", 1);
						A_TakeInventory("DoingHelmetAnim", 1);
					}
					if (!PB_usingKick())
					{
						A_OverlayOffset(PSP_WEAPON, 0, 32);
						PB_SetUsingEquipment(true);
						A_Overlay(PSP_WEAPON, "UseEquipment");
						A_OverlayOffset(PSP_WEAPON, 0, 32);
					}
				}
				if (JustPressed(BT_USER2) && !PB_usingMelee() && !PB_executingEnemy() && !PB_usingEquipment() && !CheckInventory("CantDoAction", 1))
				{
					if (CheckInventory("DoingHelmetAnim", 1))
					{
						A_TakeInventory("PB_NoEffectInvul", 1);
						A_TakeInventory("sae_extcam", 1);
						A_TakeInventory("sae_deathcam", 1);
						A_TakeInventory("CantDoAction", 1);
						A_TakeInventory("DoingHelmetAnim", 1);
					}
					PB_SetUsingMelee(true);
					A_Overlay(PSP_QUICKMELEE, "QuickMelee");
					if (CountInv("SawMeleeSelected") >= 1)
						PB_AnchorSawWheelOverlay();
					else
						A_OverlayOffset(PSP_QUICKMELEE, 0, 32);
				}
			}
			else
			{
				if (JustPressed(BT_USER1) && !PB_executingEnemy() && !PB_usingMelee())
				{
					if (CheckInventory("DoingHelmetAnim", 1))
					{
						A_TakeInventory("PB_NoEffectInvul", 1);
						A_TakeInventory("sae_extcam", 1);
						A_TakeInventory("sae_deathcam", 1);
						A_TakeInventory("CantDoAction", 1);
						A_TakeInventory("DoingHelmetAnim", 1);
					}
					if (FindInventory("RevGunSelected") && !player.FindPSprite(PSP_RevenantLauncherLayer))
					{
						A_OverlayOffset(PSP_RevenantLauncherLayer, 0, 32);
						A_Overlay(PSP_RevenantLauncherLayer, "FireRevGun");
						A_OverlayPivotAlign(PSP_RevenantLauncherLayer, PSPA_CENTER, PSPA_CENTER);
						A_OverlayFlags(PSP_RevenantLauncherLayer, PSPF_RENDERSTYLE, true);
						A_OverlayOffset(PSP_RevenantLauncherLayer, 0, 32);
					}
				}
				if (JustPressed(BT_USER2) && !PB_usingMelee() && !PB_executingEnemy() && !PB_usingEquipment() && !CheckInventory("CantDoAction", 1) && PB_QuickMeleeInputAllowed(true))
				{
					if (CheckInventory("DoingHelmetAnim", 1))
					{
						A_TakeInventory("PB_NoEffectInvul", 1);
						A_TakeInventory("sae_extcam", 1);
						A_TakeInventory("sae_deathcam", 1);
						A_TakeInventory("CantDoAction", 1);
						A_TakeInventory("DoingHelmetAnim", 1);
					}
					PB_SetUsingMelee(true);
					A_Overlay(PSP_QUICKMELEE, "QuickMelee");
					if (CountInv("SawMeleeSelected") >= 1)
						PB_AnchorSawWheelOverlay();
					else
						A_OverlayOffset(PSP_QUICKMELEE, 0, 32);
				}
			}
			if (CountInv("Zoomed") > 0 && FindInventory("RevGunSelected") && (PressingUser1() || player.FindPSprite(PSP_RevenantLauncherLayer)))
				A_OverlayScale(PSP_RevenantLauncherLayer, 1.3398);
			else
			{
				A_OverlayScale(PSP_RevenantLauncherLayer, 1.0);
				A_OverlayRenderstyle(PSP_RevenantLauncherLayer, STYLE_Normal);
			}
		}
		Loop;
    }
}