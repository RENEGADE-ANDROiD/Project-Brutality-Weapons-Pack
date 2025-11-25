//CALAMITY BLADE Codes(HEATWAVE GENERATOR)
class NSV_CalamityBladeCodes : PB_Weapon
{
    int ChargeLevel;
	Default
	{
		//$Category "Weapons/Legacy of Rust"
		//Height 20;
		//Weapon.SlotNumber 7;
		//Weapon.SelectionOrder 80;
		//Weapon.SlotPriority 255;
		//Weapon.AmmoUse 10;
		//Weapon.AmmoGive 50;
		//Weapon.AmmoType "NSV_Fuel";
		//+WEAPON.NOAUTOFIRE;
		//+WEAPON.NOALERT;
		//Weapon.UpSound "Weapon/HeatwaveUp";
		//Inventory.PickupMessage "You got the Calamity blade!  Hot damn!";
		//Tag "Calamity Blade";
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
			TNT1 A 0 A_DoPBWeaponAction();
			TNT1 A 0 {
				A_SetInventory("PB_LockScreenTilt",1);
				A_SetCrosshair(5);
				}			
			goto ready3;

	Reload:
		WeaponSpecial:
			TNT1 A 0 A_setinventory("GoWeaponSpecialAbility",0);
			TNT1 A 0 PB_WeaponRecoil(-4,frandom(-1.5,1.5));
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
			Goto Ready3;

		Select:
			TNT1 A 0 PB_WeaponRaise();
			TNT1 A 0 {PB_HandleCrosshair(69);}
			TNT1 A 0 A_SetInventory("RandomHeadExploder",1);
			TNT1 A 0 PB_RespectIfNeeded();
			TNT1 A 0 A_weaponoffset(0,32);
			goto SelectFirstPersonLegs;
		SelectContinue:
			TNT1 A 0 PB_RespectIfNeeded();
		SelectAnimation:
			TNT1 A 0
		{
			A_ZoomFactor(1);
			A_StartSound("WP9/UP1",7);
		}
		HRTG A 1 A_WeaponOffset(0, 99,WOF_INTERPOLATE);
		HRTG A 1 A_WeaponOffset(0, 66,WOF_INTERPOLATE);
		HRTG A 1 A_WeaponOffset(0, 33,WOF_INTERPOLATE);
		goto ready;
	Deselect:
		TNT1 A 0 {PB_HandleCrosshair(69);}
		TNT1 A 0 A_ClearOverlays(10,11);
			TNT1 A 0 PB_jumpIfHasBarrel("PlaceBarrel","PlaceFlameBarrel","PlaceIceBarrel");
			TNT1 A 0
		{
			A_StopSound(6);
			A_StopSound(7);
			A_ZoomFactor(1);
		}
		HRTG A 1 A_WeaponOffset(0, 33,WOF_INTERPOLATE);
		HRTG A 1 A_WeaponOffset(0, 66,WOF_INTERPOLATE);
		HRTG A 1 A_WeaponOffset(0, 99,WOF_INTERPOLATE);
		TNT1 A 3;
		TNT1 A 0 A_lower;
		wait;
	Ready:
		TNT1 A 0 A_WeaponOffset(0,32);
		TNT1 A 0 PB_HandleCrosshair(42);
	Ready3:
		HRTG A 1 {
				PB_CoolDownBarrel(0, 0, 3);
				return A_DoPBWeaponAction();
		}
			loop;
	Fire:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 {
				A_WeaponOffset(0,32);
				A_SetRoll(0);
				PB_HandleCrosshair(42);
				A_SetInventory("PB_LockScreenTilt",0);
				PB_WeaponRecoil(-4,frandom(-1.5,1.5));
		}
		TNT1 A 0 A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_NOFIRE);
	Charging:
		//HETG A 0;
		HRTG A 0 A_ChargeShow();
		HRTG H 12 Bright { A_CalamityBladeCharge(); A_GunFlash(); }
		HRTG A 0
		{
			if(invoker.ChargeLevel >= 5 || CountInv("PB_Fuel") < 10)
			return ResolveState("Unleash");
			return ResolveState(null);
		}
		HRTG A 0 A_Refire("Charging");
		goto Unleash;
	Unleash:
		HEFT A 0 A_CalamityBladeFire();
		HEFT A 0 A_AlertMonsters;
		HEFT A 0 A_ClearOverlays();	
		HEFT A 0 A_Quake(5,6,0,1,"none");
		HRTF A 2 bright A_GunFlash();
		HRTF B 3 Bright;
		HRTG EEEEEEDDCC 2;
		HRTG B 1 A_CheckReload();
		HRTG BBBBBFFGGAAHHHHHHA 1;
		HRTG A 0 A_Refire();
		Goto Ready;
	Flash:
		TNT1 A 3 A_Light1;
		TNT1 A 5 A_Light2;
		Goto LightDone;	
	Charge1:
		HETC ABCD 4 Bright A_Light1;
		goto LightDone;
	Charge2:
		HETC EFGH 4 Bright A_Light1;
		goto LightDone;
	Charge3:
		HETC IJKL 4 Bright A_Light1;
		goto LightDone;
	Charge4:
		HETC MNOP 4 Bright A_Light1;
		goto LightDone;
	Charge5:
		HETC QRST 4 Bright A_Light1;
		goto LightDone;

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
		HETG G 1 BRIGHT ;
		HETG H 0 BRIGHT A_PlaySound("ArgentBarrier/On",7);
		HETG G 1 BRIGHT;
		HETG F 1 BRIGHT;
		HETG G 1 BRIGHT;
		HETG H 1 BRIGHT;
		HETG G 1 BRIGHT A_Refire;
		Goto AltEnd;

	AltHold:
	    	HETG F 0 A_JumpIfInventory("PB_DTech", 1, "AltHoldContinue");
		HETG FGHF 1 BRIGHT A_Print("Not Enough PB_DTech");
	    Goto AltEnd;

	AltHoldContinue:
		HETG G 1 BRIGHT A_PlaySound("ArgentBarrier/Loop",7);
		HETG H 1 BRIGHT {
		     A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
			 }
		HETG G 1 BRIGHT {
		     A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
			 }
		HETG F 1 BRIGHT {
		     A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
			 }
		HETG G 1 BRIGHT {
		     A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
			 }
		HETG H 1 BRIGHT {
		     A_FireCustomMissile("KatanaShieldSpawnerYEET2", 0, 0, 0, -35);
			 }
		HETG G 0 A_TakeInventory("PB_DTech",1);
		HETG G 1 BRIGHT A_Refire;
		Goto AltEnd;

	AltEnd:
		HETG F 1 BRIGHT A_ReFire ;
		HETG G 1 BRIGHT A_ReFire ;
		HETG H 1 BRIGHT A_ReFire ;
		HETG G 1 BRIGHT A_ReFire ;
		HETG F 1 BRIGHT A_ReFire ;
		HETG G 0 BRIGHT A_PlaySound("ArgentBarrier/Off",7);
		HETG H 1 BRIGHT A_ReFire;
		HETG G 1 BRIGHT A_ReFire;
		HETG F 1 BRIGHT A_ReFire;
		HETG G 1 BRIGHT A_ReFire;
		HETG H 1 BRIGHT A_ReFire;
		HETG G 1 BRIGHT A_ReFire;
		Goto Ready;

		////////////////////////////////////////////////////////////////////////
		//	kick flashes
		////////////////////////////////////////////////////////////////////////
		
		FlashPunching:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			TNT1 ABCDEFGGFEDCBA 1;
			stop;
		
		FlashKicking:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			HETG A 14;
			goto ready;
			
		FlashAirKicking:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			HRTG A 14;
			goto ready;
			
		FlashSlideKicking:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			HRTG A 14;
			goto ready;
			
		FlashSlideKickingStop:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			HRTG A 7;
			goto ready;
		}
	action void A_CalamityBladeCharge()
	{
		A_StartSound("Weapon/HeatwaveCharge");
		if(invoker.ChargeLevel < 5 && CountInv("PB_Fuel") >= 10)
		{
			if(!sv_infiniteammo)
			A_TakeInventory("PB_Fuel",10);
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
		if(invoker.ChargeLevel == 1)
		{	
			A_FireProjectile("NSV_CalamitySlice",5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",0,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-5,0,flags:FPF_NOAUTOAIM);	
		}
		if(invoker.ChargeLevel == 2)
		{	
			A_FireProjectile("NSV_CalamitySlice",12.5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",7.5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",2.5,0,flags:FPF_NOAUTOAIM);	
			A_FireProjectile("NSV_CalamitySlice",-2.5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-7.5,0,flags:FPF_NOAUTOAIM);			
			A_FireProjectile("NSV_CalamitySlice",-12.5,0,flags:FPF_NOAUTOAIM);		
		}
		if(invoker.ChargeLevel == 3)
		{	
			A_FireProjectile("NSV_CalamitySlice",20,0,flags:FPF_NOAUTOAIM);	
			A_FireProjectile("NSV_CalamitySlice",15,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",10,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",0,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-10,0,flags:FPF_NOAUTOAIM);			
			A_FireProjectile("NSV_CalamitySlice",-15,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-20,0,flags:FPF_NOAUTOAIM);			
		}
		if(invoker.ChargeLevel == 4)
		{	
			A_FireProjectile("NSV_CalamitySlice",27.5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",22.5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",17.5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",12.5,0,flags:FPF_NOAUTOAIM);	
			A_FireProjectile("NSV_CalamitySlice",7.5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",2.5,0,flags:FPF_NOAUTOAIM);			
			A_FireProjectile("NSV_CalamitySlice",-2.5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-7.5,0,flags:FPF_NOAUTOAIM);			
			A_FireProjectile("NSV_CalamitySlice",-12.5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-17.5,0,flags:FPF_NOAUTOAIM);			
			A_FireProjectile("NSV_CalamitySlice",-22.5,0,flags:FPF_NOAUTOAIM);			
			A_FireProjectile("NSV_CalamitySlice",-27.5,0,flags:FPF_NOAUTOAIM);			
		}
		if(invoker.ChargeLevel >= 5)
		{	
			A_FireProjectile("NSV_CalamitySlice",35,0,flags:FPF_NOAUTOAIM);	
			A_FireProjectile("NSV_CalamitySlice",30,0,flags:FPF_NOAUTOAIM);	
			A_FireProjectile("NSV_CalamitySlice",25,0,flags:FPF_NOAUTOAIM);	
			A_FireProjectile("NSV_CalamitySlice",20,0,flags:FPF_NOAUTOAIM);	
			A_FireProjectile("NSV_CalamitySlice",15,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",10,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",0,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-5,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-10,0,flags:FPF_NOAUTOAIM);			
			A_FireProjectile("NSV_CalamitySlice",-15,0,flags:FPF_NOAUTOAIM);
			A_FireProjectile("NSV_CalamitySlice",-20,0,flags:FPF_NOAUTOAIM);				
			A_FireProjectile("NSV_CalamitySlice",-25,0,flags:FPF_NOAUTOAIM);				
			A_FireProjectile("NSV_CalamitySlice",-30,0,flags:FPF_NOAUTOAIM);				
			A_FireProjectile("NSV_CalamitySlice",-35,0,flags:FPF_NOAUTOAIM);				
		}
		invoker.ChargeLevel = 0;
	}
}