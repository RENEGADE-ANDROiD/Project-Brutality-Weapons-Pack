// Dismantler — Cyberaugumented venerated truncheon (folded from DCY_VeneratedTruncheon).

class PBWP_Dismantler : PBWP_CA_WeaponBase
{
	default
	{
		Weapon.SlotNumber 8;
		Weapon.SlotPriority 0.11;
		Weapon.AmmoType1 "PB_DTech";
		Weapon.AmmoType2 "PBWP_DismantlerMag";
		Weapon.AmmoGive1 0;
		Weapon.AmmoGive2 100;
		+WEAPON.BFG;
		+WEAPON.NOAUTOFIRE;
		+WEAPON.NOAUTOAIM;
		+FLOORCLIP;
		Tag "Dismantler";
		Inventory.PickupMessage "Now you hold the Dismantler. Sacred incineration.";
		Inventory.PickupSound "VeneratedTruncheon/Pickup";
		Weapon.UpSound "VeneratedTruncheon/Up";
		Inventory.Icon "LTBRA0";
		Obituary "%o was incinerated by %k's Dismantler.";
	}

	action void PBWP_DismantlerBeam()
	{
		A_FireCustomMissile("PBWP_CA_VeneratedBeam", frandom(-10, 10), 0);
		A_QuakeEx(3, 3, 3, 15, 0, 1000, "", QF_SCALEDOWN, falloff: 1600);
		if ((level.time % 2) == 1) A_TakeInventory("PBWP_DismantlerMag", 1);
		if ((level.time % 3) == 1) A_StartSound("VeneratedTruncheon/LaserShoot", 9, CHANF_OVERLAP);
	}

	states
	{
	Spawn:
		LTBR A -1;
		Stop;

		Steady:
		TNT1 A 1;
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 SetPlayerProperty(0, 0, 0);
		TNT1 A 0 SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
		Goto Ready3;

		Select:
		TNT1 A 0 A_WeaponOffset(0, 32);
		Goto SelectFirstPersonLegs;

	SelectContinue:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 PB_WeaponRaise("VeneratedTruncheon/Up");
		TNT1 A 0 PB_WeapTokenSwitch("PlasmagunSelected");
		TNT1 A 0 PB_SetMagUnloaded(false);
		TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
		Goto Ready3;
	SelectAnimation:
		LTBR BCD 1 A_WeaponReady(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(76); }
		LTBR BCDE 2 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PBWP_DismantlerMag", 1, 2);
		Goto ReloadMag;
		TNT1 A 0 PBWP_CA_LockTilt();
		LTBR F 4 A_StartSound("VeneratedTruncheon/LaserCharge", CHAN_WEAPON, CHANF_DEFAULT, 1.0, 0.85);
		LTBR GH 4;
		LTBR H 0 A_SetBlend("White", 0.75, 15);
		LTBR P 0 A_StartSound("VeneratedTruncheon/Ball/Fire", CHAN_5, CHANF_DEFAULT, 1.0, 0.65);
		Goto Hold;

		Hold:
		LTBR P 1 { PBWP_DismantlerBeam(); }
		LTBR Q 1 { PBWP_DismantlerBeam(); }
		TNT1 A 0 A_Refire("Hold");
	StopFiring:
		LTBR G 0 A_StartSound("VeneratedTruncheon/LaserSpawn", CHAN_WEAPON, CHANF_DEFAULT, 1.0, 0.95);
		LTBR GFEDC 4;
		TNT1 A 0 PBWP_CA_UnlockTilt();
		Goto Ready3;

	ReloadMag:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 PB_CheckReload(null, "DoReload", null, "Ready3", "Ready3", 100, 1);
		Goto Ready3;
	DoReload:
		TNT1 A 10 { PB_AmmoIntoMag("PBWP_DismantlerMag", "PB_DTech", 100, 1, 1); }
		Goto Ready3;

		Unload:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 { PB_SetMagUnloaded(true); PB_UnloadMag("PBWP_DismantlerMag", "PB_DTech", 1, 1, 100, 0, null); }
		Goto Ready3;

		Weaponspecial:
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		Goto Ready3;

		FlashPunching:
		TNT1 AAAAAAAAAAAAAA 1 A_DoPBWeaponAction();
		Stop;
		FlashKicking:
		TNT1 AAAAAAAAAAAAAAA 1 A_DoPBWeaponAction();
		Stop;
		FlashAirKicking:
		TNT1 AAAAAAAAAAAAAAAA 1 A_DoPBWeaponAction();
		Stop;
		FlashSlideKicking:
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 1 A_DoPBWeaponAction();
		Stop;
		FlashSlideKickingStop:
		TNT1 AAAAAAA 1 A_DoPBWeaponAction();
		Stop;

		Flash:
		TNT1 A 1 A_Light1();
		TNT1 A 3 A_Light0();
		Goto LightDone;
	}
}
