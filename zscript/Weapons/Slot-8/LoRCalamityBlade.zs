class LoRCalamityBlade : PB_WeaponBase
{
    int ChargeLevel;
	Default
	{
		//$Category "Weapons/Legacy of Rust"
		Weapon.SlotNumber 8;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 120;
		Weapon.AmmoGive2 120;
		Weapon.AmmoType "PB_Fuel";
		Weapon.AmmoType2 "PB_DTECH";
		PB_WeaponBase.respectItem "RespectPB_CalamityBlade";
		Inventory.AltHUDIcon "BFUGB0";
		scale 0.85;
		+WEAPON.NOAUTOFIRE
		+WEAPON.NOALERT
		+WEAPON.NOAUTOAIM
		+DONTGIB
		Weapon.UpSound "Weapon/HeatwaveUp";
		Inventory.PickupMessage "You got the Calamity blade!  Hot damn!";
		Tag "Calamity Blade";
	}
	States
	{
	Spawn:
		BFUG B -1;
		Stop;	
	Steady:
		TNT1 A 0 A_SetRoll(0);
		TNT1 A 1 {
				A_TakeInventory("GoWeaponSpecialAbility",1);
				A_TakeInventory("Grabbing_A_Ledge",1);
				A_TakeInventory("UseEquipment",1);
				A_TakeInventory("ToggleEquipment",1);
				A_TakeInventory("Taunting",1);
				A_TakeInventory("Salute1",1);
				A_TakeInventory("Salute2",1);
				A_TakeInventory("Kicking",1);
			}
	    Goto Ready;
		WeaponRespect:
			TNT1 A 0 A_GiveInventory("RespectPB_CalamityBlade", 1);
			TNT1 A 0 A_DoPBWeaponAction();
			TNT1 A 0 {
				A_SetInventory("PB_LockScreenTilt", 1);
				A_SetCrosshair(5);
			}
			Goto SelectAnimation;
		Select:
			TNT1 A 0 A_TakeInventory("HasBarrel", 1);
			TNT1 A 0 A_TakeInventory("HasIceBarrel", 1);
			TNT1 A 0 A_TakeInventory("HasFlameBarrel", 1);
			TNT1 A 0 A_TakeInventory("GrabbedBarrel", 1);
			TNT1 A 0 A_TakeInventory("GrabbedIceBarrel", 1);
			TNT1 A 0 A_TakeInventory("GrabbedFlameBarrel", 1);
			TNT1 A 0 A_weaponoffset(0, 32);
			TNT1 A 0 { PB_HandleCrosshair(69); }
			Goto SelectFirstPersonLegs;
		SelectContinue:
			TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
			TNT1 A 0 PB_WeaponRaise("Weapon/HeatwaveUp");
			TNT1 A 0 PB_WeapTokenSwitch("AddonSelected");
			TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
			TNT1 A 0 { return PB_RespectIfNeeded(); }
		SelectAnimation:
			HRTG A 1 A_WeaponOffset(0, 99,WOF_INTERPOLATE);
			HRTG A 1 A_WeaponOffset(0, 66,WOF_INTERPOLATE);
			HRTG A 1 A_WeaponOffset(0, 33,WOF_INTERPOLATE);
			goto Ready3;
	Deselect:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 { PB_HandleCrosshair(69); }
		TNT1 A 0 A_ClearReFire();
		TNT1 A 0 A_ClearOverlays(-2, -2);
		TNT1 A 0 A_ClearOverlays(10, 11);
		TNT1 A 0 {
			invoker.ChargeLevel = 0;
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			A_OverlayScale(PSP_WEAPON, 1, 1);
			A_OverlayRotate(OverlayID(), 0);
			A_TakeInventory("RandomHeadExploder", 1);
			A_TakeInventory("PB_LockScreenTilt", 1);
			A_StopSound(1);
			A_StopSound(5);
			A_StopSound(6);
			A_StopSound(7);
			A_StopSound(CHAN_AUTO);
			A_StopSound(CHAN_WEAPON);
			A_ZoomFactor(1);
		}
		Goto DeselectDown;
	DeselectDown:
		TNT1 AAAAAAAAAAAAAAAAAA 0 A_Lower(120);
		Wait;
	Ready:
		TNT1 A 0 A_WeaponOffset(0, 32);
		TNT1 A 0 PB_HandleCrosshair(42);
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 PB_RespectIfNeeded;
	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 {
			PB_HandleCrosshair(42);
			A_TakeInventory("PB_LockScreenTilt", 1);
			PB_CoolDownBarrel(0, 0, 3);
		}
		HRTG A 1 A_DoPBWeaponAction;
		Loop;
// Main Attacks states
	Charge1:
		HETC ABCD 4 Bright A_Light1;
		Stop;
	Charge2:
		HETC EFGH 4 Bright A_Light1;
		Stop;
	Charge3:
		HETC IJKL 4 Bright A_Light1;
		Stop;
	Charge4:
		HETC MNOP 4 Bright A_Light1;
		Stop;
	Charge5:
		HETC QRST 4 Bright A_Light1;
		Stop;
	Flash:
		TNT1 A 3 A_Light1;
		TNT1 A 5 A_Light2;
		Stop;
	Fire:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 {
				invoker.ChargeLevel = 0;
				A_WeaponOffset(0,32);
				A_SetRoll(0);
				PB_HandleCrosshair(42);
				A_SetInventory("PB_LockScreenTilt",0);
				PB_WeaponRecoil(-4,frandom(-1.5,1.5));
		}
		TNT1 A 0 A_JumpIfInventory("PB_Fuel",10,1);
		Goto DryFire;
		Goto Charging;
	Charging:
		HRTG A 0 A_ChargeShow();
		HRTG A 0 A_GunFlash();
		HRTG H 12 Bright A_CalamityBladeCharge();
		HRTG A 0
		{
			if(invoker.ChargeLevel == 0)
				return ResolveState("DryFire");
			if(invoker.ChargeLevel >= 5 || CountInv("PB_Fuel") < 10)
				return ResolveState("Unleash");
			return ResolveState(null);
		}
		HRTG A 0 PB_ReFire("Charging");
		Goto Unleash;
	Unleash:
		TNT1 A 0
		{
			A_ClearOverlays(-2,-2);
			A_LoudFlash();
			A_CalamityBladeFire();
			A_FireProjectile("NLSmokeSpawner",0,0,0,-3);
			A_OverlayPivotAlign(1,PSPA_CENTER,PSPA_CENTER);
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),56,WOF_INTERPOLATE);
			//If(CVar.FindCVar("ZoomEffects").GetBool()) { A_ZoomFactor(1.030);}
			A_ZoomFactor(1.030);
		}
		HRTF A 2 BRIGHT
		{
			A_GunFeedback();
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),52,WOF_INTERPOLATE);
			//If(CVar.FindCVar("ZoomEffects").GetBool()) { A_ZoomFactor(1.020);}
			A_ZoomFactor(1.020);
		}

		HRTF B 3 BRIGHT
		{
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),48,WOF_INTERPOLATE);
		}
		HRTG D 3
		{
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),44,WOF_INTERPOLATE);
		}
		HRTG C 3
		{
			A_CheckReload();
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),40,WOF_INTERPOLATE);
		}
		HRTG B 2
		{
			A_ZoomFactor(1);
			A_OverlayScale(PSP_WEAPON,1,1);
			A_OverlayRotate(OverlayID(),0);
		}
		TNT1 A 0 A_Refire();
		Goto Ready;

	Dryfire:
		HRTG A 1
		{
			A_StartSound("WP9/DF1",7);
			A_WeaponOffset(0,34,WOF_INTERPOLATE);
		}
		HRTG A 1;
		TNT1 A 0 A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_NOFIRE);
		Goto Ready3;

	AfterStates:
		TNT1 A 5 A_WeaponOffset(-7, 99,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(-5, 68,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(-3, 47,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(-1, 34,WOF_INTERPOLATE);
		Goto Ready;

	AltFire:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 {
			A_WeaponOffset(0,32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt",1);
		}
		HETG F 1 BRIGHT;
		HETG G 1 BRIGHT;
		HETG H 1 BRIGHT;
		HETG G 1 BRIGHT;
		HETG F 1 BRIGHT;
		HETG G 1 BRIGHT;
		HETG H 0 BRIGHT A_StartSound("ArgentBarrier/On", CHAN_5);
		HETG G 1 BRIGHT;
		HETG F 1 BRIGHT;
		HETG G 1 BRIGHT;
		HETG H 1 BRIGHT;
		HETG G 1 BRIGHT PB_ReFire;
		Goto AltEnd;

	AltHold:
		HETG F 0 A_JumpIfInventory("PB_DTech", 1, "AltHoldContinue");
		HETG FGHF 1 BRIGHT A_Print("Not Enough PB_DTech");
		Goto AltEnd;

	AltHoldContinue:
		HETG G 1 BRIGHT A_StartSound("ArgentBarrier/Loop", CHAN_5);
		HETG H 1 BRIGHT A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
		HETG G 1 BRIGHT A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
		HETG F 1 BRIGHT A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
		HETG G 1 BRIGHT A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
		HETG H 1 BRIGHT A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
		HETG G 0 A_TakeInventory("PB_DTech",1);
		HETG G 1 BRIGHT PB_ReFire;
		Goto AltEnd;

	AltEnd:
		HETG F 1 BRIGHT PB_ReFire;
		HETG G 1 BRIGHT PB_ReFire;
		HETG H 1 BRIGHT PB_ReFire;
		HETG G 1 BRIGHT PB_ReFire;
		HETG F 1 BRIGHT PB_ReFire;
		HETG G 0 BRIGHT A_StartSound("ArgentBarrier/Off", CHAN_5);
		HETG H 1 BRIGHT PB_ReFire;
		HETG G 1 BRIGHT PB_ReFire;
		HETG F 1 BRIGHT PB_ReFire;
		HETG G 1 BRIGHT PB_ReFire;
		HETG H 1 BRIGHT PB_ReFire;
		HETG G 1 BRIGHT PB_ReFire;
		Goto Ready;

		WeaponSpecial:
			TNT1 A 0 A_setinventory("GoWeaponSpecialAbility",0);
			TNT1 A 0 {
				A_SetInventory("GoWeaponSpecialAbility",0);
				A_SetInventory("Zoomed",0);
				A_SetInventory("ADSmode",0);
				A_SetInventory("PB_LockScreenTilt",1);
				A_WeaponOffset(0,32);
				PB_HandleCrosshair(42);
				A_ZoomFactor(1.0);
				A_ClearOverlays(10,11);
				}
			TNT1 A 0 A_Print("No WeaponSpecial!");
			Goto Ready3;		////////////////////////////////////////////////////////////////////////
		Reload:
			TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
			TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
			TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
			TNT1 A 0 { return ResolveState("PBWP_OffsetReloadAnim"); }
		//	kick flashes
		////////////////////////////////////////////////////////////////////////
		
		FlashPunching:
			TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_ClearOverlays(10, 11);
			HRTG A 1 A_WeaponOffset(0, 33, WOF_INTERPOLATE);
			HRTG A 1 A_WeaponOffset(0, 66, WOF_INTERPOLATE);
			HRTG A 1 A_WeaponOffset(0, 99, WOF_INTERPOLATE);
			TNT1 AAAAAAAAAAA 1;
			Stop;

		FlashKicking:
			TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelKicking");
			TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelKicking");
			TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelKicking");
			TNT1 A 0 A_ClearOverlays(10, 11);
			HRTG A 1;
			TNT1 A 0 A_WeaponOffset(0, 32);
			TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
			Goto Ready3;

		FlashAirKicking:
			TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelAirKicking");
			TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelAirKicking");
			TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelAirKicking");
			TNT1 A 0 A_ClearOverlays(10, 11);
			HRTG A 1;
			TNT1 A 0 A_WeaponOffset(0, 32);
			TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
			Goto Ready3;

		FlashSlideKicking:
			TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelSlideKicking");
			TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelSlideKicking");
			TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelSlideKicking");
			TNT1 A 0 A_ClearOverlays(10, 11);
			HRTG A 1;
			TNT1 A 0 A_WeaponOffset(0, 32);
			TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
			Goto Ready3;

		FlashSlideKickingStop:
			TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelSlideKickingStop");
			TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelSlideKickingStop");
			TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelSlideKickingStop");
			TNT1 A 0 A_ClearOverlays(10, 11);
			HRTG A 1;
			TNT1 A 0 A_WeaponOffset(0, 32);
			TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
			Goto Ready3;
		}
	
	action void A_CalamityBladeCharge()
	{
		A_StartSound("Weapon/HeatwaveCharge");
		if (invoker.ChargeLevel < 5 && CountInv("PB_Fuel") >= 10)
		{
			if (!sv_infiniteammo)
				A_TakeInventory("PB_Fuel", 10);
			invoker.ChargeLevel++;
		}
	}

	action void A_ChargeShow()
	{
		if(invoker.ChargeLevel == 0)
			A_Overlay(-2,"Charge1",FALSE);
		if(invoker.ChargeLevel == 1)
			A_Overlay(-2,"Charge2",FALSE);
		if(invoker.ChargeLevel == 2)
			A_Overlay(-2,"Charge3",FALSE);
		if(invoker.ChargeLevel == 3)
			A_Overlay(-2,"Charge4",FALSE);
		if(invoker.ChargeLevel >= 4)
			A_Overlay(-2,"Charge5",FALSE);	
	}
	action void A_CalamityBladeFire()
	{
		A_StartSound("Weapon/HeatwaveFire");
		if (invoker.ChargeLevel == 1)
		{
			A_FireProjectile("NSV_CalamitySlice", 5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 0, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -5, 0, flags: FPF_NOAUTOAIM);
		}
		if (invoker.ChargeLevel == 2)
		{
			A_FireProjectile("NSV_CalamitySlice", 12.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 7.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 2.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -2.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -7.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -12.5, 0, flags: FPF_NOAUTOAIM);
		}
		if (invoker.ChargeLevel == 3)
		{
			A_FireProjectile("NSV_CalamitySlice", 20, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 15, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 10, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 0, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -10, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -15, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -20, 0, flags: FPF_NOAUTOAIM);
		}
		if (invoker.ChargeLevel == 4)
		{
			A_FireProjectile("NSV_CalamitySlice", 27.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 22.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 17.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 12.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 7.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 2.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -2.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -7.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -12.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -17.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -22.5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -27.5, 0, flags: FPF_NOAUTOAIM);
		}
		if (invoker.ChargeLevel >= 5)
		{
			A_FireProjectile("NSV_CalamitySlice", 35, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 30, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 25, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 20, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 15, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 10, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", 0, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -5, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -10, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -15, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -20, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -25, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -30, 0, flags: FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice", -35, 0, flags: FPF_NOAUTOAIM);
		}
		invoker.ChargeLevel = 0;
	}
	Action void A_LoudFlash() 
	{
		A_GunFlash();
		A_AlertMonsters();
	}

	Action void A_GunIdle() 
	{
		If (GetCvar("IdleEffects") == 1)
		{
			A_SetAngle(Angle -FRandom(-0.03,0.03));
			A_SetPitch(Pitch -FRandom(-0.03,0.03));	
		}
	}

	Action void A_GunFeedback() 
	{
		If (GetCvar("RecoilEffects") == 1)
		{
			A_Quake(1,2,0,1,0);
			A_SetPitch(Pitch - FRandom(0.400, 0.800),SPF_INTERPOLATE);
			A_SetAngle(Angle + FRandom(-0.500, 0.500),SPF_INTERPOLATE);
		}
	}
}
Class RespectPB_CalamityBlade : Inventory
{
	default
	{
		Inventory.maxamount 1;
	}
}
Class NSV_CalamitySlice : Actor
{
	Default
	{
		Radius 16;
		Height 8;
		Speed 30;
		Damage 50;
		Projectile;
		+RANDOMIZE
		+RIPPER
		+DOHARMSPECIES
		RenderStyle "Add";
		Damagetype "Fire";
		decal "BigScorch";
		Alpha 0.9;
		DeathSound "Weapon/HeatwaveExplosion";
	}
	Override void Tick() 
	{	
		Super.Tick();
		If (isFrozen())
		Return;
	}	
	States
	{
	Spawn:
		HETB ABC 3 BRIGHT
		{
			A_SpawnProjectile("NLSmokeSpawner",7,0,FRandom(0,360),2,FRandom(60,130));
			A_SpawnItemEx("NLWeaponSmoke",Random(-8,8),Random(-3,3),Random(-5,5),0,0,6,0,0,0);
			A_SpawnProjectile("NSV_CalamitySliceTrail",0,0,FRandom(0,360),2,FRandom(60,130));
		}
		Loop;
	Death:
		HETB DEFGHI 3 BRIGHT
		{
		    A_SpawnProjectile("LBWP0FlameImpact",0,0,Random(0,360),2,Random(-60,60));
			A_SpawnProjectile("EXPlosmokes",0,0,Random(0,360),2,FRandom(-20,-30));
		}
		Stop;
	}
}

Class NSV_CalamitySliceTrail : Actor
{
	Default
	{
		+MISSILE
		+NOBLOCKMAP
		+NOTELEPORT
		+DONTSPLASH
		+NOINTERACTION
		+CLIENTSIDEONLY
		+FORCEXYBILLBOARD
		Speed   3;
		Alpha   0.600;
		Radius  1;
		Height  1;
		Damage  0;
		Gravity 0;
		Projectile;
		RenderStyle "Add";
		DamageType "Fire";
		Decal "None";
		Scale 0.3;
	}
	States
	{
	Spawn:
		TNT1 A 1;
		HETB AAAAAAAAAABBBBBBBBBBCCCCCCCCCC 1 Bright A_FadeOut(0.1);
		Stop;
	}
}

