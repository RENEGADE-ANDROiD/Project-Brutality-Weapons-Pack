class PB_BeamKatana : PB_WeaponBase
{
	Default
	{
		Weapon.BobRangeX 0.3;
		Weapon.BobRangeY 0.5;
		Weapon.BobStyle "InverseSmooth";
		Weapon.BobSpeed 2.0;
		Weapon.Kickback 100;
		Weapon.AmmoType1 "PB_Cell";
		Weapon.AmmoGive 20;
		+WEAPON.NOALERT;
		+WEAPON.NOAUTOAIM;
		+WEAPON.MELEEWEAPON;
		+INVENTORY.ALWAYSPICKUP;
		+FORCEXYBILLBOARD;
		+DONTGIB;
		Inventory.PickupSound "CybKatana/Activate";
		Inventory.Pickupmessage "You got the UAC Nanotech Energy Beam Katana. (Slot 1)";
		Inventory.Icon "BKATK0";
		Obituary "It's Nothing Personal Boys. (Embrace My Katana)!";
		Weapon.SlotNumber 1;
		Scale 0.6;
		Tag "UAC Nanotech Energy Beam Katana";
		Inventory.AltHudIcon "BKATK0";
		PB_WeaponBase.RespectItem "RespectEnergy-Katana";
		FloatBobStrength 0.5;
	}

	States
   {
   Steady:
	    TNT1 A 1;
	    TNT1 A 0 {
			PB_SetUsingMelee(false);
		}
	    TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
	    TNT1 A 0 SetPlayerProperty(0, 0, 0);
	    TNT1 A 0 SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
	    Goto Ready;

   Ready:
        TNT1 A 0;
		TNT1 A 0;
   SelectAnimation:
		BKT0 DCBAE 1;
		BKAT A 0 A_StartSound("CybKatana/Activate");
	    TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
   Ready3:
		TNT1 A 0 {
			 A_WeaponOffset(0,32);
			 A_SetRoll(0);
			 A_TakeInventory("PB_LockScreenTilt",1);
			 }
		TNT1 A 0 PB_HandleCrosshair(90);
	    TNT1 A 0;
	KatanaReadyToCut:
		BKAT A 1 Bright {
			 return A_DoPBWeaponAction();
		     }
		BKAT A 0 A_GiveInventory("HasCutingWeapon",1);
		TNT1 A 0 A_JumpIfInventory("GoFatality",1,"Steady");
	    Loop;

	Deselect:
        TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "PlaceBarrel");
	    TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "PlaceFlameBarrel");
	    TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "PlaceIceBarrel");
	    TNT1 A 0 {
			 A_WeaponOffset(0,32);
			 A_SetRoll(0);
			 A_TakeInventory("PB_LockScreenTilt",1);
		     }
		BKAT A 0 A_Takeinventory("PowerBloodOnVisor",1);
		BKAT A 0 A_Takeinventory("PowerBlueBloodOnVisor",1);
		BKAT A 0 A_Takeinventory("PowerGreenBloodOnVisor",1);
		BKAT A 0 A_Takeinventory("HasCutingWeapon",1);
		TNT1 A 0 A_Lower(120);
		Wait;

	Select:
		TNT1 A 0 {
			 A_WeaponOffset(0,32);
			 A_SetRoll(0);
			 A_TakeInventory("PB_LockScreenTilt",1);
		     }
		TNT1 A 0 A_TakeInventory("HasBarrel",1);
	    TNT1 A 0 A_TakeInventory("HasIceBarrel",1);
	    TNT1 A 0 A_TakeInventory("HasFlameBarrel",1);
	    TNT1 A 0 A_TakeInventory("GrabbedBarrel",1);
	    TNT1 A 0 A_TakeInventory("GrabbedIceBarrel",1);
	    TNT1 A 0 A_TakeInventory("GrabbedFlameBarrel",1);
		Goto SelectFirstPersonLegs;
	SelectContinue:
		TNT1 A 0 A_Takeinventory("PowerBloodOnVisor",1);
		TNT1 A 0 A_Takeinventory("PowerBlueBloodOnVisor",1);
		TNT1 A 0 A_Takeinventory("PowerGreenBloodOnVisor",1);
			TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
			Goto Ready3;

	Reload:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "IdleBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "IdleFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "IdleIceBarrel");
		Goto KatanaReadyToCut;

	Fire:
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		TNT1 A 0 {
			if (CountInv("GoFatality") >= 1) SetPlayerProperty(0, 1, 0);
			else
			{
				SetPlayerProperty(0, 0, 0);
				SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
			}
		}
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 PB_CheckBarrelThrow1();
		TNT1 A 0 {
			if (CountInv("NoFatality") == 0 && GetCVar("ttwcfbex") == 1)
				return PB_Execute();
			return resolveState(null);
		}
		BKAT A 0 A_JumpIfInventory("KatanaSwitchHands", 1, "NormalCutAlt");
		BKAT A 1 Bright;
		BKAT C 1 Bright;
		BKAT D 1 Bright A_StartSound("CybKatana/Swing", CHAN_WEAPON);
		BKAT A 0 A_JumpIfInventory("PowerStrength", 1, "BerserkerCut");
		BKAT E 0 A_CustomPunch(5,true, CPF_STEALARMOR,"BKatSawPuff4",140,1,150,"ArmorShard","CybKatana/Hit","CybKatana/Swing");
		BKAT E 1 Bright A_CustomPunch(70,true,0,"BKatSawPuff4",180,0,0,"none","CybKatana/Hit","CybKatana/Swing");
	    Goto FinishCuttingAnimation;

	BerserkerCut:
		BKAT E 0 A_StartSound("CybKatana/Swing", CHAN_WEAPON);
		BKAT E 0 A_CustomPunch(5,true, CPF_STEALARMOR,"BKatSawPuff4",140,1,250,"ArmorShard","CybKatana/Hit","CybKatana/Swing");
		BKAT E 1 Bright A_CustomPunch(110,true,0,"BKatSawPuff4",180,0,0,"none","CybKatana/Hit","CybKatana/Swing");
		Goto FinishCuttingAnimation;

	FinishCuttingAnimation:
		BKAT G 1 Bright;
		BKAT H 1 Bright;
		BKAT I 1 Bright;
		BKAT J 1 Bright;
		BKAT Q 1 Bright;
		BKAT P 1 Bright;
		BKAT O 1 Bright;
		BKAT N 1 Bright;
		BKAT M 1 Bright;
		BKAT L 1 Bright A_GiveInventory("KatanaSwitchHands", 1);
		Goto KatanaReadyToCut;
	
	NormalCutAlt:
		BKAT A 1 Bright;
		BKT2 A 1 Bright;
		BKT2 B 1 Bright;
		BKT2 C 1 Bright;
		BKT2 D 1 Bright A_StartSound("CybKatana/Swing", CHAN_WEAPON);
		BKT2 A 0 A_JumpIfInventory("PowerStrength", 1, "BerserkerCutAlt");
		BKT2 E 0 A_CustomPunch(5,true, CPF_STEALARMOR,"BKatSawPuff4",140,1,150,"ArmorShard","CybKatana/Hit","CybKatana/Swing");
		BKT2 E 1 Bright A_CustomPunch(70,true,0,"BKatSawPuff4",180,0,0,"none","CybKatana/Hit","CybKatana/Swing");
	    Goto FinishCuttingAnimationAlt;

	BerserkerCutAlt:
		BKT2 E 0 A_StartSound("CybKatana/Swing", CHAN_WEAPON);
		BKT2 E 0 A_CustomPunch(5,true, CPF_STEALARMOR,"BKatSawPuff4",140,1,250,"ArmorShard","CybKatana/Hit","CybKatana/Swing");
		BKT2 E 1 Bright A_CustomPunch(110,true,0,"BKatSawPuff4",180,0,0,"none","CybKatana/Hit","CybKatana/Swing");
		Goto FinishCuttingAnimationAlt;

	FinishCuttingAnimationAlt:
		BKT2 G 1 Bright;
		BKT2 H 1 Bright;
		BKT2 I 1 Bright;
		BKT2 J 1 Bright;
		BKAT Q 1 Bright;
		BKAT P 1 Bright;
		BKAT O 1 Bright;
		BKAT N 1 Bright;
		BKAT M 1 Bright;
		BKAT L 1 Bright A_TakeInventory("KatanaSwitchHands", 1);
		Goto KatanaReadyToCut;

	QuickMelee:
		"####" A 0 {
			A_StopSound(CHAN_WEAPON);
			A_StopSound(CHAN_VOICE);
			A_StopSound(CHAN_6);
			A_StopSound(CHAN_5);
			A_StopSound(CHAN_7);
		}
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "QuickMeleeAbort");
		TNT1 A 0 A_JumpIfInventory("CantDoAction", 1, "FailOverlay");
		TNT1 A 0 A_JumpIfHealthLower(0, "FailOverlay");
		TNT1 A 0 A_ClearOverlays(3, 65);
		TNT1 A 0 A_GunFlash("Null");
		TNT1 A 0 A_JumpIfInventory("AlreadyThrownShieldSaw", 1, "GoMeleeInstead");
		TNT1 A 0 A_JumpIfCloser(99, "GoMeleeInstead");
		TNT1 A 0 {
			State st = PB_ResolveQuickMeleeShieldThrow();
			if (st)
				return st;
			return ResolveState(null);
		}
		TNT1 A 1 {
			State st = PB_Execute();
			if (st)
				return st;
			return ResolveState(null);
		}
		TNT1 A 0 A_JumpIfInventory("AlreadyThrownShieldSaw", 1, "GoMeleeInstead");
		TNT1 A 0 A_JumpIfCloser(99, "GoMeleeInstead");
	GoMeleeInstead:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "QuickMeleeAbort");
		TNT1 A 0 {
			PB_SetUsingMelee(true);
			A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
			A_PB_AirMeleeLunge(10);
			A_GiveInventory("HasCutingWeapon", 1);
			A_TakeInventory("Zoomed", 1);
			A_ZoomFactor(1.0);
			A_TakeInventory("ADSmode", 1);
			A_SetRoll(0);
			A_LegOverlay(-1000, "FirstPersonLegsStand");
			A_OverlayFlags(-1000, PSPF_ADDWEAPON|PSPF_ADDBOB, False);
			A_Overlay(PSP_WEAPON, "HideWeaponDuringAction");
			A_OverlayOffset(PSP_WEAPON, 0, 32);
		}
		Goto QuickCyborgMelee;

	QuickCyborgMelee:
		JSML ABCDEF 1 {
			if (CountInv("GoFatality") >= 1)
				return ResolveState("QuickMeleeAbort");
			if (JustPressed(BT_USER2))
			{
				State st = PB_Execute();
				if (st)
					return st;
			}
			return ResolveState(null);
		}
		PUFF A 0 A_PlaySound("player/cyborg/fist", 3);
		TNT1 A 0 {
			A_FireCustomMissile("Plasma_Ball", 20, 0);
			A_FireCustomMissile("Plasma_Ball", -20, 0);
			A_FireCustomMissile("Plasma_Ball", 10, 0, 0, 10);
			A_FireCustomMissile("Plasma_Ball", -10, 0, 0, -10);
			A_FireCustomMissile("Plasma_Ball", -15, 0, 0, -15);
			A_FireCustomMissile("Plasma_Ball", -8, 0, 0, -8);
		}
		JSML FGHIJKLMNOP 1 {
			if (CountInv("GoFatality") >= 1)
				return ResolveState("QuickMeleeAbort");
			if (JustPressed(BT_USER2))
			{
				State st = PB_Execute();
				if (st)
					return st;
			}
			return ResolveState(null);
		}
		TNT1 A 7 {
			if (CountInv("GoFatality") >= 1)
				return ResolveState("QuickMeleeAbort");
			if (JustPressed(BT_USER2))
			{
				State st = PB_Execute();
				if (st)
					return st;
			}
			return ResolveState(null);
		}
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;

	QuickMeleeAbort:
		TNT1 A 0 {
			PB_SetUsingMelee(false);
			A_TakeInventory("HasCutingWeapon", 1);
			A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
			A_ClearOverlays(PSP_WEAPON, PSP_WEAPON, false);
			A_ClearOverlays(-999, -998);
			A_ClearOverlays(-10, -10);
			A_ClearOverlays(3, 65);
			A_LegOverlay(-1000, "FirstPersonLegsStand");
			A_GunFlash("Null");
		}
		Goto Steady;

	AltFire:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		TNT1 A 0 A_JumpIfInventory("SlashModeToken", 1, "CuttingBlade");
		BKAT L 1 Bright;
		BKAT M 1 Bright;
		BKAT N 1 Bright;
		BKAT O 1 Bright;
		BKAT P 1 Bright;
		BKAT Q 1 Bright;
		BKT1 E 0 Bright A_StartSound("ForceBarrier/On", CHAN_5);
		BKT1 E 1 Bright;
		BKT1 D 1 Bright;
		BKT1 C 1 Bright;
		BKT1 B 1 Bright;
		BKT1 A 1 Bright PB_ReFire;
		Goto AltEnd;

	AltHold:
		BKT1 A 0 A_JumpIfInventory("PB_Cell", 1, "AltHoldContinue");
		BKT1 AAAA 1 Bright A_Print("\cgNot enough \ctcells \c-");
		Goto AltEnd;

	AltHoldContinue:
		BKT1 A 1 Bright A_StartSound("ForceBarrier/Loop", CHAN_5);
		BKT1 A 1 Bright A_FireCustomMissile("KatanaShieldSpawnerYEET", 0, 0, 0, -35);
		BKT1 A 1 Bright A_FireCustomMissile("KatanaShieldSpawnerYEET", 0, 0, 0, -35);
		BKT1 A 1 Bright A_FireCustomMissile("KatanaShieldSpawnerYEET", 0, 0, 0, -35);
		BKT1 A 1 Bright A_FireCustomMissile("KatanaShieldSpawnerYEET", 0, 0, 0, -35);
		BKT1 A 1 Bright A_FireCustomMissile("KatanaShieldSpawnerYEET", 0, 0, 0, -35);
		BKT1 A 0 A_TakeInventory("PB_Cell", 1);
		BKT1 A 1 Bright PB_ReFire;
		Goto AltEnd;

	AltEnd:
		BKT1 A 1 Bright PB_ReFire;
		BKT1 B 1 Bright PB_ReFire;
		BKT1 C 1 Bright PB_ReFire;
		BKT1 D 1 Bright PB_ReFire;
		BKT1 E 1 Bright PB_ReFire;
		BKT1 E 0 Bright A_StartSound("ForceBarrier/Off", CHAN_5);
		BKAT Q 1 Bright PB_ReFire;
		BKAT P 1 Bright PB_ReFire;
		BKAT O 1 Bright PB_ReFire;
		BKAT N 1 Bright PB_ReFire;
		BKAT M 1 Bright PB_ReFire;
		BKAT L 1 Bright PB_ReFire;
		Goto KatanaReadyToCut;

	PDA_Preview_BK_Ready:
		BKAT A 2 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		Stop;
	PDA_Preview_BK_Slash:
		BKAT B 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKAT C 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKAT D 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKAT E 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKAT G 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKAT H 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKAT I 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKAT J 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		Stop;
	PDA_Preview_BK_Barrier:
		BKAT L 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKT1 E 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKT1 D 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKT1 C 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKT1 B 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKT1 A 2 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKT1 B 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		BKAT L 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_ALLOWZOOM);
		Stop;

	WeaponSpecial:
	    TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "IdleBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "IdleFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "IdleIceBarrel");
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		TNT1 A 0 A_JumpIfInventory("ActivateWeaponSpecial", 1, "KatanaReadyToCut");

	ActivateWeaponSpecial:
		TNT1 A 0 A_JumpIfInventory("SlashModeToken", 1, "DisableSlashMode");
		TNT1 A 0 A_Print("\ctAlt fire:\c- \chSlash \c-mode");
		TNT1 A 0 A_StartSound("CybKatana/SwitchMode",0);
		TNT1 A 0 A_GiveInventory("SlashModeToken", 1);
		Goto KatanaReadyToCut;

	DisableSlashMode:
		TNT1 A 0 A_StartSound("CybKatana/SwitchMode",0);
		TNT1 A 0 A_TakeInventory("SlashModeToken", 1);
		TNT1 A 0 A_Print("\ctAlt fire:\c- \cdShield \c-mode");
		Goto KatanaReadyToCut;

	CuttingBlade:
	    BKAT A 0 A_JumpIfInventory("PB_Cell", 5, "SpecialCut");
		BKAT BBBB 1 Bright A_Print("\cgNot enough \ctcells \c-");
		Goto KatanaReadyToCut;

	SpecialCut:
		BKAT A 0 A_JumpIfInventory("KatanaSwitchHands", 1, "SpecialCutAlt");
		BKAT A 1 Bright;
		BKAT C 1 Bright;
		BKAT D 1 Bright A_StartSound("CybKatana/Swing", CHAN_WEAPON);
		BKAT E 1 Bright A_FireCustomMissile("SwordPlasmaSlash", 0, 1, 0, -5);
		BKAT F 1 Bright A_TakeInventory("PB_Cell",5);
		BKAT G 1 Bright;
		BKAT H 1 Bright;
		BKAT I 1 Bright;
		BKAT J 1 Bright;
		BKAT Q 1 Bright;
		BKAT P 1 Bright;
		BKAT O 1 Bright;
		BKAT N 1 Bright;
		BKAT M 1 Bright;
		BKAT L 1 Bright A_GiveInventory("KatanaSwitchHands", 1);
		Goto KatanaReadyToCut;

	SpecialCutAlt:
		BKAT A 1 Bright;
		BKT2 A 1 Bright;
		BKT2 B 1 Bright;
		BKT2 C 1 Bright;
		BKT2 D 1 Bright A_StartSound("CybKatana/Swing", CHAN_WEAPON);
		BKT2 E 1 Bright A_FireCustomMissile("SwordPlasmaSlashAlt", 0, 1, 0, -5);
		BKT2 F 1 Bright A_TakeInventory("PB_Cell",5);
		BKT2 G 1 Bright;
		BKT2 H 1 Bright;
		BKT2 I 1 Bright;
		BKT2 J 1 Bright;
		BKAT Q 1 Bright;
		BKAT P 1 Bright;
		BKAT O 1 Bright;
		BKAT N 1 Bright;
		BKAT M 1 Bright;
		BKAT L 1 Bright A_TakeInventory("KatanaSwitchHands", 1);
		TNT1 A 0 A_AlertMonsters;
		Goto KatanaReadyToCut;

	Spawn:
		BKAT K 0 NoDelay;
		BKAT K 10 A_PbvpFramework("BKAT");
	   "####" "#" 0 A_PbvpInterpolate();
		Loop;

	FlashKicking:
	    TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_JumpIfInventory("PowerGreenBloodOnVisor",1, 4);
		TNT1 A 0 A_JumpIfInventory("PowerBlueBloodOnVisor",1, 3);
		TNT1 A 0 A_JumpIfInventory("PowerBloodOnVisor",1, 2);
		BKAT A 1 A_DoPBWeaponAction;
		BKAT LMNOPQQQQQQ 1;
		BKAT PONML 1;
		BKAT A 1;
		Goto KatanaReadyToCut;

	FlashAirKicking:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_JumpIfInventory("PowerGreenBloodOnVisor",1, 4);
		TNT1 A 0 A_JumpIfInventory("PowerBlueBloodOnVisor",1, 3);
		TNT1 A 0 A_JumpIfInventory("PowerBloodOnVisor",1, 2);
		BKAT A 1 A_DoPBWeaponAction;
		BKAT LMNOPQQQQQQQ 1;
		BKAT PONML 1;
		BKAT A 1;
		Goto KatanaReadyToCut;

	FlashSlideKicking:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_JumpIfInventory("PowerGreenBloodOnVisor",1, 4);
		TNT1 A 0 A_JumpIfInventory("PowerBlueBloodOnVisor",1, 3);
		TNT1 A 0 A_JumpIfInventory("PowerBloodOnVisor",1, 2);
		BKAT A 1 A_DoPBWeaponAction;
		BKAT LMNOPQQQQQQQQQ 1;
		BKAT PONML 1;
		BKAT A 1;
		Goto KatanaReadyToCut;

	FlashSlideKickingStop:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_JumpIfInventory("PowerGreenBloodOnVisor",1, 4);
		TNT1 A 0 A_JumpIfInventory("PowerBlueBloodOnVisor",1, 3);
		TNT1 A 0 A_JumpIfInventory("PowerBloodOnVisor",1, 2);
		BKAT A 1 A_DoPBWeaponAction;
		Goto KatanaReadyToCut;

	FlashPunching:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "QuickMeleeAbort");
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 {
			PB_SetUsingMelee(true);
			A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
			A_PB_AirMeleeLunge(10);
			A_GiveInventory("HasCutingWeapon", 1);
			A_TakeInventory("Zoomed", 1);
			A_ZoomFactor(1.0);
			A_TakeInventory("ADSmode", 1);
			A_SetRoll(0);
			A_LegOverlay(-1000, "FirstPersonLegsStand");
			A_OverlayFlags(-1000, PSPF_ADDWEAPON|PSPF_ADDBOB, False);
			A_Overlay(PSP_WEAPON, "HideWeaponDuringAction");
			A_OverlayOffset(PSP_WEAPON, 0, 32);
			A_Overlay(PSP_QUICKMELEE, "QuickCyborgMelee");
		}
		Stop;
	}
}
