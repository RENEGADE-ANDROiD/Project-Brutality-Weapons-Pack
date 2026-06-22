// Nightfall — Cyberaugumented minigun (folded from DCY_Minigun).

class PBWP_Nightfall : PBWP_CA_WeaponBase
{
	bool laserMode;

	default
	{
		Weapon.SlotNumber 5;
		Weapon.SlotPriority 0.14;
		Weapon.AmmoType1 "PB_HighCalMag";
		Weapon.AmmoType2 "PBWP_NightfallMag";
		Weapon.AmmoGive1 0;
		Weapon.AmmoGive2 200;
		+FLOORCLIP;
		+DONTGIB;
		Tag "Nightfall Augumented";
		Inventory.PickupMessage "You got the Nightfall! Chaotic firepower incoming.";
		Inventory.PickupSound "dcy/rocketpickup";
		Inventory.Icon "CH_GZ0";
		Obituary "%o was shredded by %k's Nightfall.";
	}

	action void PBWP_NightfallFire()
	{
		A_GunFlash();
		if (invoker.laserMode)
		{
			A_StartSound("Minigun/EmphasisLoop", CHAN_WEAPON, CHANF_DEFAULT, 1.0);
			PBWP_CA_FireMinigunLaser(35, 24);
			A_FireCustomMissile("PBWP_Tracer_Rifle", frandom(-1.2, 1.2), 0, 0, 0, 0, 0);
		}
		else
		{
			A_StartSound("Minigun/Loop", CHAN_WEAPON, CHANF_LOOPING, 0.65);
			A_QuakeEx(1, 1, 1, 20, 0, 100, "none", QF_SCALEDOWN, falloff: 200);
			PB_FireBullets("PB_762x51mm", 1, 0.75, 0, 0, 0.75);
			PB_WeaponRecoil(-0.5, 0.2);
			A_FireCustomMissile("PBWP_Tracer_Rifle", frandom(-1.2, 1.2), 0, 0, 0, 0, 0);
		}
		A_TakeInventory("PBWP_NightfallMag", 1);
		A_AlertMonsters();
	}

	states
	{
	Spawn:
		CH_G Z -1;
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
		TNT1 A 0 PB_WeapTokenSwitch("MinigunSelected");
		TNT1 A 0 PB_SetMagUnloaded(false);
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto Ready3;
	SelectAnimation:
		CHG_ WXY 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		CHG_ Y 0 A_StopSound(CHAN_WEAPON);
		CHG_ YXW 1;
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		CHG_ A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PBWP_NightfallMag", 1, 2);
		Goto Reload;
		TNT1 A 0 PBWP_CA_LockTilt();
		CHG_ F 1 Bright { PBWP_NightfallFire(); }
		CHG_ H 1 Bright A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOSWITCH);
		CHG_ H 0 Bright A_Refire("Fire");
		CHG_ A 1
		{
			A_StopSound(CHAN_WEAPON);
			A_StartSound("Minigun/WindDown", CHAN_WEAPON, 0, 0.75);
			PBWP_CA_UnlockTilt();
		}
		Goto Ready3;

		Reload:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 PB_CheckReload(null, "DoReload", null, "Ready3", "Ready3", 200, 1);
		Goto Ready3;
	DoReload:
		TNT1 A 10 { PB_AmmoIntoMag("PBWP_NightfallMag", "PB_HighCalMag", 200, 1, 1); }
		Goto Ready3;

		Unload:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 { PB_SetMagUnloaded(true); PB_UnloadMag("PBWP_NightfallMag", "PB_HighCalMag", 1, 1, 200, 0, null); }
		Goto Ready3;

		Weaponspecial:
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		TNT1 A 0 { invoker.laserMode = !invoker.laserMode; A_StartSound("WEPRED2", CHAN_AUTO); }
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
		Goto LightDone;
	}
}
