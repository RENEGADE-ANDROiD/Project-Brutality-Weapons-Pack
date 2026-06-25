// Warbringer — Cyberaugumented DMR (folded from DCY_Cyberrifle).

class PBWP_Warbringer : PBWP_CA_WeaponBase
{
	default
	{
		Weapon.SlotNumber 4;
		Weapon.SlotPriority 0.12;
		Weapon.AmmoType1 "PB_HighCalMag";
		Weapon.AmmoType2 "PBWP_WarbringerMag";
		Weapon.AmmoGive1 0;
		Weapon.AmmoGive2 20;
		Weapon.AmmoUse1 0;
		Weapon.AmmoUse2 0;
		+WEAPON.WIMPY_WEAPON;
		+FLOORCLIP;
		Tag "Warbringer";
		Inventory.PickupMessage "The Warbringer! A mauve DMR from Cyberaugumented.";
		Inventory.PickupSound "dcy/riflepickup";
		Inventory.Icon "RIF_Z0";
		Inventory.AltHudIcon "RIF_Z0";
		Obituary "%o was perforated by %k's Warbringer.";
	}

	action void PBWP_WarbringerFire()
	{
		A_StartSound("Rifle/Fire", CHAN_WEAPON, CHANF_DEFAULT, 0.75);
		A_GunFlash();
		PB_FireBullets("PB_762x51mm", 1, 0.35, 0, 0, 0.35);
		PB_WeaponRecoil(-1.2, 0.4);
		PB_SpawnCasing("PB_EmptyBrass", 32, -2, 30, frandom(4, 7), frandom(6, 9), frandom(0, 5));
		PB_GunSmoke(0, 0, 0);
		A_FireCustomMissile("PBWP_CA_RifleTracer", random(-2, 2), 0, -1, 0, 0, random(-2, 2));
		A_AlertMonsters();
	}

	states
	{
	Spawn:
		RIF_ Z -1;
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
		TNT1 A 0 PB_WeaponRaise("dcy/riflepickup");
		TNT1 A 0 PB_WeapTokenSwitch("RifleSelected");
		TNT1 A 0 PB_SetMagUnloaded(false);
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto Ready3;
	SelectAnimation:
		RFL_ ABCDEF 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		RFL_ A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 { return PB_jumpIfNoAmmo("Reload", 1); }
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		RFL_ B 1 Bright;
		RFL_ C 1 Bright { PBWP_WarbringerFire(); PB_TakeAmmo("PBWP_WarbringerMag", 1, 0, 0); }
		RFL_ D 1 Bright;
		RFL_ E 1;
		RFL_ F 1 A_Refire("Fire");
		Goto Ready3;

		Reload:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 PBWP_CA_ReloadPreamble();
		TNT1 A 0 A_JumpIfInventory("PBWP_WarbringerMag", 20, "Ready3");
		TNT1 A 0 A_JumpIfInventory("PB_HighCalMag", 1, "DoReload");
		Goto Ready3;
	DoReload:
		RFL_ G 1 A_DoPBWeaponAction(WRF_NOFIRE);
		TNT1 A 0 A_PlaySound("weapons/rifle/magout", CHAN_AUTO);
		RFL_ H 2 A_DoPBWeaponAction(WRF_NOFIRE);
		TNT1 A 0 { return PB_JumpIfMagUnloaded("WarbringerMagIn"); }
		TNT1 A 0 A_FireCustomMissile("EmptyClipSpawn", -5, 0, 8, -4);
		TNT1 A 0 A_PlaySound("RIFCL_CL", CHAN_AUTO);
		RFL_ F 2 A_DoPBWeaponAction(WRF_NOFIRE);
		RFL_ B 2 A_DoPBWeaponAction(WRF_NOFIRE);
		TNT1 A 0 A_PlaySound("weapons/rifle/magin", CHAN_AUTO);
		RFL_ B 1 A_DoPBWeaponAction(WRF_NOFIRE);
		WarbringerMagIn:
		TNT1 A 0
		{
			PB_AmmoIntoMag("PBWP_WarbringerMag", "PB_HighCalMag", 20, 1, 1);
			PB_SetChamberEmpty(false);
			PB_SetMagEmpty(false);
			PB_SetMagUnloaded(false);
		}
		RFL_ B 1 A_DoPBWeaponAction(WRF_NOFIRE);
		RFL_ A 2 A_DoPBWeaponAction(WRF_NOFIRE);
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		Goto Ready3;

		Unload:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 { PB_SetMagUnloaded(true); PB_UnloadMag("PBWP_WarbringerMag", "PB_HighCalMag", 1, 1, 20, 0, null); }
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
