// X40-DK Legionnaire — Cyberaugumented rocket launcher (folded from DCY_Legionnaire).

class PBWP_Legionnaire : PBWP_CA_WeaponBase
{
	default
	{
		Weapon.SlotNumber 5;
		Weapon.SlotPriority 0.12;
		Weapon.AmmoType1 "PB_RocketAmmo";
		Weapon.AmmoGive1 2;
		Weapon.AmmoUse1 1;
		+WEAPON.NOAUTOFIRE;
		+WEAPON.EXPLOSIVE;
		Tag "X40-DK Legionnaire";
		Inventory.PickupMessage "You got the Legionnaire! Time for a confetti party.";
		Inventory.PickupSound "dcy/rocketpickup";
		Inventory.Icon "RCK_Z0";
		Inventory.AltHudIcon "RCK_Z0";
		Obituary "%o was rocketed by %k's Legionnaire.";
	}

	action void PBWP_LegionnaireFire()
	{
		A_StartSound("RocketLauncher/Kaboom", CHAN_WEAPON, 0, 1.0, 0.85);
		A_FireCustomMissile("PBWP_CA_LegionnaireRocket", 0, 0);
		A_QuakeEx(1, 1, 1, 25, 0, 150, "none", QF_RELATIVE | QF_SCALEDOWN, falloff: 295);
		A_WeaponOffset(frandom(-3.5, 3.5), frandom(0, 4.35), WOF_ADD | WOF_INTERPOLATE);
		A_TakeInventory("PB_RocketAmmo", 1);
		A_GunFlash();
		PB_GunSmoke_Launcher(0, 0, 0);
		A_AlertMonsters();
		PB_QuakeCamera(25, 0.4);
	}

	states
	{
	Spawn:
		RCK_ Z -1;
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
		TNT1 A 0 PB_WeaponRaise("dcy/rocketpickup");
		TNT1 A 0 PB_WeapTokenSwitch("RLSelected");
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto SelectAnimation;
	SelectAnimation:
		RCC_ WXY 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		RCC_ YXW 1 A_WeaponOffset(0, 32);
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		RCC_ A 1 A_DoPBWeaponAction();
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PB_RocketAmmo", 1, 2);
		Goto Ready3;
		TNT1 A 0 PBWP_CA_LockTilt();
		RCC_ A 0;
		RCC_ ABC 1 A_DoPBWeaponAction(WRF_NOFIRE);
		RCC_ D 1 { PBWP_LegionnaireFire(); }
		RCC_ E 1 Bright A_DoPBWeaponAction(WRF_NOFIRE);
		RCC_ FGHI 1 Bright A_DoPBWeaponAction(WRF_NOFIRE);
		RCC_ J 0 A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY);
		RCC_ J 2 { A_WeaponOffset(0, 32, WOF_INTERPOLATE); PBWP_CA_UnlockTilt(); }
		RCC_ KLMN 2 A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY);
		RCC_ N 0 A_Refire();
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
		TNT1 B 2 Bright;
		TNT1 CD 3 Bright A_Light2();
		Goto LightDone;
	}
}
