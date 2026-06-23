// Dispatcher of Delusions — Cyberaugumented plasma rifle (folded from DCY_RehauledPlasmaRifle).

class PBWP_Dispatcher : PBWP_CA_WeaponBase
{
	default
	{
		Weapon.SlotNumber 6;
		Weapon.SlotPriority 0.13;
		Weapon.AmmoType1 "PB_Cell";
		Weapon.AmmoGive1 40;
		Weapon.AmmoUse1 0;
		Tag "Dispatcher of Delusions - Mk.2 Corps Z10";
		Inventory.PickupMessage "You picked up the Dispatcher of Delusions! Let's make some barbecue.";
		Inventory.PickupSound "dcy/plasmariflepickup";
		Inventory.Icon "PLS_Z0";
		Inventory.AltHudIcon "PLS_Z0";
		Obituary "%o got fried into blue-colored dust by %k's Dispatcher of Delusions.";
	}

	action void PBWP_DispatcherFire()
	{
		A_GunFlash();
		A_WeaponOffset(frandom(-2.5, 2.5), frandom(31, 36), WOF_INTERPOLATE);
		A_FireCustomMissile("PBWP_CA_RehauledPlasma", 0, 0);
		A_TakeInventory("PB_Cell", 1);
		A_AlertMonsters();
	}

	states
	{
	Spawn:
		PLS_ Z -1;
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
		TNT1 A 0 PB_WeaponRaise("dcy/plasmariflepickup");
		TNT1 A 0 PB_WeapTokenSwitch("PlasmagunSelected");
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto SelectAnimation;
	SelectAnimation:
		PLG_ WXY 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		PLG_ YXW 1 A_WeaponOffset(0, 32);
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		PLG_ A 1 A_DoPBWeaponAction();
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 { return PB_jumpIfNoAmmo("Ready3", 1, false); }
		PLG_ BCD 1;
		Goto FireLoop;

		FireLoop:
		PLG_ E 1 Bright { PBWP_DispatcherFire(); }
		PLG_ FG 1 Bright A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY | WRF_NOBOB);
		PLG_ E 0 A_Refire("FireLoop");
		PLG_ HI 1 Bright A_Refire("FireLoop");
		Goto Ready3;

		Weaponspecial:
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		Goto Ready3;

		Reload:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 { return ResolveState("PBWP_OffsetReloadAnim"); }
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
		TNT1 A 2 Bright A_Light1();
		Goto LightDone;
	}
}
