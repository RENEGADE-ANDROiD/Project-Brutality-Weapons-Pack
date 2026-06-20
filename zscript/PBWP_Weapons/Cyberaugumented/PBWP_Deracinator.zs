// Deracinator — Cyberaugumented slot-8 BFG (sprites DC7_; no ZScript in upstream — PB fold).

class PBWP_Deracinator : PBWP_CA_WeaponBase
{
	default
	{
		Weapon.SlotNumber 8;
		Weapon.SlotPriority 0.09;
		Weapon.AmmoType1 "PB_Cell";
		Weapon.AmmoGive1 40;
		Weapon.AmmoUse1 5;
		+WEAPON.BFG;
		+WEAPON.NOAUTOFIRE;
		Tag "Deracinator";
		Inventory.PickupMessage "You wield the Deracinator. Obliteration awaits.";
		Inventory.PickupSound "ObliterationBFG/Raise";
		Weapon.UpSound "ObliterationBFG/Raise";
		Inventory.Icon "BFG8A0";
		Obituary "%o was deracinated by %k's Deracinator.";
	}

	action void PBWP_DeracinatorFire()
	{
		A_FireCustomMissile("PBWP_CA_DeracinatorBolt", 0, 0);
		A_TakeInventory("PB_Cell", 5);
		A_GunFlash();
		A_QuakeEx(3, 3, 3, 25, 0, 800, "", QF_SCALEDOWN);
		A_AlertMonsters();
	}

	states
	{
	Spawn:
		BFG8 A -1;
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
		TNT1 A 0 PB_WeaponRaise("ObliterationBFG/Raise");
		TNT1 A 0 PB_WeapTokenSwitch("BFGSelected");
		TNT1 A 0 A_StartSound("ObliterationBFG/Idle", CHAN_6, CHANF_LOOPING, 1, 0.5);
		TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
		Goto Ready3;
	SelectAnimation:
		DC7_ ABCD 1 A_WeaponReady(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		TNT1 A 0 A_StopSound(CHAN_6);
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(39); }
		DC7_ A 1 Bright A_DoPBWeaponAction();
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 5, 2);
		Goto Ready3;
		TNT1 A 0 PBWP_CA_LockTilt();
		DC7_ E 1 Bright A_StopSound(CHAN_6);
		DC7_ F 1 Bright A_StartSound("ObliterationBFG/Fire", CHAN_WEAPON);
		DC7_ G 1 Bright { PBWP_DeracinatorFire(); }
		DC7_ H 1 Bright;
		TNT1 A 0 PBWP_CA_UnlockTilt();
		TNT1 A 0 A_StartSound("ObliterationBFG/Idle", CHAN_6, CHANF_LOOPING, 1, 0.5);
		TNT1 A 0 A_Refire();
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
		TNT1 A 3 Bright A_Light1();
		TNT1 A 3 Bright A_Light0();
		Goto LightDone;
	}
}
